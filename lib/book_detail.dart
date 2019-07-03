//import 'dart:convert';

//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nytimes_app/bookItem.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class BookDetailPage extends StatefulWidget{

  final BookItem bookItem;

  BookDetailPage({Key key, BookItem this.bookItem}):super(key: key);  

  @override
  BookDetailPageState createState() => new BookDetailPageState(this.bookItem);

}

class BookDetailPageState extends State<BookDetailPage>{

   BookItem bookItem;

   BookDetailPageState(BookItem bookItem){

     this.bookItem = bookItem;
   }

   void initState(){
 
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> reviewList = new List<Widget>();

    if(this.bookItem.reviews.length > 0) {
      //reviewList.add(new Text("Review", textAlign: TextAlign.left, style: new TextStyle(fontWeight:FontWeight.bold,fontSize: 20.0)));
      //}
      for (var review in this.bookItem.reviews) {
        reviewList.add(RaisedButton(
          child: Text("View The New York Times Review", style: new TextStyle(fontWeight:FontWeight.bold,fontSize: 20.0)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                new WebviewScaffold(
                  url: review.replaceAll("\\", ""),
                  appBar: new AppBar(
                    title: new Text(this.bookItem.title),
                  ),

                )
                )
            );
          },
        ));
      }
    }

    return new Scaffold(
       appBar: AppBar(
           
          title: Center(child :Text(this.bookItem.title, textAlign : TextAlign.center)),

      ),    
        
      body: new Container(
        constraints: new BoxConstraints.expand(),
        child: new ListView(
              padding: new EdgeInsets.fromLTRB(0.0, 42.0, 0.0, 32.0),
              children: <Widget>[
                //new PlanetSummary(planet,
                //  horizontal: false,
                //),
                new Container(
                  padding: new EdgeInsets.symmetric(horizontal: 32.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[


                      new Text("Author", textAlign: TextAlign.left , style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      new Text(bookItem.author, textAlign: TextAlign.left , style: new TextStyle(fontSize: 18.0)),
                      new Container(
                         margin: new EdgeInsets.symmetric(vertical: 8.0),
                         height: 2.0,
                         width: 18.0
                      ),

                      new Text("Bestseller Category", textAlign: TextAlign.left , style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      new Text(bookItem.listName, textAlign: TextAlign.left , style: new TextStyle(fontSize: 18.0)),
                      new Container(
                          margin: new EdgeInsets.symmetric(vertical: 8.0),
                          height: 2.0,
                          width: 18.0
                      ),

                      new Text("Rank", textAlign: TextAlign.center , style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      new Image.asset("assets/" + bookItem.rank.toString().trim() + ".png"),
                      new Container(
                          margin: new EdgeInsets.symmetric(vertical: 8.0),
                          height: 2.0,
                          width: 18.0
                      ),

                      new Text("Bestseller Date", textAlign: TextAlign.center, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      new Text(bookItem.bestsellerDate , textAlign: TextAlign.center, style: new TextStyle(fontSize: 18.0)),
                      new Container(
                         margin: new EdgeInsets.symmetric(vertical: 8.0),
                         height: 2.0,
                         width: 18.0
                      ),

                      new Text("Publisher", textAlign: TextAlign.left , style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      new Text(bookItem.publisher, textAlign: TextAlign.left , style: new TextStyle(fontSize: 18.0)),
                      new Container(
                          margin: new EdgeInsets.symmetric(vertical: 8.0),
                          height: 2.0,
                          width: 18.0
                      ),

                      new Text("Published Date", textAlign: TextAlign.center, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      new Text(bookItem.publishedDate , textAlign: TextAlign.center, style: new TextStyle(fontSize: 18.0)),  //style: Style.headerTextStyle,),
                      new Container(
                         margin: new EdgeInsets.symmetric(vertical: 8.0),
                         height: 2.0,
                         width: 18.0
                      ),

                      new Text("Summary", textAlign: TextAlign.center, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      new Text(this.bookItem.description, textAlign: TextAlign.left, style: new TextStyle(fontSize: 18.0)),
                      new Container(
                         margin: new EdgeInsets.symmetric(vertical: 8.0),
                         height: 2.0,
                         width: 18.0
                      ),


                      new Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                      //   constraints: new BoxConstraints.expand(),
                           children: reviewList,
                      ),
                             
                      //new ListView.builder(
                      //     itemCount:this.bookItem.reviews.length,
                      //     padding: new EdgeInsets.symmetric(vertical: 8.0),
                      //     itemBuilder: (context, position) {
                      //     return ListTile(
                      //       title: Text('${this.bookItem.reviews[position]}'),
                      //       //subtitle: Text('${bookItems[position].description}'),
                      //       //leading: new Image.network("http://www.nytimes.com/" + this.bookItems[position].bookThumbImage.replaceAll("\\", "")),
                      //       onTap: () {

                      //         Navigator.push(
                      //                 context,                                  
                      //                 MaterialPageRoute(builder: (context) => new WebviewScaffold(
                      //                 url: this.bookItem.reviews[position].replaceAll("\\", ""),
                      //                 appBar: new AppBar(
                      //                     title: new Text(this.bookItem.title),
                      //                 ),
                              
                      //                 )
                      //            )
                      //           );
                      //         }
                      //         //Navigator.push(
                      //          //  context,
                      //         //   MaterialPageRoute(builder: (context) => BookDetailPage(bookItem :bookItems[position])),
                      //        );
                      //       }
                      //   )),                       
                        
                    // //))

                    ],
                  ),
                ),
              ],
            ),
          ));
          
    }

}