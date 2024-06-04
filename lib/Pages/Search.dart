import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaperapp/Models/Photo_mode.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/Widget/Widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Photosmodel> photos = [];
  TextEditingController searchController = new TextEditingController();
  bool search = false;

  void initState() {
    super.initState();

    _loadData();
  }

  void _loadData() async {
    if (!search)
      setState(() {
        getSearchWallpaper("trending");
      });
  }

  getSearchWallpaper(String searchQuery) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$searchQuery&per_page=600"),
        headers: {
          "Authorization":
              "eKLgzmejghJaYFa1rrC6GFRLfA0ZDYlk4NbpXnLz5iVh9dSRLKAdwkaV"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);

      jsonData["photos"].forEach((element) {
        Photosmodel photosmodel = new Photosmodel();
        photosmodel = Photosmodel.fromMap(element);
        photos.add(photosmodel);
      });
      setState(() {
        search = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(children: [
          Center(
            child: Text(
              "Search",
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        getSearchWallpaper(searchController.text);
                      },
                      child: search
                          ? GestureDetector(
                              onTap: () {
                                photos = [];
                                search = false;
                                setState(() {});
                              },
                              child: Icon(Icons.close))
                          : Icon(Icons.search))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(child: wallpaper(photos, context))
        ]),
      ),
    );
  }
}
