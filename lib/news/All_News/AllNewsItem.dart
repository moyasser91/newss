import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newss/data_model/NewsResponce.dart';

import '../../screens/NewsDetails.dart';

class Allnewsitem extends StatelessWidget {
  final News news;

  const Allnewsitem({required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // عند الضغط على الخبر نفتح صفحة التفاصيل
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewsDetailsScreen(
            title: news.title ?? 'No Title',
            imageUrl: news.urlToImage ?? '',
            description: news.content ?? 'No Content Available',
            url: news.url ?? 'https://google.com',
            source: news.author ?? 'Algndy',
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: 120),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 130,
                  height: 115,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: news.urlToImage ?? 'https://media.istockphoto.com/id/1339466666/vector/breaking-news.jpg?s=612x612&w=0&k=20&c=miuVhN91dJNC5xonwQrSndDTlFGdGrYz866M422cmBQ=',
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 45, bottom: 45),
                        child: CircularProgressIndicator(color: Colors.cyan),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Text(
                        news.title ?? 'No Title',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          news.description ?? 'No Description',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12, color: Colors.grey),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.access_time,size: 16, color: Colors.grey.shade600),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                news.publishedAt != null
                                    ? _getFormattedTime(news.publishedAt!)
                                    : 'News Algndy',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 12.4, color: Colors.grey.shade500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFormattedTime(String publishedAt) {
    DateTime publishedDate = DateTime.parse(publishedAt);
    int hour = publishedDate.hour;
    int minute = publishedDate.minute;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;
    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }
}
