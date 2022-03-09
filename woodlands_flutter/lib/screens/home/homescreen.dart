import 'package:flutter/material.dart';
import 'package:woodlands_flutter/screens/profile/mycart/mycart.dart';
import 'package:woodlands_flutter/screens/profile/profile.dart';

import '../../components/ItemList.dart';
import '../../utilities/parseToken.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: [
          ItemList(),
          MyCart(),
          Profile(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          labelColor: Colors.yellow,
          indicatorColor: Colors.yellow,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 5,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.event_seat, color: Colors.grey)),
            // Tab(icon: Icon(Icons.timer, color: Colors.grey)),
            Tab(icon: Icon(Icons.shopping_cart, color: Colors.grey)),
            Tab(icon: Icon(Icons.person_outline, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
