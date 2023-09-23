import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<DocumentSnapshot>(
                      stream: userDocRef.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.exists) {
                          Map<String, dynamic>? data =
                              snapshot.data!.data() as Map<String, dynamic>?;
                          return data != null
                              ? Text(
                                  "Hi ${data['name']},",
                                  style: googleFontStyle(
                                      fontsize: 25,
                                      fontweight: FontWeight.w400,
                                      color: Colors.grey),
                                )
                              : const SizedBox();
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                  Text(
                    "Travelling Today?",
                    style: googleFontStyle(
                        fontsize: 35, fontweight: FontWeight.w600),
                  )
                ],
              ),
              IconButton(
                  splashColor: transparentColor,
                  splashRadius: 1,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu))
            ],
          ),
        ),
        Container(
          height: screenHeight * 0.06,
          width: 420,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 245, 242, 242),
          ),
          child: const TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_rounded, color: Colors.black),
                hintText: 'Search destination...',
                hintTextDirection: TextDirection.ltr,
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
        height10,
        // Container(
        //   color: Colors.amber,
        //   height: 100,
        //   width: 420,
        //   child: ListView.builder(
        //     itemBuilder: (context, index) => Container(
        //       height: 70,
        //       width: 100,
        //       color: Colors.yellow,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
