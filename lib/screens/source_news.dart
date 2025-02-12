import 'package:flutter/material.dart';
import 'package:newss/data_model/ApiManegars.dart';
import 'package:newss/data_model/SourceResponce.dart';
import 'package:newss/tabs/TabWidget.dart';

class SourceNews extends StatefulWidget {
  const SourceNews({super.key});

  @override
  State<SourceNews> createState() => _SourceNewsState();
}

class _SourceNewsState extends State<SourceNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'News ...',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: FutureBuilder<SourceResponce?>(
        future: ApiManagers.getSource(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xff44D4E6),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Text("Something went Wrong",
                      style: Theme.of(context).textTheme.titleLarge),
                  ElevatedButton(
                      onPressed: () => ApiManagers.getSource(),
                      child: Text('Try Again'))
                ],
              ),
            );
          }
          // تحقق من أن البيانات موجودة وأن الحالة "ok"
          if (snapshot.data == null || snapshot.data!.status != 'ok') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 50,
                children: [
                  Text(snapshot.data?.message ?? "Unknown error",
                      style: Theme.of(context).textTheme.titleLarge),
                  ElevatedButton(
                      onPressed: () => ApiManagers.getSource(),
                      child: Text('Try Again')),
                ],
              ),
            );
          }
          var sourceList = snapshot.data!.sources;
          // تحقق من أن sourceList موجودة
          if (sourceList == null || sourceList.isEmpty) {
            return Center(
              child: Text("No sources available",
                  style: Theme.of(context).textTheme.titleLarge),
            );
          }
          // عرض البيانات في ListView
          return Tabwidget(sourcesList: sourceList);
        },
      ),
    );
  }
}
