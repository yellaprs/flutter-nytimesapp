import 'package:flutter/material.dart';
import 'package:nytimes_app/movieReviewItem.dart';


class MovieReviewDetailPage extends StatefulWidget{

  final MovieReviewItem movieItem;

  MovieReviewDetailPage({Key key, MovieReviewItem this.movieItem}):super(key: key);  

  @override
  MovieReviewDetailPageState createState() => new MovieReviewDetailPageState(movieItem);

}

class MovieReviewDetailPageState extends State<MovieReviewDetailPage>{

   MovieReviewItem movieItem;

   MovieReviewDetailPageState(MovieReviewItem movieItem){

     this.movieItem = movieItem;
  }

  void initState(){
 
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
       appBar: AppBar(
           
          title: Center(child :Text(this.movieItem.title, textAlign : TextAlign.center)),
      ),    
        
      body: new Container(
        constraints: new BoxConstraints.expand(),
        child: new ListView(
              padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
              children: <Widget>[
                //new PlanetSummary(planet,
                //  horizontal: false,
                //),
                new Container(
                  padding: new EdgeInsets.symmetric(horizontal: 32.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       new Container(
                        margin: new EdgeInsets.symmetric(vertical: 8.0),
                        child: new Image.network(this.movieItem.thumbImage.replaceAll("\\", "")),
 
                      ),
                      new Container(
                         margin: new EdgeInsets.symmetric(vertical: 8.0),
                         height: 2.0,
                         width: 18.0
                      ),
                      new Text(this.movieItem.description.substring(this.movieItem.description.indexOf("Review") + 8),  textAlign: TextAlign.left , style: new TextStyle(fontSize: 20.0)),
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