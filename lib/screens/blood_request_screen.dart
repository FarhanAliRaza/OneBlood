import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one_blood/contants.dart';
import 'package:one_blood/services/blood_request.dart';
import 'package:one_blood/services/location.dart';

class BloodRequestScreen extends StatefulWidget {
  static const String id = "BloodRequestScreen";

  @override
  _BloodRequestScreenState createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  Location location = Location();
  BloodRequestService bloodRequestService = BloodRequestService();
  Position? position;
  String selectedBloodType = listOfBlood[0];
  int numberOfBottles = 1;

  TextEditingController cityController = TextEditingController();
  TextEditingController bottlesController = TextEditingController();

  incrementBottles() {
    if (numberOfBottles > 0) numberOfBottles++;
    setState(() => bottlesController.text = numberOfBottles.toString());
  }

  decrementBottles() {
    if (numberOfBottles > 1) numberOfBottles--;
    setState(() => bottlesController.text = numberOfBottles.toString());
    print(numberOfBottles);
  }

  @override
  void initState() {
    super.initState();
    bottlesController.text = numberOfBottles.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back))
              ],
            ),
            SizedBox(height: 10),
            customTextField(cityController, "City Name", TextInputType.text,
                "City must not be empty"),
            SizedBox(height: 10),
            bottlesCounter(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    position = await location.getCurrLoc();
                    if (position != null) {
                      await bloodRequestService.addRequest(
                          position!.latitude,
                          position!.longitude,
                          cityController.text,
                          numberOfBottles);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Request"),
                  style: ElevatedButton.styleFrom(primary: KonsecColor),
                )
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget bottlesCounter() => Row(
        children: [
          SizedBox(width: 12),
          Text(
            "Number Of Bottles",
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          IconButton(
              onPressed: () => incrementBottles(), icon: Icon(Icons.add)),
          Container(
            width: 70,
            child: bottleTextField(),
          ),
          IconButton(
              onPressed: () => decrementBottles(), icon: Icon(Icons.remove)),
        ],
      );

  Widget bottleTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: bottlesController,
      onChanged: (value) {
        numberOfBottles = int.parse(bottlesController.text);
      },
      decoration: InputDecoration(
        hintText: "Bottles",
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KonsecColor),
        ),
      ),
    );
  }

  Widget customTextField(TextEditingController controller, String hintText,
      TextInputType keyboardType, String error,
      [bool obscureText = false]) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value == "") return error;
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KonsecColor),
          ),
        ),
      ),
    );
  }
}
