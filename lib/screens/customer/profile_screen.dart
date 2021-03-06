import 'dart:async';

import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/screens/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key, this.active}) : super(key: key);
  final bool active;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ErrundUser user;
  StreamSubscription userSub;
  @override
  void initState() {
    userSub = firebase.getRealTimeUserInfo((errundUser) {
      if (this.mounted)
        setState(() {
          user = errundUser;
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    userSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 6,
        backgroundColor: secondaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UpdateProfileScreen()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Edit",
                style: TextStyle(color: primaryColor),
              ),
              Icon(MdiIcons.plus, color: primaryColor),
            ],
          ),
        ),
      ),
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 1.2,
        backgroundColor: secondaryColor,
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(color: primaryColor),
          ),
        ),
      ),
      body: SafeArea(
        child: user == null
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CustomContainer(
                      borderColor: primaryColor,
                      color: secondaryColor,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).primaryColor.withAlpha(40),
                            backgroundImage: NetworkImage(user?.imageUrl ?? ""),
                            child: user?.imageUrl == null
                                ? Icon(Icons.person,
                                    color: primaryColor,
                                    size: MediaQuery.of(context).size.width *
                                        0.25)
                                : const SizedBox(),
                            radius: MediaQuery.of(context).size.width * 0.15,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.fName ?? "",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  user?.lName ?? "",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                if (user.isRider)
                                  SmoothStarRating(
                                    isReadOnly: true,
                                    borderColor: primaryColor,
                                    color: primaryColor,
                                    starCount: 5,
                                    size:
                                        MediaQuery.of(context).size.width / 25,
                                    rating: (user.rating ?? 3).toDouble(),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      height: size.height * 0.8,
                      color: secondaryColor,
                      child: Container(
                        margin: const EdgeInsets.only(left: 16, top: 16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(MdiIcons.phone,
                                      size: 40, color: primaryColor),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    user?.phoneNumber ?? "",
                                    style: TextStyle(
                                        fontSize: 20, color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(MdiIcons.mail,
                                      size: 40, color: primaryColor),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    user?.email ?? "",
                                    style: TextStyle(
                                        fontSize: 20, color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(MdiIcons.mapMarker,
                                      size: 40, color: primaryColor),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    user?.address ?? "",
                                    style: TextStyle(
                                        fontSize: 20, color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
