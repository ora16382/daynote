import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter/timestamp_converter.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    String? name,
    String? email,
    String? displayName,
    String? selectedMood,
    @TimestampConverter() DateTime? createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}