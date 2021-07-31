import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one_blood/contants.dart';
import 'package:one_blood/screens/tab_screen.dart';
import 'package:one_blood/services/user_services.dart';
import 'package:one_blood/services/location.dart';
import 'package:one_blood/widgets/blood_type_dropdown.dart';
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
  UserService fireStore = UserService();
  Location location = Location();
  Position? position;

  String selectedBloodType = 'A+';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  width: double.infinity),
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
                            style:
                                TextStyle(color: KonsecColor, fontSize: 15.0),
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
                              if (value == null || value.isEmpty)
                                return 'Please enter phone number';
                              return null;
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: SizedBox(
                        width: 300,
                        child: BloodTypeDropDown(
                            onChanged: (value) => setState(
                                () => selectedBloodType = value as String)),
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
                                Navigator.pushNamed(context, TabScreen.id);
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
      ),
    );
  }
}
