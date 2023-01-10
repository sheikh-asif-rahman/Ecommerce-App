import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/screens/loginscreen.dart';
import 'package:project/screens/user_form.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<RegistrationScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;



  //registration function
  signUp()async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );

      var authCredential = userCredential.user;
      //print(authCredential!.uid);
      if(authCredential!.uid.isNotEmpty) {
        Navigator.push(context, CupertinoPageRoute(builder: (_) => UserForm()));
      }else{
        Fluttertoast.showToast(msg: "Something is Wrong");
      }

    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password'){
        Fluttertoast.showToast(msg: "Password is too weak");

      }else if (e.code =='email-already-in-use'){
        Fluttertoast.showToast(msg: "The account already exists for that email.");

      }
    } catch (e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)
                  ),
                  color: const Color(0xFF7C4DFF),
                  gradient: LinearGradient(
                    colors: [(new Color(0xFF651FFF)), (new Color(0xFF7C4DFF))],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
              ),

              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      height: 100,
                      width: 100,
                      child: Image.asset("images/logo.jpg"),
                    ),

                    //Registration Text
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      alignment: Alignment.bottomRight,
                      child: const Text(
                        "Registration",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            //User Name Container



            //Email Container

            Container(
              margin: const EdgeInsets.only(left: 20,right: 20,top: 70),
              padding: const EdgeInsets.only(left: 20,right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: const [BoxShadow(
                    offset: Offset(0,20),
                    blurRadius: 50,
                    color: Color(0xFF7C4DFF),
                  )]
              ),
              alignment: Alignment.center,
              child: TextField(

                // control word for email

                controller: emailController,


                cursorColor: const Color(0xFF7C4DFF),
                decoration: const InputDecoration(
                    icon: Icon(Icons.email,
                      color: Color(0xFF7C4DFF),
                    ),
                    labelText: "Enter Your Email",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none
                ),
              ),
            ),

            //Phone Number Container



            //Password Container


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
                  )]
              ),
              alignment: Alignment.center,
              child: TextField(

                //control word for password
                controller: passwordController,
                obscureText: true,
                cursorColor: const Color(0xFF7C4DFF),
                decoration: const InputDecoration(
                    icon: Icon(Icons.vpn_key,
                      color: Color(0xFF7C4DFF),
                    ),
                    labelText: "New password",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none
                ),
              ),
            ),

            //Register Button

            GestureDetector(
              onTap: ()=>{
                signUp()
                /*inClick code here*/
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
                    boxShadow: const [BoxShadow(
                      offset: Offset(0,20),
                      blurRadius: 50,
                      color: Color(0xFF7C4DFF),
                    )]
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ),
            ),

            //Already Have Account container

            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Have An Account?",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  //Back To Login Page

                  GestureDetector(
                    onTap: ()=>{
                      Navigator.push(
                          context,MaterialPageRoute(
                          builder: (context) => const LoginScreen()
                      ))
                    },child: const Text(
                    " Login Now!",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF7C4DFF)
                    ),
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
