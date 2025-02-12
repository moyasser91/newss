import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newss/data_model/NewsResponce.dart';

class Allnewsitem extends StatelessWidget {
  final News news;

  const Allnewsitem({required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0,bottom: 5),
        child: InkWell(
          onTap: () {
            print("News tapped: ${news.title}");
          },
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 125),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    height: 133,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: news.urlToImage ?? 'https://media.istockphoto.com/id/1339466666/vector/breaking-news.jpg?s=612x612&w=0&k=20&c=miuVhN91dJNC5xonwQrSndDTlFGdGrYz866M422cmBQ=',
                      fit: BoxFit.cover,
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
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 17),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            news.description ?? 'No Title',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 13,color: Colors.grey),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              news.publishedAt != null
                                  ? _getFormattedTime(news.publishedAt!)
                                  : 'News Algndy',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 14.4, color: Colors.grey.shade500),
                            ),
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