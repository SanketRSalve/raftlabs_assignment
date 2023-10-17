import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:raftlabs_newsfeed/features%20/constants/firebase_fields.dart';
import 'package:raftlabs_newsfeed/features%20/constants/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, dynamic> {
  final UserId userId;
  final String displayName;
  final String? email;
  final String photoUrl;
  final List followers;
  final List followings;

  UserInfoModel({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.followers,
    required this.followings,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName,
            FirebaseFieldName.email: email,
            FirebaseFieldName.photoUrl: photoUrl,
            FirebaseFieldName.followers: followers,
            FirebaseFieldName.followings: followings,
          },
        );

  UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          displayName: json[FirebaseFieldName.displayName] ?? '',
          email: json[FirebaseFieldName.email],
          photoUrl: json[FirebaseFieldName.photoUrl],
          followers: json[FirebaseFieldName.followers],
          followings: json[FirebaseFieldName.followings],
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email &&
          photoUrl == other.photoUrl &&
          followers == other.followers &&
          followings == other.followings;

  @override
  int get hashCode => Object.hashAll(
        [
          userId,
          displayName,
          email,
          photoUrl,
          followers,
          followings,
        ],
      );
}
