import 'package:daynote/constant/enum/age_group.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../constant/converter/timestamp_converter.dart';
import '../../constant/enum/music_genre.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    String? name,
    String? email,
    String? displayName,
    @JsonKey(fromJson: ageGroupFromJson, toJson: ageGroupToJson)
    AgeGroup? ageGroup,
    @JsonKey(fromJson: musicGenresFromJson, toJson: musicGenresToJson)
    List<MusicGenre>? musicGenres,
    @TimestampConverter() DateTime? createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

AgeGroup? ageGroupFromJson(String? value) {
  return AgeGroup.values.firstWhereOrNull((e) => e.name == value);
}

String? ageGroupToJson(AgeGroup? value) => value?.name;

// from JSON (문자열 리스트 → enum 리스트)
List<MusicGenre>? musicGenresFromJson(List<dynamic>? list) {
  return list
      ?.map((e) => MusicGenre.values.firstWhereOrNull((g) => g.name == e))
      .whereType<MusicGenre>()
      .toList();
}

// to JSON (enum 리스트 → 문자열 리스트)
List<String>? musicGenresToJson(List<MusicGenre>? genres) {
  return genres?.map((g) => g.name).toList();
}
