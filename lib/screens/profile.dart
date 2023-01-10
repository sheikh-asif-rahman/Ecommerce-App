import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/screens/order_list.dart';
import 'package:project/screens/splashscreen.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  TextEditingController ?nameController;
  TextEditingController ?phoneController ;
  TextEditingController ?genderController;
  TextEditingController ?ageController;
  TextEditingController ?addressController;
  String? value;


  setDataToTextField(data){
    return Column(
      children: [

        Container(
          margin: EdgeInsets.only(left: 20,right: 20,top: 20),
          padding: EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
              boxShadow: [BoxShadow(
                offset: Offset(0,20),
                blurRadius: 50,
                color: Color(0xFF7C4DFF),
              )]
          ),
          alignment: Alignment.center,
          child: TextField(
            // control word for name
            controller: nameController =TextEditingController(text: data["name"]),
            cursorColor: const Color(0xFF7C4DFF),
            decoration: const InputDecoration(
                icon: Icon(Icons.person,
                  color: Color(0xFF7C4DFF),
                ),
                hintText: "Full Name",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none
            ),
          ),
        ),

        Container(
          margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
          padding: const EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[200],
            boxShadow: const [BoxShadow(
              offset: Offset(0,20),
              blurRadius: 50,
              color: Color(0xFF7C4DFF),
            )],
          ),
          alignment: Alignment.center,
          child: TextField(
            // control word for phone

            controller: phoneController=TextEditingController(text: data["phone"]),

            keyboardType: TextInputType.number,
            cursorColor:const Color(0xFF7C4DFF),
            decoration:const InputDecoration(
                icon: Icon(Icons.phone,
                  color: Color(0xFF7C4DFF),
                ),
                hintText: "Phone",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none
            ),
          ),
        ),

        Container(
          margin:const EdgeInsets.only(left: 20,right: 20,top: 20),
          padding:const EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
              boxShadow:const [BoxShadow(
                offset: Offset(0,20),
                blurRadius: 50,
                color: Color(0xFF7C4DFF),
              )]
          ),
          alignment: Alignment.center,
          child: TextField(

            // control word for age

            controller: ageController =  TextEditingController(text: data["age"]),


            keyboardType: TextInputType.number,
            cursorColor:const Color(0xFF7C4DFF),
            decoration:const InputDecoration(
                icon: Icon(Icons.timeline_sharp,
                  color: Color(0xFF7C4DFF),
                ),
                hintText: "Age",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none
            ),
          ),
        ),

        Container(
          margin:const EdgeInsets.only(left: 20,right: 20,top: 20),
          padding:const EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
              boxShadow:const [BoxShadow(
                offset: Offset(0,20),
                blurRadius: 50,
                color: Color(0xFF7C4DFF),
              )]
          ),
          alignment: Alignment.center,
          child: TextField(

            // control word for address

            controller: genderController = TextEditingController(text: data["gender"]),

            cursorColor:const Color(0xFF7C4DFF),
            decoration:const InputDecoration(
                icon: Icon(Icons.transgender_outlined,
                  color: Color(0xFF7C4DFF),
                ),
                hintText: "Gender",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none
            ),
          ),
        ),
        Container(
          margin:const EdgeInsets.only(left: 20,right: 20,top: 20),
          padding:const EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
              boxShadow:const [BoxShadow(
                offset: Offset(0,20),
                blurRadius: 50,
                color: Color(0xFF7C4DFF),
              )]
          ),
          alignment: Alignment.center,
          child: TextField(

            // control word for address

            controller: addressController =  TextEditingController(text: data["address"]),

            cursorColor:const Color(0xFF7C4DFF),
            decoration:const InputDecoration(
                icon: Icon(Icons.home,
                  color: Color(0xFF7C4DFF),
                ),
                hintText: "Address",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none
            ),
          ),
        ),
        GestureDetector(
          onTap: ()=>{
            updateData(),
          },
          child: Container(
            margin:const EdgeInsets.only(left: 20,right: 20,top: 20),
            padding:const EdgeInsets.only(left: 20,right: 20),
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [(new Color(0xFF651FFF)), (new Color(0xFF7C4DFF))],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                ),
                borderRadius: BorderRadius.circular(50),
                boxShadow:const [BoxShadow(
                  offset: Offset(0,20),
                  blurRadius: 50,
                  color: Color(0xFF7C4DFF),
                )]
            ),
            child:const Text(
              "Update",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
          ),
        ),

        Row(
          children: [
            GestureDetector(
              onTap: ()=>{
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const OrderList())),
              },
              child: Container(
                margin:const EdgeInsets.only(left: 20,right: 20,top: 20),
                padding:const EdgeInsets.only(left: 40,right: 40),
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow:const [BoxShadow(
                      offset: Offset(0,20),
                      blurRadius: 50,
                      color: Color(0xFF7C4DFF),
                    )]
                ),
                child:const Text(
                  "Orders",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: ()=>{
                Logout(),
              },
              child: Container(
                margin:const EdgeInsets.only(left: 20,right: 20,top: 20),
                padding:const EdgeInsets.only(left: 40,right: 40),
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow:const [BoxShadow(
                      offset: Offset(0,20),
                      blurRadius: 50,
                      color: Color(0xFF7C4DFF),
                    )]
                ),
                child:const Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

  }


  updateData(){
    CollectionReference collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "name":nameController!.text,
          "phone":phoneController!.text,
          "age":ageController!.text,
          "gender":genderController!.text,
          "address":addressController!.text,
        }
    ).then((value) =>
        Fluttertoast.showToast(msg: "Updated Successfully!!")
    );
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  Logout(){
    auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> SplashScreen()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),

              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  var data=snapshot.data;
                  if(data==null){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return setDataToTextField(data);
                },
              ),
            ),
          ),
        )
    );
  }
}