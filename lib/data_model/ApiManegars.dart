import 'dart:convert';

import 'package:http/http.dart' as http ;
import 'package:newss/data_model/NewsResponce.dart';
import 'package:newss/data_model/SourceResponce.dart';
import 'package:newss/data_model/api_constans.dart';
class ApiManagers{
  // https://newsapi.org/v2/top-headlines/sources?apiKey=32b6603601384e2d9a26ccfb3175c2d4
  static Future<SourceResponce?> getSource()async{
    Uri url = Uri.https(
      ApiConstance.baseUrl ,
      ApiConstance.sourceApi,
      {
        'apiKey' : ApiConstance.apiKey,
      }
    );
    try{
    var responce = await http.get(url);
    var responceBody = responce.body ;
    var json = jsonDecode(responceBody);
    return SourceResponce.fromJson(json);
    // SourceResponce.fromJson(jsonDecode(responce.body)); السطر دا اختصار 3 اللي فوق
  }catch(e)
    {
      throw e ;
    }

  }
// https://newsapi.org/v2/top-headlines?country=us&apiKey=32b6603601384e2d9a26ccfb3175c2d4
  // https://newsapi.org/v2/everything?q=bitcoin&apiKey=32b6603601384e2d9a26ccfb3175c2d4

 static Future<NewsResponce?> getNewsbySourceId(String sourceId)async{
    Uri url = Uri.https(
      ApiConstance.baseUrl,
      ApiConstance.newsApi,
      {
         'apiKey' : ApiConstance.apiKey,
        'sources' : sourceId,

      }
    );
    try{
      var responce = await http.get(url);
     var responceBody = responce.body ;
     var json = jsonDecode(responceBody);
     return NewsResponce.fromJson(json);
    }catch(e){
      throw e ;
    }
 }

  static Future<NewsResponce?> getNews(String id)async{
    Uri url = Uri.https(
        ApiConstance.baseUrl,
        ApiConstance.newsApi,
        {
          'apiKey' : ApiConstance.apiKey,
          'sources' : id,

        }
    );
    try{
      var responce = await http.get(url);
      var responceBody = responce.body ;
      var json = jsonDecode(responceBody);
      return NewsResponce.fromJson(json);
    }catch(e){
      throw e ;
    }
  }
}

