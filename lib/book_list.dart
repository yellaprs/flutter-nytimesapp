import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nytimes_app/bookItem.dart';
import 'package:nytimes_app/book_detail.dart';

class BookListPage extends StatefulWidget{

  BookListPage({Key key}): super(key: key);

  @override
  BookListPageState createState() => new BookListPageState();

}

class BookListPageState extends State<BookListPage>{

  List<BookItem> bookItems = new List();
  List<DropdownMenuItem<String>> bookListNames = new List<DropdownMenuItem<String>>();
  String currentBookList;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void fetchBookListCategories() async {

      List<DropdownMenuItem<String>> bookListNames = new List<DropdownMenuItem<String>>();

      Map<String, String> headers = new Map<String,String>();
      headers.putIfAbsent("apikey", () => "ec05b507b94648d6a34deb4a902a2b36");
      headers.putIfAbsent("Accept", () => "application/json");

      final response = await http.get('http://yellapragada-test.apigee.net/nytimes/books/v3/lists/names.json', headers:headers);

      if (response.statusCode == 200) {

        Map decode = json.decode(response.body);

        List results = decode['results'];

        bookListNames.add(new DropdownMenuItem(value : "none", child: Text("Select Category")));

        for (var jsonObject in results) {

          String item = jsonObject['list_name'];
          bookListNames.add(new DropdownMenuItem(value : item, child: Text(item)));
        }

      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load news');
      }

      setState(() {

        this.bookListNames = bookListNames;
         (this.bookListNames.length > 0) ? this.currentBookList = this.bookListNames[0].value:'';

      });
   }

  void  fetchArticles(String searchString) async {

    List<BookItem> bookItems = new List<BookItem>();


    Map<String, String> headers = new Map<String,String>();
    headers.putIfAbsent("apikey", () => "ec05b507b94648d6a34deb4a902a2b36");
    headers.putIfAbsent("Accept", () => "application/json");

    final response = await http.get('http://yellapragada-test.apigee.net/nytimes/books/v2/lists.json?list=' + searchString, headers:headers);

    if (response.statusCode == 200) {

      Map decode = json.decode(response.body);
      List results = decode['results'];

      for (var jsonObject in results) {

        var item = BookItem.fromJson(jsonObject);
        bookItems.add(item);

      }

    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load news');
    }

    setState(() {

      this.bookItems = bookItems;

    });
  }


  void initState(){
 
    this.fetchBookListCategories();
    super.initState();
   
  }

  @override
  void dispose() {

       super.dispose();
  }

  void changedDropDownItem(String currentBookList) {

    setState(() {
      this.currentBookList = currentBookList;
      validateCategory();
    });

  }

  void validateCategory(){

    final form = _formKey.currentState;
    if (form.validate()) {

       if(this.currentBookList.contains("none")){

         this.bookItems =  new List<BookItem>();

         _showSnackBar('Please select Bestseller Category');
       }
       else{

         this.fetchArticles(this.currentBookList);
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
            padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children:[
                new Container(
                  child: new Form(
                      key: _formKey,
                      autovalidate: true,
                      child: new Column(
                        children: [
                        new Row(
                        children: [
                          new Padding(
                              padding: new EdgeInsets.all(20.0),
                              child: new Container(
                                  alignment: Alignment.centerLeft,
                                  child: new DropdownButtonHideUnderline(
                                    child: new DropdownButton(
                                    elevation: 8,
                                    isDense : true,
                                    iconSize: 35.0,
                                    value: this.currentBookList,
                                    items: this.bookListNames,
                                    onChanged: changedDropDownItem,

                           )))),

                        ])

                       ],
                    ))),
                      
                   new Expanded(
                    child:new ListView.builder(
                      itemCount:this.bookItems.length,
                      padding: new EdgeInsets.symmetric(vertical: 8.0),
                      itemBuilder: (context, position) {

                        //String markdown = html2md.convert('<html><body>Author:' + bookItems[position].author + "<br>" + 'Publisher: ' + bookItems[position].publisher + "</body></html>");
                        return ListTile(
                          title: Text('${this.bookItems[position].title}', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
                          subtitle: Text('By ' + bookItems[position].author),
                          //trailing: Text('Publisher: ' + bookItems[position].publisher),
                          leading: new Image.asset("assets/" + '${this.bookItems[position].rank.trim()}' + ".png"),
                           onTap: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BookDetailPage(bookItem :bookItems[position])),
                            );
                           }
                        );},
                    )),

              ],)));
  }
}