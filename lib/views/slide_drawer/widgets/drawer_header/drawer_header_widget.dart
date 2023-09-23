
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({
    super.key,
    required this.userDocRef,
  });

  final DocumentReference<Object?> userDocRef;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.170,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/splash.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: StreamBuilder<DocumentSnapshot>(
        stream: userDocRef.snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic>? data =
                snapshot.data!.data() as Map<String, dynamic>?;
            if (data != null) {
              String name = data['name'];
              String email = data['email'];
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                      ),
                      Text(
                        name,
                        style: googleFontStyle(
                          fontweight: FontWeight.w600,
                          fontsize: 25,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        email,
                        style: googleFontStyle(
                          fontweight: FontWeight.w400,
                          fontsize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
