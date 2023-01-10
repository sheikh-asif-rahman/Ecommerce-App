import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bottom_navigationbar.dart';

class BuyPage extends StatefulWidget {
  var product;
  BuyPage(this.product);
  @override
  State<BuyPage> createState() => _BuyPageState();
}
class _BuyPageState extends State<BuyPage> {
  TextEditingController ?addressController;
  TextEditingController ?customernameContorller;
  int count=1;
  int price=0;
  Future addToOrder() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("user-order");
    return collectionRef.doc(currentUser!.email).collection("items").doc().set({
      "customer name": customernameContorller!.text,
      "name": widget.product["name"],
      "cost": total(),
      "image": widget.product["image"],
      "detail": widget.product["detail"],
      "address": addressController!.text,
      "unit":count,
    }).then((value) => Fluttertoast.showToast(
        msg: "Order Placed !!"));
  }

  setDataToTextField(data){
    customernameContorller =TextEditingController(text: data["name"]);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
          padding: const EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black,width: 3),
              color: Colors.white30,
          ),
          alignment: Alignment.center,
          child: TextField(
            // control word for name
            controller: addressController =TextEditingController(text: data["address"]),
            cursorColor: const Color(0xFF7C4DFF),
            decoration: const InputDecoration(
                icon: Icon(Icons.person,
                  color: Color(0xFF7C4DFF),
                ),
                labelText: "Your Address",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none
            ),
          ),
        ),
      ],
    );
  }




  void increment(){
    setState((){
      if(count < 15) {
        count++;
      }
    });
  }
  void decrement(){
    setState((){
      if(count > 0) {
        count--;
      }
    });
  }
  void setprice(int y){
    setState((){
      price = y;
    });
  }
  int unitTotal(){
    int x = count * price;
    return x;
  }
  int total(){
     int totalPrice = count * price + 50;
    return totalPrice;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          title: const Text("E-Commerce",
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,

          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF7C4DFF),
              child: IconButton(onPressed: ()=>Navigator.pop(context),icon: const Icon(Icons.arrow_back,color: Colors.white,)),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),

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
                const SizedBox(
                  height: 15,
                ),
                  Container(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  alignment: Alignment.center,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                  ),

                  child: Text(widget.product["name"],
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                ),

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5,right:20),
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      alignment: Alignment.centerRight,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: const Text("Unit per Price:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black54),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 5),
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      alignment: Alignment.centerRight,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Text("\TK ${widget.product["price"].toString()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 35,
                        ),
                        onTap: () =>{
                          increment(),
                          setprice(widget.product["price"])
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: GestureDetector(
                      child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: 35,
                      ),
                       onTap: () =>{
                      decrement()
                      },
                    ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5,right:20),
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      alignment: Alignment.centerRight,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: const Text("=",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black54),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5,right:5),
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      alignment: Alignment.centerRight,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Text("\TK ${unitTotal().toString()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black54),
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5,right:20),
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      alignment: Alignment.centerRight,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: const Text("Delevary Charge:",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black54),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5,right:20),
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      alignment: Alignment.centerRight,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: const Text("Tk 50",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
            const Divider(
              color: Colors.black,
              thickness: 5
            ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5,right:20),
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      alignment: Alignment.centerRight,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: const Text("Total :",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 60,right:20),
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      alignment: Alignment.centerRight,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Text("\TK ${total().toString()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.
                  instance.currentUser!.email).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    var data=snapshot.data;
                    if(data==null){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    return setDataToTextField(data);
                  },
                ),),
                Container(
                  margin: const EdgeInsets.only(left: 20,right:20,top: 20),
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  alignment: Alignment.centerRight,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: new Center(
                    child: const Text("Note: Cash On Delivery only!!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17, color: Colors.red),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: ()=>{
                    addToOrder(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BottomNavBar())),
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [(new Color(0xFF651FFF)), (new Color(0xFF7C4DFF))],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                        ),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [const BoxShadow(
                          offset: const Offset(0,20),
                          blurRadius: 50,
                          color: Color(0xFF7C4DFF),
                        )]
                    ),
                    child: const Text(
                      "Place Order",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),





              ],
            ),



        ),
          ),

        ),

      );
  }
}
