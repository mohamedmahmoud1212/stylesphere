import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(
              text: "Processing",
            ),
            Tab(
              text: "Shipped",
            ),
            Tab(
              text: "Delivered",
            ),
            Tab(
              text: "Returned",
            ),
            Tab(
              text: "Cancelled",
            ),
          ]),
          title: Text(
            "Orders",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              fontFamily: "cairo",
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.message_outlined),
                    title: Text("Order #456765"),
                    subtitle: Text("4 items"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          onTap: (index) {},
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: ""),
          ],
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
