import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newss/data_model/ApiManegars.dart';
import 'package:newss/data_model/NewsResponce.dart';
import 'package:newss/news/All_News/AllNewsItem.dart';

import '../../screens/NewsDetails.dart';

class Allnewswidget extends StatelessWidget {
  const Allnewswidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponce?>(
      future: ApiManagers.getNews('abc-news'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.cyan));
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Something went Wrong",
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          );
        }
        if (snapshot.data == null || snapshot.data!.status != 'ok') {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data?.message ?? "Server Busy",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey)),
              ],
            ),
          );
        }
        var newsList = snapshot.data!.articles;
        if (newsList == null || newsList.isEmpty) {
          return Center(
            child: Text("No news available",
                style: Theme.of(context).textTheme.titleLarge),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return Allnewsitem(news: newsList[index]);
          },
          itemCount: newsList.length,
        );
      },
    );
  }
}