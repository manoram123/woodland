import 'package:flutter/material.dart';
import 'package:woodlands_flutter/constants.dart';
import 'package:woodlands_flutter/http/http.dart';

import '../utilities/getColors.dart';

Widget Cart(context, String id, String title, String imgPath, bool isFavorite,
    String price, String description) {
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
            width: 130.0,
            height: 130.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: NetworkImage("$host/$imgPath"),
              ),
            ),
          ),
          SizedBox(width: 4.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Row(
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
                  ],
                ),
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
            ],
          )
        ],
      ),
    ),
  );
}
