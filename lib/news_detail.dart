
import 'package:flutter/material.dart';
import 'package:nytimes_app/newsItem.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_html_view/flutter_html_view.dart';

class NewsDetailPage extends StatefulWidget{

  final NewsItem newsItem;

  NewsDetailPage({Key key, NewsItem this.newsItem}):super(key: key);  

  @override
  NewsDetailPageState createState() => new NewsDetailPageState(newsItem);

}

class NewsDetailPageState extends State<NewsDetailPage>{

   NewsItem newsItem;
   String response;

   NewsDetailPageState(NewsItem newsItem){

     this.newsItem = newsItem;
  }

  Future<String> fetchArticle() async {  
       
        String responseBody;

        final response = await http.get(this.newsItem.url.replaceAll("\\",""));

        if (response.statusCode == 200) {

          var decode = response.body;
          //responseBody = decode['content'];
          return decode.toString();

        } else {
          // If that call was not successful, throw an error.
          throw Exception('Failed to load news');
        }  
              
    }

  void initState(){
 
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: fetchArticle(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                   return  new SingleChildScrollView(
                        child: new Center(
                               child: new HtmlView(data: snapshot.data),
                              ),
                    );
              

              } else if (snapshot.hasError) {

                return Text("${snapshot.error}");

              }
            },
          ),
        ),
      );

  }

}