import 'package:flutter/material.dart';
import 'package:woodlands_flutter/constants.dart';
import 'package:woodlands_flutter/http/http.dart';

import '../utilities/getColors.dart';
import '../utilities/parseToken.dart';
import 'ItemCard.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  var items = null;

  var user = null;

  getUser() async {
    var data = await parseToken();
    print(data);
    setState(() {
      user = data;
    });
  }

  Future getItems(String category) async {
    var res = await HttpConnectUser().getProducts(category);
    print(res);
    setState(() {
      items = res['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    getItems("sofa");
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 250.0,
                  width: double.infinity,
                  color: Color(getColorHexFromStr('#FDD148')),
                ),
                Positioned(
                  bottom: 50.0,
                  right: 100.0,
                  child: Container(
                    height: 400.0,
                    width: 400.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200.0),
                        color: Color(getColorHexFromStr('#FEE16D'))
                            .withOpacity(0.4)),
                  ),
                ),
                Positioned(
                  bottom: 100.0,
                  left: 150.0,
                  child: Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150.0),
                          color: Color(getColorHexFromStr('#FEE16D'))
                              .withOpacity(0.5))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15.0),
                        Container(
                          alignment: Alignment.topLeft,
                          child: user != null
                              ? user['user']['image'] != ""
                                  ? CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(
                                          "$host/${user['user']['image']}"),
                                    )
                                  : CircleAvatar(
                                      radius: 28,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.yellow[700],
                                      ),
                                    )
                              : CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.yellow[700],
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                  ),
                                ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 120.0),
                        // Container(
                        //   alignment: Alignment.topRight,
                        //   child: IconButton(
                        //     icon: Icon(Icons.menu),
                        //     onPressed: () {},
                        //     color: Colors.white,
                        //     iconSize: 30.0,
                        //   ),
                        // ),
                        SizedBox(height: 15.0),
                      ],
                    ),
                    SizedBox(height: 50.0),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        user != null
                            ? 'Hello , ${user['user']['username']}'
                            : "Hello, ...",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'What do you want to buy?',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(5.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search,
                                    color: Color(getColorHexFromStr('#FEDF62')),
                                    size: 30.0),
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Quicksand'))),
                      ),
                    ),
                    SizedBox(height: 10.0)
                  ],
                )
              ],
            ),
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                SizedBox(height: 10.0),
                Material(
                    elevation: 1.0,
                    child: Container(height: 75.0, color: Colors.white)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        getItems("sofa");
                      },
                      child: Container(
                        height: 75.0,
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/sofas.png'))),
                              ),
                            ),
                            Text(
                              'Sofas',
                              style: TextStyle(fontFamily: 'Quicksand'),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getItems("wardrobe");
                      },
                      child: Container(
                        height: 75.0,
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/wardrobe.png'))),
                            ),
                            Text(
                              'Wardrobe',
                              style: TextStyle(fontFamily: 'Quicksand'),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getItems("desk");
                      },
                      child: Container(
                        height: 75.0,
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/desks.png'))),
                            ),
                            Text(
                              'Desk',
                              style: TextStyle(fontFamily: 'Quicksand'),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getItems("dresser");
                      },
                      child: Container(
                        height: 75.0,
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/dressers.png'))),
                            ),
                            Text(
                              'Dresser',
                              style: TextStyle(fontFamily: 'Quicksand'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.75,
              child: items != null
                  ? ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return itemCard(
                            context,
                            items[index]['_id'],
                            items[index]['name'],
                            items[index]['image'],
                            true,
                            items[index]['price'],
                            items[index]['description']);
                      })
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        )
      ],
    );
  }
}
