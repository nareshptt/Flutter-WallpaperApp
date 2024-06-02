import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  List Wallpaperimage = [
    "assets/p1.jpg",
    "assets/p2.jpg",
    "assets/p3.jpg",
    "assets/p4.jpg",
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(60),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Image.asset(
                          "assets/boy.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Center(
                    child: Text(
                      "Amigo ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              CarouselSlider.builder(
                  itemCount: Wallpaperimage.length,
                  itemBuilder: (context, index, realIndex) {
                    final res = Wallpaperimage[index];
                    return builImage(res, index);
                  },
                  options: CarouselOptions(
                      autoPlay: true,
                      height: MediaQuery.of(context).size.height / 1.5,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      })),
              SizedBox(
                height: 20,
              ),
              buildIndicator()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 3,
        effect: SlideEffect(
            dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue),
      );

  Widget builImage(String urlImage, int index) => Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: Image.asset(
              urlImage,
              fit: BoxFit.cover,
            )),
      );
}
