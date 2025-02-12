import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newss/data_model/NewsResponce.dart';

class NewItem extends StatelessWidget {
  News news;
  NewItem({required this.news});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage ??
                      'https://media.istockphoto.com/id/1339466666/vector/breaking-news.jpg?s=612x612&w=0&k=20&c=miuVhN91dJNC5xonwQrSndDTlFGdGrYz866M422cmBQ=',
                  placeholder: (context, url) => Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 45, bottom: 45),
                    child: CircularProgressIndicator(
                      color: Colors.cyan,
                    ),
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Text(
                news.title ?? 'News Algndy',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 16),
              ),
              Text(
                news.content ??
                    'Breaking news and at the specified times with us here in our application News Algndy',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
              ),
              Text(
                news.author ?? 'News Algndy',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 16),
              ),
              // Text(news.content??'News Algndy',style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      Container(
                        height: 38,
                        width: 38,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Image.network(
                          'https://media.istockphoto.com/id/1339466666/vector/breaking-news.jpg?s=612x612&w=0&k=20&c=miuVhN91dJNC5xonwQrSndDTlFGdGrYz866M422cmBQ=' ??
                              '${news.urlToImage}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        news.source?.name ?? 'Algndy',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 3,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 19,
                        color: Colors.grey.shade600,
                      ),
                      Text(
                        news.publishedAt != null
                            ? _getFormattedTime(news.publishedAt!)
                            : 'News Algndy',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 14.4, color: Colors.grey.shade600),
                      ),
                    ],
                  )
                ],
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
    hour = hour == 0 ? 12 : hour; // لتحويل الساعة 0 إلى 12
    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }
}
