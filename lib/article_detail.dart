
import 'package:flutter/material.dart';
import 'package:nytimes_app/articleItem.dart';


class ArticleDetailPage extends StatefulWidget{

  final ArticleItem articleItem;

  ArticleDetailPage({Key key, ArticleItem this.articleItem}):super(key: key);  

  @override
  ArticleDetailPageState createState() => new ArticleDetailPageState(this.articleItem);

}

class ArticleDetailPageState extends State<ArticleDetailPage>{

   ArticleItem articleItem;

   ArticleDetailPageState(ArticleItem articleItem){

     this.articleItem = articleItem;
   }

   void initState(){
     
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
       appBar: AppBar(
           
          title: Center(child :Text(this.articleItem.title, textAlign : TextAlign.center)),
      ),    
        
      body: new Container(
        constraints: new BoxConstraints.expand(),
        child: new ListView(
              padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
              children: <Widget>[               
                new Container(
                  padding: new EdgeInsets.symmetric(horizontal: 32.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[                     
                      new Container(
                         margin: new EdgeInsets.symmetric(vertical: 8.0),
                         height: 2.0,
                         width: 18.0
                      ),
                      new Text(this.articleItem.description,  textAlign: TextAlign.left , style: new TextStyle(fontSize: 16.0)),
                      new Container(
                         margin: new EdgeInsets.symmetric(vertical: 8.0),
                         height: 2.0,
                         width: 18.0
                      ),                    

                    ],
                  ),
                ),
              ],
            ),
          ));
          
    }

}