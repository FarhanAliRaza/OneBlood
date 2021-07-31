import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one_blood/contants.dart';
import 'package:one_blood/screens/home_screen.dart';
import 'package:one_blood/services/firestore_database.dart';
import 'package:one_blood/services/location.dart';
import 'package:one_blood/widgets/heading.dart';

class UserDataScreen extends StatefulWidget {
  static const String id = "UserDataScreen";
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FireStore fireStore = FireStore();
  Location location = Location();
  Position? position;

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
  String selectedBloodType = 'A+';

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
            Image(
              image: AssetImage("images/donor2.png"),
              height: 270,
              width: double.infinity,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 25),
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 11,
                          style: TextStyle(color: KonsecColor, fontSize: 15.0),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: KonsecColor, width: 3)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: KonsecColor, width: 1)),
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
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: KonsecColor, width: 3)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: KonsecColor, width: 1)),
                          border: OutlineInputBorder(),
                        ),
                        hint: Text('BloodType'),
                        isExpanded: true,
                        onChanged: (value) =>
                            setState(() => selectedBloodType = value as String),
                        items: listOfBlood
                            .map((String value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: KonsecColor,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: KonsecColor, padding: EdgeInsets.all(20)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Saving Data')));
                          try {
                            position = await location.getCurrLoc();
                            if (position != null) {
                              await fireStore.saveUserToDB(
                                  selectedBloodType,
                                  position!.latitude,
                                  position!.longitude,
                                  phoneController.text);
                              Navigator.pushNamed(context, HomeScreen.id);
                            }
                          } on Exception catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Settings > Apps > One Blood > Permissions > Turn ON Location Permission')));
                          }
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
