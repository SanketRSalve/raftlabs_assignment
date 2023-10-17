import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:raftlabs_newsfeed/features%20/authentication/repositories/authentication.dart';
import 'package:raftlabs_newsfeed/features%20/authentication/models/auth_state.dart';
import 'package:raftlabs_newsfeed/features%20/user/models/user_info_model.dart';
import 'package:raftlabs_newsfeed/features%20/user/repositories/user_info_storage.dart';

import '../../constants/user_id.dart';

/// Providers

final userIdProvider =
    Provider<UserId?>((ref) => ref.watch(authStateProvider).userId);

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (ref) => AuthStateNotifier());

/// Providers

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: _authenticator.userId);
    }
  }

  UserInfoModel getUserDetails() {
    return UserInfoModel(
      userId: _authenticator.userId!,
      displayName: _authenticator.displayName,
      photoUrl: _authenticator.photoUrl!,
      email: _authenticator.email,
      followers: [],
      followings: [],
    );
  }

  Future<void> logOut() async {
    state = state.copyWith(true);
    await _authenticator.logout();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );
    }
    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
        photoUrl: _authenticator.photoUrl,
      );

  // Future<void> followUser(
  //   String uid,
  //   String followId,
  // ) async {
  //   try {
  //     DocumentSnapshot snap =
  //         await _firestore.collection('users').doc(uid).get();
  //     List followings = (snap.data()! as dynamic)['followings'];

  //     if (followings.contains(followId)) {
  //       await _firestore.collection('users').doc(followId).update({
  //         'followers': FieldValue.arrayRemove([uid])
  //       });

  //       await _firestore.collection('users').doc(uid).update({
  //         'followings': FieldValue.arrayRemove([uid])
  //       });
  //     } else {
  //       await _firestore.collection('users').doc(followId).update({
  //         'followers': FieldValue.arrayUnion([uid])
  //       });

  //       await _firestore.collection('users').doc(uid).update({
  //         "followings": FieldValue.arrayUnion([uid])
  //       });
  //     }
  //     ;
  //   } catch (e) {}
  // }
}
