import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travelmatex/routes/app_routes.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/slide_drawer/widgets/edit_tile/edit_tile_widget.dart';
import 'widgets/drawer_header/drawer_header_widget.dart';
import 'widgets/logout_tile_widget/logout_tile_widget.dart';

class SlideDrawer extends StatelessWidget {
  const SlideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    return Drawer(
      width: MediaQuery.of(context).size.width * .6,
      child: ListView(
        children: [
          DrawerHeaderWidget(userDocRef: userDocRef),
          EditTileWidget(userDocRef: userDocRef),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.ios_share_rounded),
            title: Text("Share", style: googleFontStyle(fontsize: 18, fontweight: FontWeight.w400),),
            onTap: () async {
              await _onShare(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title:  Text("About", style: googleFontStyle(fontsize: 18, fontweight: FontWeight.w400),),
            onTap: () {
              Get.toNamed(AppRoutes.about);
            },
          ),
          const Divider(),
          const LogoutTileWidget(),
          const Divider(),
        ],
      ),
    );
  }

  _onShare(context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        'https://play.google.com/store/apps/details?id=com.waywizard.travelmate',
        subject: '',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
