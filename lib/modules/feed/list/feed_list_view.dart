import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../models/feed/feed_model.dart';
import '../../../util/app_color.dart';
import 'feed_list_controller.dart';

class FeedListView extends StatelessWidget {
  const FeedListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedController());

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: GetBuilder<FeedController>(
          id: ':feedList',
          builder: (controller) {
            return PagingListener(
              controller: controller.pagingController,
              builder: (context, state, fetchNextPage) {
                return RefreshIndicator(
                  onRefresh: controller.onRefresh,
                  child: PagedListView<int, FeedModel>(
                    state: state,
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate<FeedModel>(
                      itemBuilder: (context, feed, index) {
                        final createdAt = feed.createdAt;
                        final formattedDate =
                            '${createdAt.year}.${createdAt.month.toString().padLeft(2, '0')}.${createdAt.day.toString().padLeft(2, '0')}';
                        final formattedTime =
                            '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';

                        return GestureDetector(
                          onTap: (){
                            controller.onTapFeedCard(feed);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16.0),
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// 날짜 & 시간
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '$formattedDate (${feed.date})',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          formattedTime,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),

                                    /// 내용
                                    Text(
                                      feed.content,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Divider(),
                                    Row(
                                      children: [
                                        /// 음악
                                        Expanded(
                                          child: Text(
                                            '🎵 ${feed.recommendMusic} - ${feed.recommendMusicArtist}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        const SizedBox(width: 8),

                                        /// 기분 (이미지)
                                        Text(
                                          feed.mood.emoji,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (context) {
                        return Center(
                          child: Image.asset('assets/images/no_data_feed_image.png'),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: controller.onTapWriteFeed,
        child: Icon(Icons.edit_square, color: AppColors.whiteText),
      ),
    );
  }
}
