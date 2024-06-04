import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpaperapp/Service/Database.dart';

class Allwallpaper extends StatefulWidget {
  String category;
  Allwallpaper({required this.category});

  @override
  State<Allwallpaper> createState() => _AllwallpaperState();
}

class _AllwallpaperState extends State<Allwallpaper> {
  Stream? categoryStrem;

  getonload() async {
    categoryStrem = await DatabaseMethods().getCategory(widget.category);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getonload();
  }

  Widget allwallpaper() {
    return StreamBuilder(
        stream: categoryStrem,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 06,
                      crossAxisSpacing: 6.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            ds["Image"],
                            fit: BoxFit.cover,
                          )),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          children: [
            Center(
              child: Text(
                widget.category,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: allwallpaper())
          ],
        ),
      ),
    );
  }
}
