import 'package:nytimes_app/baseItem.dart';

class BookItem extends BaseItem{

  String author;
  String publishedDate;
  String bestsellerDate;
  String rank;
  String publisher;
  String isbn;
  String listName;
  List<String> reviews = new List<String>();

  BookItem(String title, String thumbImage, String description, String author, String listName,
      String publishedDate,String bestsellerDate, String rank, String publisher, String isbn, List<String> reviews){

         super.title = title;
         super.thumbImage = thumbImage;
         super.description = description;
         this.author = author;
         this.rank = rank;
         this.publisher = publisher;
         this.publishedDate = publishedDate;
         this.bestsellerDate = bestsellerDate;
         this.isbn = isbn;
         this.reviews = reviews;
         this.listName = listName;

  }


  factory BookItem.fromJson(Map<String, dynamic> json) {

    var image;
    List bookJson = json['book_details'];
    List reviewList = json['reviews'];
    var bookItem;
    Map bookDetails = bookJson[0];
    List<String> reviews = new List<String>();
   
    for (var review in reviewList){

        if(review['book_review_link'].toString().length > 0){

            reviews.add(review['book_review_link'].toString());
        }
    }

    bookItem = BookItem(
       bookDetails['title'],
      ((image != null)?image['url'] : ""),
      bookDetails['description'],
      bookDetails['author'],
      json['list_name'],
      json['published_date'],
      json['bestsellers_date'],
      (json['rank'] == "null")? "Not Available":json['rank'].toString(),
      bookDetails['publisher'],     
      bookDetails['isbn'],

      reviews);
      
    return bookItem;
  }

}