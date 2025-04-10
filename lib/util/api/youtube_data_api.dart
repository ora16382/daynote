// lib/services/openai_service.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class YoutubeDataAPI extends GetConnect {
  static const String _baseUrl = 'https://www.googleapis.com/youtube/v3';

  YoutubeDataAPI(){
    httpClient.baseUrl = _baseUrl;
  }

  Future<Response> requestYoutubeData({
    required String prompt,
  }) {
    final Map<String, dynamic> query = {
      'part': 'snippet',
      'q': prompt,
      'type' : 'video',
      'maxResults': 1.toString(),
      'key': dotenv.env['YOUTUBE_API_KEY'],
    };

    return get('/search', query: query);
  }
}
