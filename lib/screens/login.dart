import 'package:flutter/material.dart';
import 'package:one_blood/widgets/heading.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:one_blood/contants.dart';
class Signin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SigninBody(),
    );
  }
}
class SigninBody extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Header(),
            ),
            Image(image: AssetImage("images/donor.png"), height: 270, width: double.infinity,),
            SizedBox(height: 40,),
            SizedBox(
              width: 300,
              child: GestureDetector(
                onTap: () async{
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Logging in')));
                  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                  // Obtain the auth details from the request
                  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

                  // Create a new credential
                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth.accessToken,
                    idToken: googleAuth.idToken,
                  );

                  // Once signed in, return the UserCredential
                  await _auth.signInWithCredential(credential);
                  final User? user = await _auth.currentUser;

                  print(user);
                  _firestore.collection("userdata").doc(user!.uid).get().then((value){
                    if (value.data() == null){
                      print("no Data found");

                      Navigator.pushNamed(context, '/signup');

                    }
                    else{
                      Navigator.pushNamed(context, '/');

                    }

                  });

                  // _auth.

                  // AuthCredential credential = PhoneAuthProvider();




                  print("tapped");
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: KonsecColor, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(7.0))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/gg.png', height: 40, width: 30,),
                        SizedBox(width: 7),
                        Text("Login With Google",
                          style: Konbtntext,
                        ),
                      ],
                    )
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
