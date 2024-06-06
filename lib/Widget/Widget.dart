import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperapp/Models/Photo_mode.dart';
import 'package:wallpaperapp/Pages/FullScreen.dart';

Widget wallpaper(List<Photosmodel> listphoto, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        padding: EdgeInsets.all(2),
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: listphoto.map((Photosmodel photosmodel) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FullScreen(imagePath: photosmodel.src!.portrait!)));
            },
            child: Hero(
                tag: photosmodel.src!.portrait!,
                child: Container(
                  child: CachedNetworkImage(
                    imageUrl: photosmodel.src!.portrait!,
                    fit: BoxFit.cover,
                  ),
                )),
          ));
        }).toList()),
  );
}
