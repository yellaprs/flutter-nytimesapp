import 'package:nytimes_app/baseItem.dart';

class ArticleItem  extends BaseItem{

  String url;
  
  ArticleItem(String title, String thumbImage, String description, String url){

         super.title = title;
         super.thumbImage = thumbImage;
         super.description = description;
         this.url = url;

  }



  factory ArticleItem.fromJson(Map<String, dynamic> json) {

    // var jsonobj = json['description'];
     var imageListobj;
     var image;
     var newsItem;
     var headline = json['headline'];

    if(json['multimedia'] != null){
            
            imageListobj = json['multimedia'];
     }

     for (var imageObject in imageListobj) {      
            
             if(image == null && imageObject != null && imageObject['url'] != null ){
               
               image = imageObject;
             }
     }

     newsItem = ArticleItem(headline['main'],((image != null)?image['url'] : "") , json['snippet'], json['web_url']);
     
     return newsItem;    
  }
}