import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/bottom_navigationbar.dart';
import 'package:project/screens/registrationscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginScreen> {
  //two control word for email and password field
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signIn() async {
    try {
      //to match the user email and password from control word and firebase.
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      var authCredential = userCredential.user;
      //it will show if the user data is found or not
      print(authCredential!.uid);

      //if any data is founded, uid will be not empty so it will navigate to access in.
      if (authCredential.uid.isNotEmpty) {
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => BottomNavBar()));
      } else {
        Fluttertoast.showToast(msg: "Something is Wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for this email");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Password is wrong!!");
      }
    } catch (e) {
      print(e);
    }
  }

  bool obscText = false;
  @override
  //to give option to password field, show or hide.
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //login page top part design
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
                    //inside this design container, another two container added, one is for 
                    //logo and other one is for login text
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      height: 100,
                      width: 100,
                      child: Image.asset("images/logo.jpg"),
                    ),

                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      alignment: Alignment.bottomRight,
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //design ended here
            //this container is for a text field that will take user email
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
              child: TextFormField(
                controller: emailController,
                cursorColor: const Color(0xFF7C4DFF),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color(0xFF7C4DFF),
                    ),
                    labelText: "Enter Your Email",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),
            //this container is for password text field
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
                ],
              ),
              alignment: Alignment.center,
              child: TextField(
                obscureText: !obscText,
                controller: passwordController,
                cursorColor: const Color(0xFF7C4DFF),
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.vpn_key,
                      color: Color(0xFF7C4DFF),
                    ),
                    labelText: "Enter Your Password",
                    //at right side of this text field, 
                    //a eye icon for showing the password or hide it
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye_rounded,
                        color:
                            obscText ? Colors.black : const Color(0xFF7C4DFF),
                      ),
                      onPressed: () {
                        setState(() {
                          //if the obscText is false, then it will become true,
                          // if again pressed, then the true will become false again.
                          obscText = !obscText;
                        });
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),
            //container for forgot password text
            Container(
              margin: const EdgeInsets.only(top: 30, right: 20),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(fontSize: 18, color: Color(0xFF7C4DFF)),
                ),
                onTap: () => {},
              ),
            ),

            //sign in button design and method call
            GestureDetector(
              onTap: () => {
                signIn()
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
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 20),
                        blurRadius: 50,
                        color: Color(0xFF7C4DFF),
                      )
                    ]),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),

            //only a text container half and half is a text button for signup
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't Have Account?",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  //registration navigator button
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()))
                    },
                    child: const Text(
                      " Register Now!",
                      style: TextStyle(
                          fontSize: 18, color: Color(0xFF7C4DFF)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
