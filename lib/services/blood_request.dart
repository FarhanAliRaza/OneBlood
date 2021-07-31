import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_blood/models/user_model.dart';
import 'package:one_blood/services/authentication.dart';
import 'package:one_blood/services/user_services.dart';

class BloodRequestService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CollectionReference bloodRequestCollection =
      FirebaseFirestore.instance.collection('requests');

  Stream<List> get bloodRequests =>
      bloodRequestCollection.snapshots().map((event) => event.docs.toList());

  Future addRequest(
      double latitude, double longitude, String city, int bottles) async {
    UserModel? user = await UserService().getUserData(Auth().currentUser!.uid);
    await bloodRequestCollection.doc().set({
      "user": user!.toJson(),
      "latitude": latitude,
      "longitude": longitude,
      "city": city,
      "numberOfBottles": bottles,
    });
  }
}
