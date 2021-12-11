import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/custom_text_field.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/screens/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key, this.active}) : super(key: key);
  final bool active;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ErrundUser user;
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    user = await firebase.getUserInfo();
    setState(() {});
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomContainer(
                borderColor: primaryColor,
                color: secondaryColor,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 16, bottom: 16),
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withAlpha(40),
                        backgroundImage: NetworkImage(user.imageUrl ?? ""),
                        child: user.imageUrl == null
                            ? Icon(Icons.person,
                                color: secondaryColor,
                                size: MediaQuery.of(context).size.width * 0.25)
                            : const SizedBox(),
                        radius: MediaQuery.of(context).size.width * 0.15,
                      ),
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
                            user.fName ?? "",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            user.lName ?? "",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: primaryColor),
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
                            Icon(MdiIcons.phone, size: 40, color: primaryColor),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              user.phoneNumber ?? "",
                              style:
                                  TextStyle(fontSize: 20, color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(MdiIcons.mail, size: 40, color: primaryColor),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              user.email ?? "",
                              style:
                                  TextStyle(fontSize: 20, color: primaryColor),
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
                              user.address ?? "",
                              style:
                                  TextStyle(fontSize: 20, color: primaryColor),
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
