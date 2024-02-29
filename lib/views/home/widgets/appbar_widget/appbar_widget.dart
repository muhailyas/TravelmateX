import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelmatex/utils/constants/constants.dart';

import '../../../widgets/location_widget/location_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.userDocRef,
  });

  final DocumentReference<Object?> userDocRef;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: FittedBox(
            child: Text(
              "Travelling Today?",
              style: googleFontStyle(
                  fontsize: MediaQuery.of(context).textScaleFactor * 35,
                  fontweight: FontWeight.w600),
            ),
          ),
        ),
        const Row(
          children: [Icon(Icons.location_on), LocationAccess()],
        )
      ],
    );
  }
}
