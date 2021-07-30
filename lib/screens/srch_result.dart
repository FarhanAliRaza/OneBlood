import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.blood}) : super(key: key);
  static const String id = "SearchScreen";
  final String blood;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: Icon(Icons.home_outlined),
                  iconSize: 35,
                  color: KonsecColor,
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  }),
              // Spacer(),
              IconButton(
                  icon: Icon(Icons.info_outlined),
                  iconSize: 35,
                  color: KonsecColor,
                  onPressed: () {
                    Navigator.pushNamed(context, '/info');
                  }),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "One Blood",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: KonsecColor,
        ),
        body: Body(this.widget.blood));
  }
}

class Body extends StatefulWidget {
  String? blood;
  Body(String blood) {
    this.blood = blood;
  }

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List result = [];
  int? size;

  Future<List> search(String blood) async {
    var data = await FirebaseFirestore.instance
        .collection('userdata')
        .where('bloodtype', isEqualTo: blood)
        .get();
    this.size = data.size;

    this.result = data.docs;

    return data.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search(widget.blood!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: search(widget.blood!),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (result.isNotEmpty) {
              return ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return BloodCard(
                    result[index]['name'],
                    result[index]['phone'],
                    result[index]['lat'],
                    result[index]['lon'],
                    result[index]['bloodtype'],
                  );
                },
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/abstract.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("WE ARE SORRY",
                          style: TextStyle(
                              color: KonsecColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      Text("Blood Group Not Found",
                          style: TextStyle(
                              color: KonsecColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: SpinKitPumpingHeart(
                color: KonsecColor,
                size: 150.0,
              ),
            );
          }
        });
  }
}

// double distance;
// final d = Geolocator.distanceBetween(lat!, lon!, 52.3546274, 4.8285838);

// double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);

class BloodCard extends StatefulWidget {
  String? name;
  String? phone;
  double? lat;
  double? lon;
  String? blood;
  BloodCard(String name, String phone, double lat, double lon, String blood) {
    this.name = name;
    this.phone = phone;
    this.lat = lat;
    this.lon = lon;

    this.blood = blood;
  }

  @override
  _BloodCardState createState() => _BloodCardState();
}

class _BloodCardState extends State<BloodCard> {
  late double dis;

  Future<double> getD() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.pushNamed(context, "/login");
      }
    });
    final User? user = await FirebaseAuth.instance.currentUser;
    print(user);
    // if (user == Null)
    await FirebaseFirestore.instance
        .collection('userdata')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot ds) {
      double lat2 = ds.get("lat");
      double lon2 = ds.get("lon");
      print("$lat2, $lon2, ${widget.lat!}, ${widget.lon!}");

      double d =
          Geolocator.distanceBetween(widget.lat!, widget.lon!, lat2, lon2);
      dis = d;
    });
    return dis;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getD(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ClipRect(
              child: Container(
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 50,
                            color: KonsecColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              "${widget.blood}",
                              style: TextStyle(
                                  color: KonsecColor,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "Name : ${widget.name}",
                            style: TextStyle(
                              color: KonsecColor,
                            ),
                          ),
                        ),
                        Text(
                          "Distance :  ${dis ~/ 1000} KM",
                          style: TextStyle(color: KonsecColor),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: GestureDetector(
                            onTap: () {
                              launch("tel://0${widget.phone}");
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: KonsecColor, width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.call,
                                      color: KonsecColor,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Call",
                                      style: TextStyle(
                                          color: KonsecColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
                height: 120.0,
                margin: const EdgeInsets.only(bottom: 6, top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  // border: Border.all(color: KonsecColor, width: 2),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              // child: Text("${snapshot.data}"),

              child: SpinKitDoubleBounce(
                color: KonsecColor,
                size: 70.0,
              ),
            );
          }
        });
  }
}
