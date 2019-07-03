import 'package:nytimes_app/baseItem.dart';

class NewsItem  extends BaseItem{

  String publishedDate;
  String normalImage;
  String url;

  NewsItem(String title, String thumbImage, String description, String normalImage, String publishedDate, String url){

         super.title = title;
         super.thumbImage = thumbImage;
         super.description = description;
         this.normalImage = normalImage;
         this.publishedDate = publishedDate;
         this.url = url;
  }

  factory NewsItem.fromJson(Map<String, dynamic> json) {

     var imageListobj;
     String thumbImage;
     String normalImage;
     var newsItem;
     String publishedDate;
     String url;


    if(json['multimedia'] != null){
            
            imageListobj = json['multimedia'];
     }

     for (var imageObject in imageListobj) {      
            
        if(imageObject != null && imageObject['url'] != null ){
               
               if(imageObject['format'].toString().compareTo("Standard Thumbnail") == 0){

                 thumbImage = imageObject['url'];

               }else if(imageObject['format'].toString().compareTo("Normal") == 0) {

                  normalImage = imageObject['url'];
               }

         }
     }

     newsItem = NewsItem(json['title'], thumbImage, json['abstract'], normalImage, publishedDate, json['url']);
     
     return newsItem;    
  }

}