import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nosh_task/Widgets/sizedbox.dart';
import 'package:nosh_task/utils/colors.dart';
import 'package:nosh_task/utils/constants.dart';

class DishCarouselContainer extends StatefulWidget {
  const DishCarouselContainer({super.key});

  @override
  State<DishCarouselContainer> createState() => _DishCarouselContainerState();
}

class _DishCarouselContainerState extends State<DishCarouselContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
            width: 190.w,
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
                  height: 130.h,
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dish Name",style: bRecipeHeadingStyle,),
                      height4,
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
                    ],),
                )
              ]),
          );
  }
}