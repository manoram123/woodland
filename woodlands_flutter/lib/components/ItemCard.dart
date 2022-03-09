import 'package:flutter/material.dart';
import 'package:woodlands_flutter/constants.dart';
import 'package:woodlands_flutter/http/http.dart';
import 'package:woodlands_flutter/utilities/notification.dart';

import '../utilities/getColors.dart';

Widget itemCard(context, String id, String title, String imgPath,
    bool isFavorite, String price, String description) {
  bool fav = isFavorite;

  return Padding(
    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
    child: Container(
      height: 150.0,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 140.0,
            height: 140.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: NetworkImage("$host/$imgPath"),
              ),
            ),
          ),
          SizedBox(width: 4.0),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 95,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 45.0),
                  InkWell(
                    onTap: () {},
                    child: Material(
                      elevation: isFavorite ? 0.0 : 2.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: isFavorite
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.white),
                        child: Center(
                          child: isFavorite
                              ? Icon(Icons.favorite_border)
                              : Icon(Icons.favorite, color: Colors.red),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.0),
              Container(
                width: 175.0,
                child: Text(
                  '$description',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.grey,
                      fontSize: 12.0),
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                children: <Widget>[
                  SizedBox(width: 35.0),
                  Container(
                    height: 40.0,
                    width: 50.0,
                    color: Color(getColorHexFromStr('#F9C335')),
                    child: Center(
                      child: Text(
                        'RS.\n$price',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w900,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var res = await HttpConnectUser().addToCart(id);
                      print(res);
                      if (res['type'] == "success") {
                        notify("$title", "$title has been added to your cart",
                            "https://images.idgesg.net/images/article/2019/01/android-q-notification-inbox-100785464-large.jpg?auto=webp&quality=85,70");
                      }
                    },
                    child: Container(
                      height: 40.0,
                      width: 100.0,
                      color: Color(getColorHexFromStr('#FEDD59')),
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}
