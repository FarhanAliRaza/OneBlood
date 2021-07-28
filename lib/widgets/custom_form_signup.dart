import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_blood/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SigupForm extends StatefulWidget {
  @override
  _SigupFormState createState() => _SigupFormState();
}

class _SigupFormState extends State<SigupForm> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  final List<String> listOfBlood = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  String? username;
  String? phone;
  String? pass;
  String? bloodType;
  double? lon;
  double? lat;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
            child: SizedBox(
              width: 300,


              child: TextFormField(
                keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      try{
                        int v = int.parse(value);

                        this.phone = v.toString();
                        print(this.phone);

                      }
                      on Exception catch(e){
                        print(e);
                      }

                    });
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 11,
                  style: TextStyle(color: KonsecColor, fontSize: 15.0),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: KonsecColor, width: 3)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: KonsecColor, width: 1)),
                    // icon: Icon(
                    //   Icons.phone,
                    //   color: KonsecColor,
                    // ),
                    hintText: '03xx-xxxxxxx',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  }),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SizedBox(
              width: 300,
              child: DropdownButtonFormField(
                validator: (value){
                  if (value.toString() == ''){
                    return 'Please Select a Blood Type';

                  }
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: KonsecColor, width: 3)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: KonsecColor, width: 1)),
                  border: OutlineInputBorder(),
                ),
                hint: Text(
                  'BloodType',
                ),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    this.bloodType = value.toString();
                  });
                },
                onSaved: (value) {
                  setState(() {});
                },
                items: listOfBlood.map((String val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val,
                      style: TextStyle(fontSize: 15, color: KonsecColor,),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: KonsecColor,

                padding: EdgeInsets.all(20)
              ),
              onPressed: () async{
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Saving Data')));
                  Location loc = Location();
                  // print("ok");
                  try {
                    Position p = await loc.getCurrLoc();
                    lat = p.latitude;
                    lon = p.longitude;
                    final User? user = await _auth.currentUser;
                    _firestore.collection("userdata").doc(user!.uid).set(
                        {
                          "email" : user.email,
                          'name' : user.displayName,
                          "bloodtype" : this.bloodType,
                          "lat" : lat,
                          "lon" : lon,
                          "phone" : phone
                        }).then((_){
                      Navigator.pushNamed(context, '/');

                      print("success!");
                    });


                  }
                  on Exception catch(_){
                    print(_);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Settings > Apps > One Blood > Permissions > Turn ON Location Permission')));

                  }

                  // print("ok");
                  // print(p);


                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
