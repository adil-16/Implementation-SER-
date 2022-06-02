import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password_login/models/user_model.dart';
import 'package:email_password_login/screens/home_screen.dart';
import 'package:email_password_login/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();

  final TextEditingController fNameController = TextEditingController();
  final TextEditingController sNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final fNameField = TextFormField(
      autofocus: false,
      controller: fNameController,
      keyboardType: TextInputType.name,
      validator: (value){
        RegExp regExp = RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return "First name cannot be empty";
        }
        if(!regExp.hasMatch(value)){
          return "Enter valid name (Min. 3 characters)";
        }
          return null;
      },
      onSaved: (value){
        fNameController.text = value!;
      },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.supervised_user_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
        ), 
    );

    final sNameField = TextFormField(
      autofocus: false,
      controller: sNameController,
      keyboardType: TextInputType.name,
            validator: (value){
        if(value!.isEmpty){
          return "Second name cannot be empty";
        }
        return null;
      },
      onSaved: (value){
        sNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.supervised_user_circle),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

      final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return ("please Enter your email");
        }
        // Reg expression for email validation 
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return ("Plese Enter a valid email ");
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
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

      final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: (value){
        RegExp regExp = RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return "Password is required for login";
        }
        if(!regExp.hasMatch(value)){
          return "Enter valid password (Min. 6 characters)";
        }
      },
      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

      final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordController,
      obscureText:true,
      keyboardType: TextInputType.visiblePassword,
      validator: (value){
        if(confirmPasswordController.text != passwordController.text){
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value){
        confirmPasswordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

    final signUpBtn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: (){
          signUp(emailController.text, passwordController.text);

        },
        color: Colors.redAccent,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color:Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
      body:Center(
        child: SingleChildScrollView(
          child: Container(
            color:Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key:_formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        child: Image.asset("assets/logo.png", fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 30,),
                      fNameField,
                      const SizedBox(height: 20,),
                      sNameField,
                      const SizedBox(height: 20,),
                      emailField,
                      const SizedBox(height: 20,),
                      passwordField,
                      const SizedBox(height: 20,),
                      confirmPasswordField,
                      const SizedBox(height: 30,),
                      signUpBtn,
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => const LoginScreen()
                                  ),
                                );
                            },
                            child: const Text("Login", style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      )
                      ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }

  void signUp(String email, String password)async{
    if(_formkey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        pastDatailsToFireStore()
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.meessage.toString());
      });
    }
  }
  pastDatailsToFireStore () async{
    // call firestore 
    // calling user model
    // sendin the value 

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing alll the values 
    userModel.email = user!.email;
    userModel.uId = user.uid;
    userModel.firstName = fNameController.text;
    userModel.secondName = sNameController.text;

    await firebaseFirestore.collection("users").doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Accoutn created successfully :) ");

    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
  }
}