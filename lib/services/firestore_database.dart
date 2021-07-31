import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_blood/models/user_model.dart';
import 'package:one_blood/services/authentication.dart';

class FireStore {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('userdata');

  Future<UserModel?> getUserData(String uid) async {
    UserModel? user;
    DocumentSnapshot document = await usersCollection.doc(uid).get();
    Map<String, dynamic>? userData = document.data() as Map<String, dynamic>?;
    if (userData != null) user = UserModel.fromJson(userData);
    return user;
  }

  Future saveUserToDB(
      String bloodType, double latitude, double longitude, String phone) async {
    User? user = Auth().currentUser;
    await usersCollection.doc(user!.uid).set({
      "email": user.email,
      'name': user.displayName,
      "bloodtype": bloodType,
      "lat": latitude,
      "lon": longitude,
      "phone": phone
    });
  }
}
