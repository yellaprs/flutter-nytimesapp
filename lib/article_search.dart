import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nytimes_app/articleItem.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleSearchPage extends StatefulWidget{

  
  ArticleSearchPage({Key key}): super(key: key);  
     
  @override
  ArticleSearchPageState createState() => new ArticleSearchPageState();
  
}

class ArticleSearchPageState extends State<ArticleSearchPage>{
  
   final myController = TextEditingController(); 
   List<ArticleItem> newsItems = new List();
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   void  fetchArticles(String searchString) async {
        
        List<ArticleItem> newsItems = new List<ArticleItem>();

        Map<String, String> headers = new Map<String,String>();
        headers.putIfAbsent("apikey", () => "ec05b507b94648d6a34deb4a902a2b36");
        headers.putIfAbsent("Accept", () => "application/json");
        
        final response = await http.get('http://yellapragada-test.apigee.net/nytimes/search/v2/articlesearch.json?q=' + searchString, headers:headers);

        if (response.statusCode == 200) {

          Map decode = json.decode(response.body);

          var body = decode['response'];

          List results = body['docs'];

          for (var jsonObject in results) {            

               var item = ArticleItem.fromJson(jsonObject);
               newsItems.add(item);       
          }

        } else {
          // If that call was not successful, throw an error.
          throw Exception('Failed to load news');
        }


    }


    void initState(){

        super.initState();     

    }

   @override
   void dispose() {
     // Clean up the controller when the Widget is disposed
     myController.dispose();
     super.dispose();
   }

   void validateSearchInput(String searchString){

     final form = _formKey.currentState;
     if (form.validate()) {

       if(searchString.trim().length == 0){

         _showSnackBar('Please enter article search keyword');
       }
       else{

         this.fetchArticles(searchString);
       }
     }
   }

   void _showSnackBar(message) {

     final snackBar = new SnackBar(

       content: new Text(message),

     );
     _scaffoldKey.currentState.showSnackBar(snackBar);
   }

   @override
    Widget build(BuildContext context) {

     return new Scaffold(
         key: _scaffoldKey,
         body: new Padding(
                            padding: new EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children:[
                                    new Container(
                                     child: new Form(
                                            key: _formKey,
                                            autovalidate: true,
                                    child: new Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      new Padding(
                                          padding: new EdgeInsets.all(8.0),
                                          child: new SizedBox(
                                            width: 200.0,
                                            height: 40.0,

                                            child: TextField(
                                              controller: myController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Please enter a search term'
                                            ),
                                        ))),
                                       new Padding(
                                        padding: new EdgeInsets.all(8.0),
                                        child: new IconButton(
                                          icon: new Icon(Icons.search),
                                          tooltip: 'Search Articles',
                                          onPressed: () {

                                         setState(() {
                                            validateSearchInput(myController.text);

                                          });

                                          },
                                        )
                                      ),
                                      ])
                                    )),
                                    new Expanded(
                                        child:new ListView.builder(
                                            itemCount:this.newsItems.length,
                                            padding: new EdgeInsets.symmetric(vertical: 8.0),
                                            itemBuilder: (context, position) {
                                            //String markdown = html2md.convert(newsItems[position].description);
                                            return ListTile(
                                              title: Text('${this.newsItems[position].title}', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
                                              subtitle: Text('${newsItems[position].description}'),
                                              //leading: new Image.network("http://www.nytimes.com/" + this.newsItems[position].thumbImage.replaceAll("\\", "")),

                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        new WebviewScaffold(
                                                          url: this
                                                              .newsItems[position]
                                                              .url.replaceAll(
                                                              "\\", ""),
                                                          appBar: new AppBar(
                                                            title: new Text(this
                                                                .newsItems[position]
                                                                .title),
                                                          ),

                                                        )
                                                    )
                                                );
                                              }
                                            );},
                                    )),

           ],)));
    }
}