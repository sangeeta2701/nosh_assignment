
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nosh_task/Widgets/dishCarouselContainer.dart';
import 'package:nosh_task/Widgets/sizedbox.dart';
import 'package:nosh_task/utils/colors.dart';
import 'package:nosh_task/utils/constants.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wColor,
      appBar: AppBar(backgroundColor: bgColor,
      title: Text("Recipes",style: blackMainHeadingStyle,),
      centerTitle: true,
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined,color: gColor,))
      ],),
      body: ListView(
        children: [
          Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)
              ),
              image: DecorationImage(image: NetworkImage("https://nosh-assignment.s3.ap-south-1.amazonaws.com/paneer-tikka.jpg"),fit: BoxFit.cover,
              // colorFilter:
              //              ColorFilter.mode(bColor, BlendMode.srcOver),
                           )
            ),
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
                bottomRight: Radius.circular(12)
              ),
                                gradient: LinearGradient(colors: [
                                  gColor.withOpacity(0.2),
                                  bColor.withOpacity(0.5),
                                  bColor
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)
                                
                              ),
                              
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 20.w,
                  right: 20.w,
                  child: TextFormField(
                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    prefixIcon: Icon(Icons.search,color: bColor,size: 14.sp,),
                    fillColor: bgColor.withOpacity(0.6),
                    filled: true,
                    hintText: "Search",
                    hintStyle: blackContentgStyle,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: bgColor)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: bgColor)),
                  ),
                )),
                Positioned(
                  bottom: 70.h,
                  left: 20.w,
                  right: 20.w,
                  child: Text("Dish of the Day",style: whiteMainHeadingStyle,
                  textAlign: TextAlign.center,),),
                  Positioned(
                  bottom: 50.h,
                  left: 20.w,
                  right: 20.w,
                  child: Text("Paneer Tikka",style: whiteContentStyle,
                  textAlign: TextAlign.center,),),
                  Positioned(
                  bottom: 20.h,
                  
                  right: 20.w,
                  child: Icon(Icons.favorite,color: rColor,),)
              ],
            ),
          ),
          height12,
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text("Discover regional delights",style: blackMainHeadingStyle,),
          ),
          height8,
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    // scrollDirection: Axis.horizontal,
                    children: [
                    DishCarouselContainer(),
                    width12,
                    DishCarouselContainer(),
                    width12,
                    DishCarouselContainer(),
                    width12,
                    DishCarouselContainer(),
                  ],),
                  height20,
                ],
              ),
            ),
          ),
          Container(
            color: bColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 24,top: 16,bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Breakfast for ",style: wRecipeHeadingStyle,),
                  height8,
                   SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                // scrollDirection: Axis.horizontal,
                children: [
                DishCarouselContainer(),
                width12,
                DishCarouselContainer(),
                width12,
                DishCarouselContainer(),
                width12,
                DishCarouselContainer(),
              ],),
            ),
                ],
              ),
            ),
          ),
         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
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
                  offset: Offset(0, 3), // changes position of shadow
                ),
                ]
              ),
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
                      )
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 10.h,
                          right: 10.w,
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: gColor,)))
                      ],
                    ),
                  ),
                  height8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        height12,
                        Text("Bissi belle bhaath, North Karnataka style",style: blackMainHeadingStyle,),
                        height8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Row(children: [
                            Icon(Icons.timer_outlined,color: bColor,size: 12.sp,),
                            width4,
                            Text("20 minutes",style: blackContentgStyle,)
                          ],),
                          Row(children: [
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: greenColor,
                            ),
                            width4,
                            Text("Vegitarian",style: blackContentgStyle,),
                          ],)
                        ],),
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
                      ],),
                  )
                ]),
            ),
          )

        ],
      ),
    );
    
  }

  
}