import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../util/functions.dart';
import 'feed_detail_controller.dart';

class FeedDetailView extends StatelessWidget {
  const FeedDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedDetailController());

    final createdAt = controller.feed.createdAt;
    final formattedDate =
        '${createdAt.year}.${createdAt.month.toString().padLeft(2, '0')}.${createdAt.day.toString().padLeft(2, '0')}';
    final formattedTime =
        '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: controller.onTapBackBtn,
        ),
        title: const Text('일기 상세'),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        actions: [
          Builder(
            builder: (context) {
              if (isSameDay(DateTime.now(), controller.feed.createdAt)) {
                /// 당일날 작성한 게시글만 수정 가능
                return PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      controller.onTapEditBtn();
                    }
                  },
                  color: Colors.white,
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('수정하기'),
                        ),
                      ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          controller.onTapBackBtn();
        },
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              /// 날짜 + 시간
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$formattedDate (${controller.feed.date}) · $formattedTime',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),

                  /// 기분
                  GetBuilder<FeedDetailController>(
                    id: ':mood',
                    builder: (context) {
                      return Container(
                        margin: EdgeInsets.only(right: 8.0),
                        child: Text(
                          controller.feed.mood.emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ),
                  Text(
                    controller.feed.mood.label,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// 내용
              GetBuilder<FeedDetailController>(
                id: ':content',
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: Text(
                      controller.feed.content,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
              const Divider(height: 24),

              /// 명언
              const Text(
                '📖 오늘의 한마디',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '“${controller.feed.recommendWise}”',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                '- ${controller.feed.recommendWiseWriter}',
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 24),
              const Divider(),

              /// 음악
              const Text(
                '🎵 추천 음악',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${controller.feed.recommendMusic} - ${controller.feed.recommendMusicArtist}',
              ),

              GetBuilder<FeedDetailController>(
                id: ':youtubePlayer',
                builder: (context) {
                  if(controller.isHidePlayer) {
                    return SizedBox.shrink();
                  } else {
                    return Container(
                      height: 240,
                      margin: const EdgeInsets.only(top: 24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: controller.youtubePlayerController,
                            showVideoProgressIndicator: false,
                            bottomActions: [
                              const SizedBox(width: 14.0),
                              const CurrentPosition(),
                              const SizedBox(width: 8.0),
                              ProgressBar(
                                isExpanded: true,
                                colors: const ProgressBarColors(),
                              ),
                              const RemainingDuration(),
                              const PlaybackSpeedButton(),
                              // const FullScreenButton(),
                            ],
                          ),
                          builder: (context, player) => Scaffold(body: player),
                        ),
                      ),
                    );
                  }

                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
