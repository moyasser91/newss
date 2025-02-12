import 'package:flutter/material.dart';
import 'package:newss/data_model/NewsResponce.dart';
import 'package:newss/data_model/SourceResponce.dart';
import 'package:newss/news/All_News/AllNewsWidget.dart';
import 'package:newss/news/news_by_id/new_item.dart';
import 'package:newss/news/news_by_id/newsWidget.dart';
import 'package:newss/tabs/tab_item.dart';



class Tabwidget extends StatefulWidget {
   Tabwidget({super.key, required this.sourcesList});
  List<Sources> sourcesList ;
  @override
  State<Tabwidget> createState() => _TabwidgetState();
}

class _TabwidgetState extends State<Tabwidget> {
  int selectedIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TabBar(
                onTap: (index) {
                  selectedIndex = index ;
                  setState(() {

                  });
                },
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.transparent,
                isScrollable: true,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                indicatorWeight: 2,
                dividerHeight: 0,
                labelPadding: EdgeInsets.all(5),
                tabs: widget.sourcesList.map((source) => TabItem(
                    isSelected: selectedIndex == widget.sourcesList.indexOf(source),
                    source: source),).toList()
              ),
            ) ,
           // Expanded(child: Allnewswidget())
            Expanded(child: Newswidget(sourcesId: widget.sourcesList[selectedIndex])),
          ],
        ));
  }
}
