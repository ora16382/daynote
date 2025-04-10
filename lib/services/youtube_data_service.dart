// lib/services/openai_service.dart


import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../util/api/youtube_data_api.dart';

class YoutubeDataService extends GetxService {
  YoutubeDataAPI youtubeDataAPI = YoutubeDataAPI();

  Future<Map<String, dynamic>> selectYoutubeDataInfo({
    required String prompt,
  }) async {
    Response response = await youtubeDataAPI.requestYoutubeData(prompt: prompt);

    if(response.statusCode == HttpStatus.ok){
      return (response.body as Map<String, dynamic>)['items'][0];
    } else {
      throw Exception('youtube api 요청중 에러가 발생하였습니다.${response.body}');
    }
  }
}
