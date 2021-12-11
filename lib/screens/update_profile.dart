import 'dart:io';
import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  File image;
  final picker = ImagePicker();
  ErrundUser currentUser;
  @override
  void initState() {
    firebase.getUserInfo().then((user) {
      if (user != null) {
        try {
          _fnameController.text = user.fName ?? "";
          _lnameController.text = user.lName ?? "";
          _phoneController.text = user.phoneNumber ?? "";
          _addressController.text = user.address ?? "";
        } catch (e) {
          print(e.message);
        }
        if (user != null) {
          setState(() {
            currentUser = user;
          });
        }
      }
    });
    super.initState();
  }

  showPickerDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              ListTile(
                title: const Text("From Camera"),
                leading: const Icon(Icons.camera_alt),
                onTap: () async {
                  Navigator.pop(context);

                  final image =
                      await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    this.image = File(image.path);
                  });
                },
              ),
              ListTile(
                title: const Text("From Gallery"),
                leading: const Icon(Icons.image),
                onTap: () async {
                  Navigator.pop(context);

                  final image =
                      await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    this.image = File(image.path);
                  });
                },
              ),
            ],
          );
        });
  }

  _showSnackbar(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: secondaryColor,
      content: Text(message),
    ));
  }

  showLoading(value) {
    loading = value;
    setState(() {});
  }

  onCompleted() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showLoading(true);
      if (image != null) {
        try {
          currentUser.imageUrl =
              await firebase.uploadFile(image, quality: 40, resize: 300);
        } catch (e) {
          showLoading(false);
          if (e is PlatformException) {
            _showSnackbar(e.message);
          } else {
            _showSnackbar("Something Went Wrong. Try again Later");
          }
          return;
        }
      }
      await firebase.updateUser(currentUser);
      showLoading(false);
      Navigator.pop(context);
    } else {
      _showSnackbar("validation failed");
      showLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        centerTitle: true,
        elevation: 1.2,
        toolbarTextStyle: TextStyle(color: primaryColor),
        title: Text(
          "Update Profile",
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: Column(
        children: [
          if (currentUser == null)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Stack(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(40),
                                radius: MediaQuery.of(context).size.width * 0.2,
                                backgroundImage: image != null
                                    ? FileImage(image)
                                    : currentUser?.imageUrl != null
                                        ? NetworkImage(
                                            currentUser?.imageUrl ?? "",
                                          )
                                        : null,
                                child: image == null &&
                                        currentUser?.imageUrl == null
                                    ? Icon(Icons.person,
                                        color: secondaryColor,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.3)
                                    : const SizedBox(),
                              ),
                              Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: GestureDetector(
                                      onTap: () {
                                        showPickerDialog();
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: const Icon(
                                              MdiIcons.cameraEnhance,
                                              color: Colors.white,
                                              size: 14))))
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(color: primaryColor),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _fnameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide:
                                      BorderSide(color: primaryColor, width: 4),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 4.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  borderSide: BorderSide(width: 4),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 4.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                label: Text(
                                  "First Name",
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) return "Mandatory Field";
                                return null;
                              },
                              onChanged: (value) {
                                currentUser.fName = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(color: primaryColor),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _lnameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide:
                                      BorderSide(color: primaryColor, width: 4),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 4.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 4.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  borderSide: BorderSide(width: 4),
                                ),
                                label: Text(
                                  "Last Name",
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) return "Mandatory Field";
                                return null;
                              },
                              onChanged: (value) {
                                currentUser.lName = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(color: primaryColor),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide:
                                      BorderSide(color: primaryColor, width: 4),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 4.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 4.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  borderSide: BorderSide(width: 4),
                                ),
                                label: Text(
                                  "Phone Number",
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                              validator: (value) {
                                value = value.trim();
                                if (value.isEmpty) {
                                  return "Mandatory Field";
                                }

                                return null;
                              },
                              onChanged: (value) {
                                currentUser.phoneNumber = (value ?? "").trim();
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(color: primaryColor),
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _addressController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide:
                                      BorderSide(color: primaryColor, width: 4),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 4.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 4.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  borderSide: BorderSide(width: 4),
                                ),
                                label: Text(
                                  "Address",
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                              onChanged: (value) {
                                currentUser.address = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Mandatory Field";
                                }

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: CustomButton(
                              label: "Update",
                              labelSize: 18,
                              textColor: secondaryColor,
                              loading: loading,
                              onPress: onCompleted,
                              color: primaryColor,
                              circleColor: secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
