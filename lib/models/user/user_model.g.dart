// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  uid: json['uid'] as String,
  name: json['name'] as String?,
  email: json['email'] as String?,
  displayName: json['displayName'] as String?,
  ageGroup: ageGroupFromJson(json['ageGroup'] as String?),
  musicGenres: musicGenresFromJson(json['musicGenres'] as List?),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'displayName': instance.displayName,
      'ageGroup': ageGroupToJson(instance.ageGroup),
      'musicGenres': musicGenresToJson(instance.musicGenres),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
