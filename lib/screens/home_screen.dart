import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password_login/models/user_model.dart';
import 'package:email_password_login/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final imageUrl = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png";

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
    .collection("users")
    .doc(user!.uid)
    .get()
    .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    } );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(title: const Text("Welcome"), centerTitle: true,),
      body: Center(child: Padding(padding: const EdgeInsets.all(20), child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/logo.png", fit: BoxFit.contain),
              ),
              const SizedBox(height: 10,),
              const Text("Speech Emotion Recognition",textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,  ),),
              const SizedBox(height: 15),
              ActionChip(label: const Text("Logout"), onPressed: (){
                logout(context);
              }),
            ],
          ),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(color: Colors.redAccent),
              accountName: Text("${loggedInUser.firstName}"),
              accountEmail: Text("${loggedInUser.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.home,
            ),
            title: Text(
              "Profile",
              textScaleFactor: 1.2,
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.person_circle,
            ),
            title: Text(
              "Employee Management",
              textScaleFactor: 1.2,
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.card_membership_rounded,
            ),
            title: Text(
              "Trainings",
              textScaleFactor: 1.2,
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.settings,
            ),
            title: Text(
              "Settings",
              textScaleFactor: 1.2,
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.computer_outlined,
            ),
            title: Text(
              "AI Configuration",
              textScaleFactor: 1.2,
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.feedback_outlined,
            ),
            title: Text(
              "Feedback",
              textScaleFactor: 1.2,
            ),
          ),
          ActionChip(label: const Text("Logout"), onPressed: (){
            logout(context);
          }),
        ],
      ),
    ),
    );
  }

  Future<void> logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
    .pushReplacement(MaterialPageRoute(builder: (context) =>  const LoginScreen()));
  }
}