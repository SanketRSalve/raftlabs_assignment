import 'dart:collection';
import 'package:flutter/foundation.dart' show immutable;
import 'package:raftlabs_newsfeed/features%20/constants/firebase_fields.dart';
import 'package:raftlabs_newsfeed/features%20/constants/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, dynamic> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
    required String? photoUrl,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName ?? '',
          FirebaseFieldName.email: email ?? '',
          FirebaseFieldName.photoUrl: photoUrl ?? '',
        });
}
