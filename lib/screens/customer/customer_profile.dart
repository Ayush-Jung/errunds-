import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/custom_text_field.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/screens/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({Key key, this.active}) : super(key: key);
  final bool active;

  @override
  _CustomerProfileScreenState createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
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
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UpdateProfileScreen()),
          );
        },
        child: const Text("Edit"),
      ),
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: buttonBackgroundColor,
        title: const Center(
          child: Text("Profile"),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.zero,
                color: primaryColor,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16),
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withAlpha(40),
                        backgroundImage: NetworkImage(user.imageUrl ?? ""),
                        child: user.imageUrl == null
                            ? Icon(Icons.person,
                                color: buttonBackgroundColor,
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
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            user.lName ?? "",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                height: size.height * 0.8,
                color: buttonBackgroundColor,
                child: Container(
                  margin: const EdgeInsets.only(left: 16, top: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(MdiIcons.phone,
                                size: 40, color: Colors.white),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              user.phoneNumber ?? "",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(MdiIcons.mail,
                                size: 40, color: Colors.white),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              user.email ?? "",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(MdiIcons.mapMarker,
                                size: 40, color: Colors.white),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              user.address ?? "",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
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
