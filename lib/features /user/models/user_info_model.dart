import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:raftlabs_newsfeed/features%20/constants/firebase_fields.dart';
import 'package:raftlabs_newsfeed/features%20/constants/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, String?> {
  final UserId userId;
  final String displayName;
  final String? email;
  final String photoUrl;

  UserInfoModel({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.photoUrl,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName,
            FirebaseFieldName.email: email,
            FirebaseFieldName.photoUrl: photoUrl,
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
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email &&
          photoUrl == other.photoUrl;

  @override
  int get hashCode => Object.hashAll(
        [
          userId,
          displayName,
          email,
          photoUrl,
        ],
      );
}