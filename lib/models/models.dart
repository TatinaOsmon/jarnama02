// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  const Product(
      {required this.images,
      required this.title,
      required this.description,
      required this.phoneNumber,
      required this.dateTime,
      this.price,
      required this.adress,
      required this.userName});

  final List<String>? images;
  final String title;
  final String description;
  final String phoneNumber;
  final String dateTime;
  final String? price;
  final String adress;
  final String userName;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'images': images,
      'title': title,
      'description': description,
      'phoneNumber': phoneNumber,
      'dateTime': dateTime,
      'price': price,
      'adress': adress,
      'userName': userName,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      images: map['images'] != null
          ? List<String>.from(
              ((map['images']) as List<String>),
            )
          : null,
      title: (map["title"] ?? '') as String,
      description: (map["description"] ?? '') as String,
      phoneNumber: (map["phoneNumber"] ?? '') as String,
      dateTime: (map["dateTime"] ?? '') as String,
      // ignore: unnecessary_cast
      price: map['price'] != null ? map["price"] ?? '' as String : null,
      adress: (map["adress"] ?? '') as String,
      userName: (map["userName"] ?? '') as String,
    );
  }
}
