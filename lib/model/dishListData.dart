// To parse this JSON data, do
//
//     final dishListData = dishListDataFromJson(jsonString);

import 'dart:convert';

List<DishListData> dishListDataFromJson(String str) => List<DishListData>.from(json.decode(str).map((x) => DishListData.fromJson(x)));

String dishListDataToJson(List<DishListData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DishListData {
    String dishName;
    String dishId;
    String imageUrl;
    bool isPublished;

    DishListData({
        required this.dishName,
        required this.dishId,
        required this.imageUrl,
        required this.isPublished,
    });

    factory DishListData.fromJson(Map<String, dynamic> json) => DishListData(
        dishName: json["dishName"],
        dishId: json["dishId"],
        imageUrl: json["imageUrl"],
        isPublished: json["isPublished"],
    );

    Map<String, dynamic> toJson() => {
        "dishName": dishName,
        "dishId": dishId,
        "imageUrl": imageUrl,
        "isPublished": isPublished,
    };
}
