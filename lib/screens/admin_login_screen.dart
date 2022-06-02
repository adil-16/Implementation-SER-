import 'package:email_password_login/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AdminLoginScreen> {

  //Form key 
    final _formkey = GlobalKey<FormState>();

    //Edittin controller 
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController =  TextEditingController();

    final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    // Email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return ("Please enter admin email");
        }
        // Reg expression for email validation 
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return ("Please Enter admin email ");
        }
        return null;
      },
      onSaved: (value){
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Admin email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

    // password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value){
        RegExp regExp = RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return "Password is required for admin login";
        }
        if(!regExp.hasMatch(value)){
          return "Enter valid password (Min. 6 characters)";
        }
      },
      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Admin password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );
    

    final loginBtn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        color: Colors.redAccent,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          "Login", 
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      )
    );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: (){
            //passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child:Image.asset("assets/logo.png",fit: BoxFit.contain,)
                    ),
                    const SizedBox(height: 45,),
                    emailField, 
                    const SizedBox(height: 25,),
                    passwordField, 
                    const SizedBox(height: 35,),
                    loginBtn,
                    const SizedBox(height: 15,),
                    ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Log in function 
  void signIn(String email, String password) async {
    if(_formkey.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email, password: password)
      .then((uid) => {
        Fluttertoast.showToast(msg: "Log in successfull"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()))
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message.toString());
      });
    }
  }
}