import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminOrderList extends StatefulWidget {
  const AdminOrderList({Key? key}) : super(key: key);

  @override
  AdminOrderListState createState() => AdminOrderListState();
}

class AdminOrderListState extends State<AdminOrderList> {
  //final DatabaseReference ref = FirebaseDatabase.instance.ref();
  //final snapshot = await ref.child("user-order").get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                  final snap = FirebaseFirestore.instance
                      .collection('alibaba@alibaba.com')
                      .get();

                  log(snap.toString());
                  // .then((QuerySnapshot querySnapshot) {
                  //   querySnapshot.docs.forEach((element) {log(element.toString();)});
                  // });
                },
                child: const Text('click'))),
        // child: StreamBuilder(
        //   stream:
        //   FirebaseFirestore.instance
        //       .collection("user-order")
        //       .doc(FirebaseAuth.instance.currentUser!.email)
        //       .collection("items")
        //       .snapshots(),
        //   builder:
        //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     var data=snapshot.data;
        //     if(data==null){
        //       return const Center(child: CircularProgressIndicator(),);
        //     }

        //     return ListView.builder(
        //         itemCount: snapshot.data!.docs.length,
        //         itemBuilder: (_, index) {
        //           DocumentSnapshot docSnap = snapshot.data!.docs[index];

        //           return GestureDetector(
        //             onTap: () =>
        //             {

        //             },
        //             child: Card(
        //               elevation: 3,
        //               child: ListTile(
        //                 leading: Text(docSnap["name"],

        //                   style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),

        //                 ),

        //                 title: Center(
        //                   child: Text("unit=${docSnap["unit"]}",
        //                       style: const TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           color: Colors.deepOrange)),
        //                 ),
        //               ),
        //             ),
        //           );
        //         });
        //   },
        // ),
      ),
    );
  }
}
