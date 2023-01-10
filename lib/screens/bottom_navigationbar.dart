import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/search_screen.dart';
import 'package:project/screens/splashscreen.dart';
import 'admin_dashboard.dart';
import 'admin_order_list.dart';
import 'customer_search.dart';
import 'homepage.dart';
import 'favourite.dart';
import 'profile.dart';
import 'cart.dart';

class BottomNavBar extends StatefulWidget{
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar>{
  final pagesofuser=[const Homepage(),const Favourite(),SearchScreen(),Cart(),Profile()];
  final pagesofadmin=[AdminOrderList(),const AdminDashBoard(),CustomerSearch()];
  int currentIndex1 =0;
  int currentIndex2=1;
  String role = "";
  bool isrole=false;

  @override

  fetchrole() async {
    await FirebaseFirestore.instance.collection("users-form-data").
    doc(FirebaseAuth.instance.currentUser!.email).
    get().then((value) {
      var fields = value.data();
      setState((){
        role = fields!["role"].toString();
        if(role=="admin")
          isrole = true;
      });
    });
  }
  FirebaseAuth auth = FirebaseAuth.instance;
  Logout(){
    auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> SplashScreen()
    ));
  }

  @override
  void initState(){
    fetchrole();
    super.initState();
  }

    @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: isrole? AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text("E-Commerce",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25)
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_outlined) ,
            onPressed: (){
              Logout();
            },
          ),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,

      )
      :
      AppBar(
        backgroundColor:const Color(0xFF7C4DFF),
        elevation: 0,
        title: const Text("E-Commerce",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25)
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,

      ),


      bottomNavigationBar: isrole ? ConvexAppBar(
        style: TabStyle.fixedCircle,
        color: Colors.white,
        backgroundColor: Colors.orange,
        activeColor: Colors.white,

        initialActiveIndex: currentIndex2,
        // selectedItemColor: Colors.orange,
        // unselectedItemColor: Colors.white,
        // selectedLabelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

        items: const[
          TabItem(icon: Icon(Icons.list),title: "Orders List"),
          TabItem(icon: Icon(Icons.home),title: "Admin Dash Board"),
          TabItem(icon: Icon(Icons.search),title: "Customer Search"),
        ],

        onTap: (index){
          setState((){
            currentIndex2=index;
            print(role);
            print(isrole);
          });
        },
      )
          :
      ConvexAppBar(
        style: TabStyle.reactCircle,
        color: Colors.white,
        backgroundColor: const Color(0xFF7C4DFF),
        activeColor: Colors.white,

        initialActiveIndex: currentIndex1,
        // selectedItemColor: Colors.orange,
        // unselectedItemColor: Colors.white,
        // selectedLabelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

        items: const[
          TabItem(icon: Icon(Icons.home),title: "Home",),
          TabItem(icon: Icon(Icons.favorite_outlined),title: "Favorite"),
          TabItem(icon: Icon(Icons.search),title: "Search"),
          TabItem(icon: Icon(Icons.add_shopping_cart),title: "Cart"),
          TabItem(icon: Icon(Icons.person),title: "Person"),
        ],

        onTap: (index){
          setState((){
            currentIndex1=index;
            print(role);
            print(isrole);
          });
        },
      ),
      body: isrole ? pagesofadmin[currentIndex2]: pagesofuser[currentIndex1],


    );
  }

}