import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constant/converter/timestamp_converter.dart';
import '../../constant/enum/mood.dart';

part 'feed_model.freezed.dart';
part 'feed_model.g.dart';

@freezed
abstract class FeedModel with _$FeedModel {
  const factory FeedModel({
    required String id,
    required String content,
    @TimestampConverterNotNull()
    required DateTime createdAt,
    required String date,
    @JsonKey(fromJson: moodFromJson, toJson: moodToJson)
    required Mood mood,
    required String recommendMusic,
    required String recommendMusicArtist,
    required String recommendMusicThumbnailUrl,
    required String recommendMusicVideoId,
    required String recommendWise,
    required String recommendWiseWriter,
  }) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);
}

// JSON 매핑 함수
Mood moodFromJson(String? value) =>
    Mood.values.firstWhere((e) => e.name == value);

String? moodToJson(Mood mood) => mood.name;