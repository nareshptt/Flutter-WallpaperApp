import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wallpaperapp/Admin/Admin.login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool internet = true;

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot> imageStream;
  int currentSlideIndex = 0;
  CarouselController carouselController = CarouselController();
  @override
  void initState() {
    super.initState();

    checkInternet();

    var firebase = FirebaseFirestore.instance;
    imageStream = firebase.collection("Home banner").snapshots();
  }

  checkInternet() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          internet = true;

          break;

        case InternetConnectionStatus.disconnected:
          internet = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("No Internet Connection!"),
          ));

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 55, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(60),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: GestureDetector(
                        onLongPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminLogin()));
                        },
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
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(right: 2),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            "Amigo Photo Gallery ",
                            textStyle: const TextStyle(
                                fontSize: 19.0, fontFamily: "Poppins"),
                            speed: Duration(milliseconds: 150),
                          ),
                        ],
                        totalRepeatCount: 1, // Repeat animations 4 times
                        pause: const Duration(
                            milliseconds: 1000), // Pause between animations
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: imageStream,
                  builder: (_, snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.length > 1) {
                      return CarouselSlider.builder(
                          carouselController: carouselController,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (_, index, ___) {
                            DocumentSnapshot sliderImage =
                                snapshot.data!.docs[index];
                            final res = sliderImage['Image'];
                            return !internet
                                ? Center(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(23),
                                          child:
                                              Image.asset("assets/error.png")),
                                    ),
                                  )
                                : builImage(res, index);
                          },
                          options: CarouselOptions(
                              autoPlay: true,
                              height: MediaQuery.of(context).size.height / 1.5,
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentSlideIndex = index;
                                });
                              }));
                    } else {
                      return const Center(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  }),
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
        activeIndex: currentSlideIndex,
        count: 3,
        effect: SlideEffect(
            dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue),
      );

  Widget builImage(String urlImage, int index) => Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: Image.network(
              urlImage,
              fit: BoxFit.cover,
            )),
      );
}
