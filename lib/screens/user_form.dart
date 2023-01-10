import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/bottom_navigationbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserForm extends StatefulWidget {
  @override
  UserFormState createState() => UserFormState();
}

class UserFormState extends State<UserForm> {
  //control words for all text field in this form
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // TextEditingController roleController = TextEditingController();
  //for dropdown box, list of options
  List<String> gender = ["Male", "Female", "Other"];
  String? value;

  sendUserDataToDB() async {
    final FirebaseAuth myauth = FirebaseAuth.instance;
    var currentUser = myauth.currentUser;

    //this will create a file, name user-form-data and store all the text field data after calling it
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return collectionRef
        .doc(currentUser!.email)
        .set({
          "name": nameController.text,
          "phone": phoneController.text,
          "gender": genderController.text,
          "age": ageController.text,
          "address": addressController.text,
          "role": "user",
        })
        .then((value) => print("user data added"))
        .catchError((error) => print("Somthing is wrong!!"));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //for upper design container
            Container(
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  color: const Color(0xFF7C4DFF),
                  gradient: LinearGradient(
                    colors: [(new Color(0xFF651FFF)), (new Color(0xFF7C4DFF))],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //container for logo
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      height: 100,
                      width: 100,
                      child: Image.asset("images/logo.jpg"),
                    ),
                    //container for showing text at top, that this is user form page
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      alignment: Alignment.bottomRight,
                      child: const Text(
                        "User Form",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // container for Full name
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 20),
                      blurRadius: 50,
                      color: Color(0xFF7C4DFF),
                    )
                  ]),
              alignment: Alignment.center,
              child: TextField(
                // control word for name
                controller: nameController,
                cursorColor: const Color(0xFF7C4DFF),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xFF7C4DFF),
                    ),
                    labelText: "Full Name",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),

            //container for phone number
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [BoxShadow(
                    offset: Offset(0, 20),
                    blurRadius: 50,
                    color: Color(0xFF7C4DFF),
                  )
                ],
              ),
              alignment: Alignment.center,
              child: TextField(
                // control word for phone

                controller: phoneController,

                keyboardType: TextInputType.number,
                cursorColor: const Color(0xFF7C4DFF),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: Color(0xFF7C4DFF),
                    ),
                    labelText: "Enter Your Phone Number",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),

            //container for Gender
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: const [BoxShadow(
                        offset: Offset(0, 20),
                        blurRadius: 50,
                        color: Color(0xFF7C4DFF),
                      )
                    ]),
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  hint: const Text('Select Gender'),
                  value: value,
                  isExpanded: true,
                  items: gender.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: () {
                        setState(() {
                          genderController.text = value;
                        });
                      },
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                )),

            //container for Age
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: const [BoxShadow(
                      offset: Offset(0, 20),
                      blurRadius: 50,
                      color: Color(0xFF7C4DFF),
                    )
                  ]),
              alignment: Alignment.center,
              child: TextField(
                // control word for age

                controller: ageController,

                keyboardType: TextInputType.number,
                cursorColor: const Color(0xFF7C4DFF),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.timeline_sharp,
                      color: const Color(0xFF7C4DFF),
                    ),
                    labelText: "Age",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),

            //container for address
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: const [BoxShadow(
                      offset: Offset(0, 20),
                      blurRadius: 50,
                      color: Color(0xFF7C4DFF),
                    )
                  ]),
              alignment: Alignment.center,
              child: TextField(
                // control word for address

                controller: addressController,

                cursorColor: const Color(0xFF7C4DFF),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.home,
                      color: Color(0xFF7C4DFF),
                    ),
                    labelText: "Address",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),
            //button for signup and navigate to bottom navigator bar
            GestureDetector(
              onTap: () => {
                sendUserDataToDB(),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNavBar()))
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (new Color(0xFF651FFF)),
                      (new Color(0xFF7C4DFF))
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [BoxShadow(
                        offset: Offset(0, 20),
                        blurRadius: 50,
                        color: Color(0xFF7C4DFF),
                      )
                    ]),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
