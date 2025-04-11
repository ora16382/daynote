// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedModel {

 String get id; String get content;@TimestampConverterNotNull() DateTime get createdAt; String get date;@JsonKey(fromJson: moodFromJson, toJson: moodToJson) Mood get mood; String get recommendMusic; String get recommendMusicArtist; String get recommendMusicThumbnailUrl; String get recommendMusicVideoId; String get recommendWise; String get recommendWiseWriter;
/// Create a copy of FeedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedModelCopyWith<FeedModel> get copyWith => _$FeedModelCopyWithImpl<FeedModel>(this as FeedModel, _$identity);

  /// Serializes this FeedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.date, date) || other.date == date)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.recommendMusic, recommendMusic) || other.recommendMusic == recommendMusic)&&(identical(other.recommendMusicArtist, recommendMusicArtist) || other.recommendMusicArtist == recommendMusicArtist)&&(identical(other.recommendMusicThumbnailUrl, recommendMusicThumbnailUrl) || other.recommendMusicThumbnailUrl == recommendMusicThumbnailUrl)&&(identical(other.recommendMusicVideoId, recommendMusicVideoId) || other.recommendMusicVideoId == recommendMusicVideoId)&&(identical(other.recommendWise, recommendWise) || other.recommendWise == recommendWise)&&(identical(other.recommendWiseWriter, recommendWiseWriter) || other.recommendWiseWriter == recommendWiseWriter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,createdAt,date,mood,recommendMusic,recommendMusicArtist,recommendMusicThumbnailUrl,recommendMusicVideoId,recommendWise,recommendWiseWriter);

@override
String toString() {
  return 'FeedModel(id: $id, content: $content, createdAt: $createdAt, date: $date, mood: $mood, recommendMusic: $recommendMusic, recommendMusicArtist: $recommendMusicArtist, recommendMusicThumbnailUrl: $recommendMusicThumbnailUrl, recommendMusicVideoId: $recommendMusicVideoId, recommendWise: $recommendWise, recommendWiseWriter: $recommendWiseWriter)';
}


}

/// @nodoc
abstract mixin class $FeedModelCopyWith<$Res>  {
  factory $FeedModelCopyWith(FeedModel value, $Res Function(FeedModel) _then) = _$FeedModelCopyWithImpl;
@useResult
$Res call({
 String id, String content,@TimestampConverterNotNull() DateTime createdAt, String date,@JsonKey(fromJson: moodFromJson, toJson: moodToJson) Mood mood, String recommendMusic, String recommendMusicArtist, String recommendMusicThumbnailUrl, String recommendMusicVideoId, String recommendWise, String recommendWiseWriter
});




}
/// @nodoc
class _$FeedModelCopyWithImpl<$Res>
    implements $FeedModelCopyWith<$Res> {
  _$FeedModelCopyWithImpl(this._self, this._then);

  final FeedModel _self;
  final $Res Function(FeedModel) _then;

/// Create a copy of FeedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? createdAt = null,Object? date = null,Object? mood = null,Object? recommendMusic = null,Object? recommendMusicArtist = null,Object? recommendMusicThumbnailUrl = null,Object? recommendMusicVideoId = null,Object? recommendWise = null,Object? recommendWiseWriter = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,recommendMusic: null == recommendMusic ? _self.recommendMusic : recommendMusic // ignore: cast_nullable_to_non_nullable
as String,recommendMusicArtist: null == recommendMusicArtist ? _self.recommendMusicArtist : recommendMusicArtist // ignore: cast_nullable_to_non_nullable
as String,recommendMusicThumbnailUrl: null == recommendMusicThumbnailUrl ? _self.recommendMusicThumbnailUrl : recommendMusicThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,recommendMusicVideoId: null == recommendMusicVideoId ? _self.recommendMusicVideoId : recommendMusicVideoId // ignore: cast_nullable_to_non_nullable
as String,recommendWise: null == recommendWise ? _self.recommendWise : recommendWise // ignore: cast_nullable_to_non_nullable
as String,recommendWiseWriter: null == recommendWiseWriter ? _self.recommendWiseWriter : recommendWiseWriter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FeedModel implements FeedModel {
  const _FeedModel({required this.id, required this.content, @TimestampConverterNotNull() required this.createdAt, required this.date, @JsonKey(fromJson: moodFromJson, toJson: moodToJson) required this.mood, required this.recommendMusic, required this.recommendMusicArtist, required this.recommendMusicThumbnailUrl, required this.recommendMusicVideoId, required this.recommendWise, required this.recommendWiseWriter});
  factory _FeedModel.fromJson(Map<String, dynamic> json) => _$FeedModelFromJson(json);

@override final  String id;
@override final  String content;
@override@TimestampConverterNotNull() final  DateTime createdAt;
@override final  String date;
@override@JsonKey(fromJson: moodFromJson, toJson: moodToJson) final  Mood mood;
@override final  String recommendMusic;
@override final  String recommendMusicArtist;
@override final  String recommendMusicThumbnailUrl;
@override final  String recommendMusicVideoId;
@override final  String recommendWise;
@override final  String recommendWiseWriter;

/// Create a copy of FeedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedModelCopyWith<_FeedModel> get copyWith => __$FeedModelCopyWithImpl<_FeedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.date, date) || other.date == date)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.recommendMusic, recommendMusic) || other.recommendMusic == recommendMusic)&&(identical(other.recommendMusicArtist, recommendMusicArtist) || other.recommendMusicArtist == recommendMusicArtist)&&(identical(other.recommendMusicThumbnailUrl, recommendMusicThumbnailUrl) || other.recommendMusicThumbnailUrl == recommendMusicThumbnailUrl)&&(identical(other.recommendMusicVideoId, recommendMusicVideoId) || other.recommendMusicVideoId == recommendMusicVideoId)&&(identical(other.recommendWise, recommendWise) || other.recommendWise == recommendWise)&&(identical(other.recommendWiseWriter, recommendWiseWriter) || other.recommendWiseWriter == recommendWiseWriter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,createdAt,date,mood,recommendMusic,recommendMusicArtist,recommendMusicThumbnailUrl,recommendMusicVideoId,recommendWise,recommendWiseWriter);

@override
String toString() {
  return 'FeedModel(id: $id, content: $content, createdAt: $createdAt, date: $date, mood: $mood, recommendMusic: $recommendMusic, recommendMusicArtist: $recommendMusicArtist, recommendMusicThumbnailUrl: $recommendMusicThumbnailUrl, recommendMusicVideoId: $recommendMusicVideoId, recommendWise: $recommendWise, recommendWiseWriter: $recommendWiseWriter)';
}


}

/// @nodoc
abstract mixin class _$FeedModelCopyWith<$Res> implements $FeedModelCopyWith<$Res> {
  factory _$FeedModelCopyWith(_FeedModel value, $Res Function(_FeedModel) _then) = __$FeedModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String content,@TimestampConverterNotNull() DateTime createdAt, String date,@JsonKey(fromJson: moodFromJson, toJson: moodToJson) Mood mood, String recommendMusic, String recommendMusicArtist, String recommendMusicThumbnailUrl, String recommendMusicVideoId, String recommendWise, String recommendWiseWriter
});




}
/// @nodoc
class __$FeedModelCopyWithImpl<$Res>
    implements _$FeedModelCopyWith<$Res> {
  __$FeedModelCopyWithImpl(this._self, this._then);

  final _FeedModel _self;
  final $Res Function(_FeedModel) _then;

/// Create a copy of FeedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? createdAt = null,Object? date = null,Object? mood = null,Object? recommendMusic = null,Object? recommendMusicArtist = null,Object? recommendMusicThumbnailUrl = null,Object? recommendMusicVideoId = null,Object? recommendWise = null,Object? recommendWiseWriter = null,}) {
  return _then(_FeedModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,recommendMusic: null == recommendMusic ? _self.recommendMusic : recommendMusic // ignore: cast_nullable_to_non_nullable
as String,recommendMusicArtist: null == recommendMusicArtist ? _self.recommendMusicArtist : recommendMusicArtist // ignore: cast_nullable_to_non_nullable
as String,recommendMusicThumbnailUrl: null == recommendMusicThumbnailUrl ? _self.recommendMusicThumbnailUrl : recommendMusicThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,recommendMusicVideoId: null == recommendMusicVideoId ? _self.recommendMusicVideoId : recommendMusicVideoId // ignore: cast_nullable_to_non_nullable
as String,recommendWise: null == recommendWise ? _self.recommendWise : recommendWise // ignore: cast_nullable_to_non_nullable
as String,recommendWiseWriter: null == recommendWiseWriter ? _self.recommendWiseWriter : recommendWiseWriter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
