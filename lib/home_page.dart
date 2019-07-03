import 'package:flutter/material.dart';
import 'package:nytimes_app/news_page.dart';
import 'package:nytimes_app/book_list.dart';

import 'package:nytimes_app/article_search.dart';
class HomePage extends StatelessWidget{  

  HomePage();

  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
           title: new Center(child:new Image.asset("assets/newyorktimes.jpg", fit: BoxFit.cover)),
           backgroundColor : Colors.yellowAccent,
           bottom: TabBar(
              tabs: [
                Tab(text : 'Headlines', icon: new Image.asset("assets/news.png")),
                Tab(text : 'Movie Reviews', icon: new Image.asset("assets/countdown.png")),
                Tab(text : 'Article Search', icon: new Image.asset("assets/articles.png")),
                Tab(text : 'BestSellers', icon: new Image.asset("assets/bestseller.png")),
              ],
             //color: Colors.yellowAccent,
          ),
          //title: Center(child :Text('New York Times', textAlign : TextAlign.center)),
        ),
        body: TabBarView(
          children: [
            NewsPage(newsCategory: "/topstories/v2/home.json"),
            NewsPage(newsCategory: "/movies/v2/reviews/all.json"),
            ArticleSearchPage(),
            BookListPage(),
          ],
        ),
         
      ),
     );

   }
  }