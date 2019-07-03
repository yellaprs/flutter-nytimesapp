
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nytimes_app/baseItem.dart';
import 'package:nytimes_app/newsItem.dart';
import 'package:nytimes_app/movieReviewItem.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsPage extends StatefulWidget{ 
 
  final String newsCategory;
  
  NewsPage({Key key, this.newsCategory}): super(key: key);  
     
  @override
  NewsPageState createState() => new NewsPageState(this.newsCategory);
  
}

class NewsPageState extends State<NewsPage>{

   String newsCategory;
   String status='';
   List<dynamic> newsItems = new List<dynamic>();   

   NewsPageState(String newsCategory){

     this.newsCategory = newsCategory;
     
   }

   void  fetchArticles() async {
        
        List<dynamic> newsItems = new List<dynamic>();

        Map<String, String> headers = new Map<String,String>();
        headers.putIfAbsent("apikey", () => "ec05b507b94648d6a34deb4a902a2b36");
        headers.putIfAbsent("Accept", () => "application/json");
        
        final response = await http.get('http://yellapragada-test.apigee.net/nytimes' + "${widget.newsCategory}", headers:headers);

        if (response.statusCode == 200) {

          Map decode = json.decode(response.body);
          List results = decode["results"];
         
          for (var jsonObject in results) {     

               switch ( newsCategory) {   

                  case '/topstories/v2/home.json':{

                    var item = NewsItem.fromJson(jsonObject);
                    newsItems.add(item);  
                    break;   
                  }
                  case '/search/v2/articlesearch.json':{
                     
                    var item = NewsItem.fromJson(jsonObject);
                    newsItems.add(item);  
                    break;             

                  }
                  case '/movies/v2/reviews/all.json': {

                    var item = MovieReviewItem.fromJson(jsonObject, newsCategory);
                    newsItems.add(item);  
                    break;  

                  }    

                 
                }
          }

        } else {
          // If that call was not successful, throw an error.
          throw Exception('Failed to load news');
        } 

       setState(() {
         
          this.newsItems = newsItems;
          this.status = 'ok';

       });
    }


    void initState(){

        super.initState();     
        this.fetchArticles();
    }

    @override
    Widget build(BuildContext context) {
         return new ListView.builder(
                    itemCount:this.newsItems.length,
                    padding: new EdgeInsets.symmetric(vertical: 8.0),
                    itemBuilder: (context, position) {
                    BaseItem baseItem = this.newsItems[position];
                    return ListTile(
                        title: Text('${baseItem.title}', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
                        subtitle: Text('${baseItem.description}'),
                        leading: (baseItem.thumbImage != null)? new Image.network(baseItem.thumbImage.replaceAll("\\", "")):new Icon(Icons.blur_circular),
                        onTap: () {

                             String type = baseItem.runtimeType.toString();

                             if(type.compareTo("NewsItem") == 0 ){

                                NewsItem newsItem = baseItem;

                                if(newsItem.url != null){

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => new WebviewScaffold(
                                        url: newsItem.url.replaceAll("\\", ""),
                                        appBar: new AppBar(
                                          title: new Text(baseItem.title),
                                        ),
                                      )));

                                }
                                

                             }else if(type.compareTo("MovieReviewItem") == 0 ){

                                MovieReviewItem movieItem = baseItem;

                                if(movieItem.url != null){

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => new WebviewScaffold(
                                        url: movieItem.url.replaceAll("\\", ""),
                                        appBar: new AppBar(
                                          title: new Text(movieItem.title),
                                        ),

                                      )));

                                }

                             }
                       }

                    );
          }
        );    
    }
}

  
