import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/routes/app_routes.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/slide_drawer/widgets/edit_tile/edit_tile_widget.dart';
import 'widgets/drawer_header/drawer_header_widget.dart';
import 'widgets/logout_tile_widget/logout_tile_widget.dart';

// class SlideDrawer extends StatelessWidget {
//   const SlideDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     final DocumentReference userDocRef =
//         FirebaseFirestore.instance.collection('users').doc(user!.uid);
//     return Drawer(
//       width: MediaQuery.of(context).size.width * .6,
//       child: Column(
//         children: [
//           DrawerHeaderWidget(userDocRef: userDocRef),
//           EditTileWidget(userDocRef: userDocRef),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.info),
//             title: Text(
//               "About",
//               style: googleFontStyle(fontsize: 18, fontweight: FontWeight.w400),
//             ),
//             onTap: () {
//               Get.toNamed(AppRoutes.about);
//             },
//           ),
//           const Divider(),
//           const LogoutTileWidget(),
//           const Divider(),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 5),
//             child: Text("version: 1.0.0+1",
//                 style: googleFontStyle(
//                     fontsize: 16,
//                     color: Colors.grey,
//                     fontweight: FontWeight.w400)),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'dart:ui';

class SlideDrawer extends StatelessWidget {
  const SlideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    // Wrap the Drawer with a BackdropFilter to apply the blur effect
    return Drawer(
      width: MediaQuery.of(context).size.width * .6,
      child: Column(
        children: [
          DrawerHeaderWidget(userDocRef: userDocRef),
          EditTileWidget(userDocRef: userDocRef),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(
              "About",
              style: googleFontStyle(
                  fontsize: MediaQuery.of(context).textScaleFactor * 18,
                  fontweight: FontWeight.w400),
            ),
            onTap: () {
              Get.toNamed(AppRoutes.about);
            },
          ),
          const Divider(),
          const LogoutTileWidget(),
          const Divider(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("version: 1.0.0+1",
                style: googleFontStyle(
                    fontsize: MediaQuery.of(context).textScaleFactor * 16,
                    color: Colors.grey,
                    fontweight: FontWeight.w400)),
          )
        ],
      ),
    );
  }
}
