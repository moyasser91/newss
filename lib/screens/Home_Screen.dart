import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:newss/data_model/SourceResponce.dart';
import 'package:newss/news/All_News/AllNewsWidget.dart';
import 'package:newss/screens/source_news.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data_model/ApiManegars.dart';
import '../data_model/NewsResponce.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Discover',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontSize: 27),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:Column(
          spacing: 15,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),

            Row(
              spacing: 8,
              children: [
                Container(
                  height: 48,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22)),
                  ),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName);
                      },
                      child: Image(
                          image: AssetImage('assets/images/homecolor.png'))),
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.start, // لجعل النص في المنتصف أفقيًا
                      textAlignVertical: TextAlignVertical
                          .center, // لجعل النص في المنتصف رأسيًا
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.grey, fontSize: 17),
                        border: InputBorder.none, // إزالة الحدود الافتراضية
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16), // ضبط الهوامش الداخلية
                        suffixIcon: InkWell(
                            onTap: () {
                              /// search
                            },
                            child: Icon(Icons.search,
                                color:
                                    Colors.black54)), // أيقونة في نهاية الحقل
                      ),
                    ),
                  ),
                )
              ],
            ),
            FutureBuilder<NewsResponce?>(
              future: ApiManagers.getNews('cnn'), // استبدل هذا بالدالة التي تجلب البيانات
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.cyan));
                } else if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong"));
                } else if (snapshot.data == null) {
                  return Center(child: Text("No news available"));
                }
                var newsList = snapshot.data!.articles;
                return Container(
                  width: double.infinity,
                  height: 180,
                  child: Swiper(
                    autoplay: true,
                    onTap: (index) async {
                      final url = newsList[index].url ?? 'https://google.com'; // تأكد أن الرابط ليس null
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                      } else {
                        print("Could not launch $url");
                      }
                      setState(() {

                      });
                    },
                    autoplayDelay: 4000, // تأخير 4 ثواني
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: CachedNetworkImage(
                      imageUrl: newsList[index].urlToImage != null
                      ? newsList[index].urlToImage!
                        : 'https://media.istockphoto.com/id/1339466666/vector/breaking-news.jpg?s=612x612&w=0&k=20&c=miuVhN91dJNC5xonwQrSndDTlFGdGrYz866M422cmBQ=',
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
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Directionality(
                                textDirection: Localizations.localeOf(context).languageCode == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container  (
                                      color:Color(0x76A8A8A8),
                                      child: Text(
                                        newsList[index].title ?? 'Eng M7md Algndy',
                                        style: TextStyle(fontSize: 17,color: Colors.white,),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );

                    },
                    itemCount: newsList!.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
                  ),
                );
              },
            ),
                 InkWell(
                   onTap:() {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SourceNews(),)) ;
                   },
                   child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('General',style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),),
                        Text('View All..',style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.cyan,fontSize: 15),),
                      ],
                    ),
                 ),
              Expanded(child: Allnewswidget())



          ],
        ),
      ),
    );
  }

  List<Sources>source =[] ;
}

