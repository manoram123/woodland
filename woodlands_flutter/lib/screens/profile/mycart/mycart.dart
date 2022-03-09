import 'package:flutter/material.dart';
import 'package:woodlands_flutter/components/MyCart.dart';

import '../../../http/http.dart';
import '../../../utilities/getColors.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  var items = null;

  Future getItems() async {
    var res = await HttpConnectUser().myCart();
    print(res);
    setState(() {
      items = res['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "My Cart",
                style: TextStyle(
                    color: Color(getColorHexFromStr('#FEE16D')),
                    fontSize: 22,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w900),
              ),
            ),
            Divider(
              height: 3,
              color: Color(getColorHexFromStr('#FEE16D')),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.82,
              child: items != null
                  ? ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Cart(
                            context,
                            items[index]['product']['_id'],
                            items[index]['product']['name'],
                            items[index]['product']['image'],
                            true,
                            items[index]['product']['price'],
                            items[index]['product']['description']);
                      })
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
