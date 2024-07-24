import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nosh_task/Widgets/sizedbox.dart';
import 'package:nosh_task/utils/colors.dart';
import 'package:nosh_task/utils/constants.dart';

import '../model/dishListData.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  void initState() {
    super.initState();
    fetchDish();
  }

  bool _isFavorited = true;
  void _markFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }

  List<DishListData> dishList = [];
  Future<void> fetchDish() async {
    try {
      final response = await http
          .get(Uri.parse(
              "https://fls8oe8xp7.execute-api.ap-south-1.amazonaws.com/dev/nosh-assignment"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var _dish = dishListDataFromJson(response.body);

        setState(() {
          dishList = _dish;
        });
        // final data = json.decode(response.body);

        if (_dish.isEmpty) {
          print('Error: No data received');
        } else {
          print('Data received: $_dish');
        }
      } else {
        print('Error: Server Error ${response.statusCode}');
      }
    } on SocketException {
      // Handle no internet connection error
      throw FetchDataException("No Internet Connection");
    } on TimeoutException {
      // Handle connection timeout error
      throw FetchDataException("Connection Timeout");
    } on http.ClientException {
      // Handle client-side errors
      throw FetchDataException("Something went wrong please try again");
      // print('Error: Client-side error');
    } on Exception catch (e) {
      throw FetchDataException("{$e}");
      // Handle any other exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          "Recipes",
          style: blackMainHeadingStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border_outlined,
                color: gColor,
              ))
        ],
      ),
      body: dishList.isEmpty?Center(child: CircularProgressIndicator(),): ListView(
        children: [
          Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://nosh-assignment.s3.ap-south-1.amazonaws.com/paneer-tikka.jpg"),
                  fit: BoxFit.cover,
                  // colorFilter:
                  //              ColorFilter.mode(bColor, BlendMode.srcOver),
                )),
            child: Stack(
              children: [
                Positioned(
                  top: 0.h,
                  bottom: 0.h,
                  left: 0.w,
                  right: 0.w,
                  child: Container(
                    height: 300.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                        gradient: LinearGradient(
                            colors: [
                              gColor.withOpacity(0.2),
                              bColor.withOpacity(0.5),
                              bColor
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                ),
                Positioned(
                    top: 10.h,
                    left: 20.w,
                    right: 20.w,
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        prefixIcon: Icon(
                          Icons.search,
                          color: bColor,
                          size: 14.sp,
                        ),
                        fillColor: bgColor.withOpacity(0.6),
                        filled: true,
                        hintText: "Search",
                        hintStyle: blackContentgStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: bgColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: bgColor)),
                      ),
                    )),
                Positioned(
                  bottom: 70.h,
                  left: 20.w,
                  right: 20.w,
                  child: Text(
                    "Dish of the Day",
                    style: whiteMainHeadingStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: 50.h,
                  left: 20.w,
                  right: 20.w,
                  child: Text(
                    "Paneer Tikka",
                    style: whiteContentStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  right: 20.w,
                  child: Icon(
                    Icons.favorite,
                    color: rColor,
                  ),
                )
              ],
            ),
          ),
          height12,
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              "Discover regional delights",
              style: blackMainHeadingStyle,
            ),
          ),
          height8,
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: SizedBox(
              height: 230.h,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dishList.length,
                  itemBuilder: (context, index) {
                    var dish = dishList[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        width: 190.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: wColor,
                            boxShadow: [
                              BoxShadow(
                                color: gColor.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 130.h,
                                decoration: BoxDecoration(
                                    color: rColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    image: DecorationImage(
                                        image: NetworkImage(dish.imageUrl),
                                        fit: BoxFit.cover)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        bottom: 10.h,
                                        right: 10.w,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.favorite,
                                              color: gColor,
                                            )))
                                  ],
                                ),
                              ),
                              height8,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dish.dishName,
                                      style: bRecipeHeadingStyle,
                                    ),
                                    height4,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer_outlined,
                                              color: bColor,
                                              size: 12.sp,
                                            ),
                                            width4,
                                            Text(
                                              "20 minutes",
                                              style: blackContentgStyle,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 4,
                                              backgroundColor: greenColor,
                                            ),
                                            width4,
                                            Text(
                                              "Vegitarian",
                                              style: blackContentgStyle,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    height4,
                                    RatingBar.builder(
                                      initialRating: 5,
                                      itemSize: 14.sp,
                                      //  minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      //  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: gColor,
                                        //  size: 8.sp,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    height8,
                                  ],
                                ),
                              )
                            ]),
                      ),
                    );
                  }),
            ),
          ),
          Container(
            color: bColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, top: 16, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Breakfast for ",
                    style: wRecipeHeadingStyle,
                  ),
                  height8,
                  SizedBox(
                    height: 230.h,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dishList.length,
                        itemBuilder: (context, index) {
                          var dish = dishList[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              width: 190.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: wColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: gColor.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 130.h,
                                      decoration: BoxDecoration(
                                          color: rColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                          ),
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(dish.imageUrl),
                                              fit: BoxFit.cover)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              bottom: 10.h,
                                              right: 10.w,
                                              child: IconButton(
                                                  onPressed: () {
                                                    _markFavorite();
                                                  },
                                                  icon: _isFavorited
                                                      ? Icon(
                                                          Icons
                                                              .favorite_border_outlined,
                                                          color: gColor,
                                                        )
                                                      : Icon(
                                                          Icons.favorite,
                                                          color: rColor,
                                                        )))
                                        ],
                                      ),
                                    ),
                                    height8,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dish.dishName,
                                            style: bRecipeHeadingStyle,
                                          ),
                                          height4,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer_outlined,
                                                    color: bColor,
                                                    size: 12.sp,
                                                  ),
                                                  width4,
                                                  Text(
                                                    "20 minutes",
                                                    style: blackContentgStyle,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 4,
                                                    backgroundColor: greenColor,
                                                  ),
                                                  width4,
                                                  Text(
                                                    "Vegitarian",
                                                    style: blackContentgStyle,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          height4,
                                          RatingBar.builder(
                                            initialRating: 5,
                                            itemSize: 14.sp,
                                            //  minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            //  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: gColor,
                                              //  size: 8.sp,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          height8,
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: dishList.length,
                itemBuilder: (context, index) {
                  var dish = dishList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Container(
                      width: double.infinity,
                      height: 320.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: wColor,
                          boxShadow: [
                            BoxShadow(
                              color: gColor.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200.h,
                              decoration: BoxDecoration(
                                  color: rColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(dish.imageUrl),
                                      fit: BoxFit.cover)),
                              child: Stack(
                                children: [
                                  Positioned(
                                      bottom: 10.h,
                                      right: 10.w,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.favorite,
                                            color: gColor,
                                          )))
                                ],
                              ),
                            ),
                            height8,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  height12,
                                  Text(
                                    dish.dishName,
                                    style: blackMainHeadingStyle,
                                  ),
                                  height8,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer_outlined,
                                            color: bColor,
                                            size: 12.sp,
                                          ),
                                          width4,
                                          Text(
                                            "20 minutes",
                                            style: blackContentgStyle,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 4,
                                            backgroundColor: greenColor,
                                          ),
                                          width4,
                                          Text(
                                            "Vegitarian",
                                            style: blackContentgStyle,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  height8,
                                  RatingBar.builder(
                                    initialRating: 5,
                                    itemSize: 14.sp,
                                    //  minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    //  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: gColor,
                                      //  size: 8.sp,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  height8,
                                ],
                              ),
                            )
                          ]),
                    ),
                  );
                }),
          ),
          height30,
        ],
      ),
    );
  }
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);
}
