import 'package:email_password_login/screens/admin_login_screen.dart';
import 'package:email_password_login/screens/login_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {

    final logInAsEmployee = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        color: Colors.redAccent,
        padding:  const EdgeInsets.fromLTRB(15, 20, 15, 20),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          "Log in as employee",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    
    final logInAsAdmin = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminLoginScreen()));
        },
        color: Colors.redAccent,
        padding:  const EdgeInsets.fromLTRB(15, 20, 15, 20),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          "Log in as admin",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child:Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children : <Widget>[
                  SizedBox(
                    height: 200,
                    child:Image.asset("assets/logo.png", fit:BoxFit.contain)
                  ),
                  const SizedBox(height: 45,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text("Log in as Employee"),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    logInAsEmployee,
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text("Log in as Admin"),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    logInAsAdmin,
                ],
              )
            ),
          )
        ),
        ),
    );
  }
}