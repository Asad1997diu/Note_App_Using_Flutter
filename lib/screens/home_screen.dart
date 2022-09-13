import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/style/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.maincolor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Daily Notes"),
        centerTitle: true,
        backgroundColor: AppStyle.maincolor,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your recent Notes", style: AppStyle.mainTitle),
            SizedBox(height: 20.0),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
              builder: (context, AsyncSnapshot snapshot)
              {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.hasData){
                  return GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2));
                }
                return Text("There IS No Notes", style: AppStyle.contentTitle);
              },
            )
          ],

      ),

      ),
    );
  }
}
