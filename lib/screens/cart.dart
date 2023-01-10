import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/screens/buy_page.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => CartState();
}

class CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user-cart-items")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var data=snapshot.data;
            if(data==null){
              return Center(child: CircularProgressIndicator(),);
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot docSnap = snapshot.data!.docs[index];

                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BuyPage(docSnap))),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Text(docSnap["name"],

                          style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),

                        ),

                        title: Center(
                          child: Text("\TK ${docSnap["price"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange)),
                        ),
                        trailing: GestureDetector(
                          child: const CircleAvatar(
                            child: Icon(Icons.remove_circle,
                                color: Colors.deepOrange),
                          ),
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("user-cart-items")
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection("items")
                                .doc(docSnap.id)
                                .delete().then((value) =>
                                Fluttertoast.showToast(msg: "Removed From Cart !!"));
                          },
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
