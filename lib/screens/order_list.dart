import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text("E-Commerce",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF7C4DFF),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user-order")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot docSnap = snapshot.data!.docs[index];

                  return Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Text(
                          docSnap["name"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        title: Center(
                          child: Text("TK ${docSnap["cost"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange)),
                        ),
                        trailing: ElevatedButton(
                            child: const Text("Cancel"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                textStyle:
                                    const TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return CupertinoAlertDialog(
                                      title: const Text('Please Confirm'),
                                      content: const Text(
                                          'Are you sure to cancel?'),
                                      actions: [
                                        // The "Yes" button
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("user-order")
                                                .doc(FirebaseAuth.instance.currentUser!.email)
                                                .collection("items")
                                                .doc(docSnap.id)
                                                .delete().then((value) =>
                                                Fluttertoast.showToast(msg: "Order Canceled !!"));
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        // The "No" button
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No'),
                                        )
                                      ],
                                    );
                                  });
                            }
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
