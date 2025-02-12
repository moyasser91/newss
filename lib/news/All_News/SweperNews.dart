import 'package:flutter/cupertino.dart';
import 'package:newss/data_model/NewsResponce.dart';

class Swepernews extends StatelessWidget {
   Swepernews({super.key , required this.news});
  News news ;
  @override
  Widget build(BuildContext context) {
    return Image(image: NetworkImage(news.urlToImage??'https://media.istockphoto.com/id/1339466666/vector/breaking-news.jpg?s=612x612&w=0&k=20&c=miuVhN91dJNC5xonwQrSndDTlFGdGrYz866M422cmBQ='));
  }
}
