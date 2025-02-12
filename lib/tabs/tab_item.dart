import 'package:flutter/material.dart';
import 'package:newss/data_model/SourceResponce.dart';

class TabItem extends StatelessWidget {
   TabItem({super.key , required this.isSelected , required this.source});
  bool isSelected ;
  Sources source ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected?Color(0xff44D4E6):Colors.grey.shade300,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.6),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(source.name??"News",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18,fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
