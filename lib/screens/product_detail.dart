import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatefulWidget {
  var product;
  ProductDetails(this.product);

  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  Future addToCart() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("user-cart-items");
    return collectionRef.doc(currentUser!.email).collection("items").doc().set({
      "name": widget.product["name"],
      "price": widget.product["price"],
      "image": widget.product["image"],
      "detail": widget.product["detail"],
    }).then((value) => Fluttertoast.showToast(
        msg: "Added To Cart !!"));
  }

  Future addToFavourite() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("user-favourite-items");
    return collectionRef.doc(currentUser!.email).collection("items").doc().set({
      "name": widget.product["name"],
      "price": widget.product["price"],
      "image": widget.product["image"],
      "detail": widget.product["detail"],
    }).then((value) => Fluttertoast.showToast(msg: "Added To Favourite !!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("E-Commerce",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Color(0xFF7C4DFF),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user-favourite-items")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items")
                .where("name", isEqualTo: widget.product["name"])
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Text("");
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Color(0xFF7C4DFF),
                  child: IconButton(
                      onPressed: () => snapshot.data.docs.length == 0
                          ? addToFavourite()
                          : Fluttertoast.showToast(
                              msg: "Already Added Favourite !!"),
                      icon: Icon(
                        Icons.favorite_outlined,
                        color: Colors.white,
                      )),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2.5,
                child: CarouselSlider(
                    items: widget.product["image"]
                        .map<Widget>((item) => Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.fitWidth)),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (val, carouselPageChangedReason) {})),
              ),
              SizedBox(
                height: 15,
              ),
              Text(widget.product["name"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              SizedBox(
                height: 15,
              ),
              Text(widget.product["detail"],
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 20)),
              SizedBox(
                height: 15,
              ),
              Text(
                "\TK ${widget.product['price'].toString()}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red),
              ),
              SizedBox(
                height: 15,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("user-cart-items")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection("items")
                      .where("name", isEqualTo: widget.product["name"])
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Text("");
                    }
                    return GestureDetector(
                      onTap: () => snapshot.data.docs.length == 0
                          ? addToCart()
                          : Fluttertoast.showToast(
                          msg: "Already Added To Cart !!"),
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  (new Color(0xFF651FFF)),
                                  (new Color(0xFF7C4DFF))
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 20),
                                blurRadius: 50,
                                color: Color(0xFF7C4DFF),
                              )
                            ]),
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
