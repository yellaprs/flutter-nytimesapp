 import 'package:nytimes_app/baseItem.dart';
 
 class MovieReviewItem  extends BaseItem{

  String publicationDate;
  String url;

  MovieReviewItem(String title, String thumbImage, String description, String publicationDate, String url){
    
     super.description = description;
     super.title = title;
     super.thumbImage = thumbImage;
     this.publicationDate = publicationDate;
     this.url = url;

  }


  factory MovieReviewItem.fromJson(Map<String, dynamic> json, var category ) {


     var imageListobj = json['multimedia'];
     var movieReviewItem;
                
     movieReviewItem = MovieReviewItem(json['headline'],imageListobj['src'],json['summary_short'], json['publication_date'], json['link']['url']);
     
     return movieReviewItem;
   }

 }