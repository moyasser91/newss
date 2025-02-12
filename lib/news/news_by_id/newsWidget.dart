import 'package:flutter/material.dart';
import 'package:newss/data_model/ApiManegars.dart';
import 'package:newss/data_model/NewsResponce.dart';
import 'package:newss/news/news_by_id/new_item.dart';
import '../../data_model/SourceResponce.dart';

class Newswidget extends StatelessWidget {
   Newswidget({super.key , required this.sourcesId});
 Sources sourcesId ;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponce?>(
        future: ApiManagers.getNewsbySourceId(sourcesId.id??''),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color:Colors.cyan,));
          }
          else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                spacing: 20,
                children: [
                  Text("Something went Wrong",
                      style: Theme.of(context).textTheme.titleLarge),
                  ElevatedButton(onPressed: () => ApiManagers.getSource(), child: Text('Try Again'))

                ],
              ),
            );
          }
          if (snapshot.data == null || snapshot.data!.status != 'ok') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing:50,
                children: [
                  Text(snapshot.data?.message ?? "No Internet Conection!",
                      style: Theme.of(context).textTheme.titleLarge),
                  ElevatedButton(onPressed: () => ApiManagers.getNewsbySourceId(sourcesId.id??'',), child: Text('Try Again')
                  ),
                ],
              ),
            );
          }
          if (snapshot.data == null || snapshot.data!.status != 'ok') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing:50,
                children: [
                  Text(snapshot.data?.message ?? "Unknown error",
                      style: Theme.of(context).textTheme.titleLarge),
                  ElevatedButton(onPressed: () => ApiManagers.getNewsbySourceId(sourcesId.id??''), child: Text('Try Again')
                  ),
                ],
              ),
            );
          }
          var newsList = snapshot.data!.articles ;
          return ListView.builder(itemBuilder: (context, index) {
            return NewItem(news: newsList![index]);
          },
          itemCount: newsList?.length ,
          );


        },);
  }
}
