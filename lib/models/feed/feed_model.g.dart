// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedModel _$FeedModelFromJson(Map<String, dynamic> json) => _FeedModel(
  id: json['id'] as String,
  content: json['content'] as String,
  createdAt: const TimestampConverterNotNull().fromJson(json['createdAt']),
  date: json['date'] as String,
  mood: moodFromJson(json['mood'] as String?),
  recommendMusic: json['recommendMusic'] as String,
  recommendMusicArtist: json['recommendMusicArtist'] as String,
  recommendMusicThumbnailUrl: json['recommendMusicThumbnailUrl'] as String,
  recommendMusicVideoId: json['recommendMusicVideoId'] as String,
  recommendWise: json['recommendWise'] as String,
  recommendWiseWriter: json['recommendWiseWriter'] as String,
);

Map<String, dynamic> _$FeedModelToJson(_FeedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': const TimestampConverterNotNull().toJson(instance.createdAt),
      'date': instance.date,
      'mood': moodToJson(instance.mood),
      'recommendMusic': instance.recommendMusic,
      'recommendMusicArtist': instance.recommendMusicArtist,
      'recommendMusicThumbnailUrl': instance.recommendMusicThumbnailUrl,
      'recommendMusicVideoId': instance.recommendMusicVideoId,
      'recommendWise': instance.recommendWise,
      'recommendWiseWriter': instance.recommendWiseWriter,
    };
