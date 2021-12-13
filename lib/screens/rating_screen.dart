import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key key, this.rider}) : super(key: key);
  final ErrundUser rider;

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  ErrundUser currentRider;
  bool loading = false;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    setState(() {
      currentRider = widget.rider;
      commentController.text = widget.rider.ratingComment;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        margin: EdgeInsets.zero,
        color: secondaryColor,
        child: Column(
          children: [
            Spacer(
              flex: 1,
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withAlpha(40),
              backgroundImage: NetworkImage(currentRider?.imageUrl ?? ""),
              child: currentRider?.imageUrl == null
                  ? Icon(Icons.person,
                      color: primaryColor,
                      size: MediaQuery.of(context).size.width * 0.25)
                  : const SizedBox(),
              radius: MediaQuery.of(context).size.width * 0.15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                currentRider.fName,
                style: TextStyle(fontSize: 20, color: primaryColor),
              ),
            ),
            RatingBar.builder(
              initialRating: currentRider.rating ?? 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                currentRider.rating = rating;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: TextFormField(
                controller: commentController,
                style: TextStyle(color: primaryColor),
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: primaryColor, width: 4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 4.0),
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
                    borderSide: BorderSide(color: primaryColor, width: 4.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  labelText: 'Comment',
                  labelStyle: TextStyle(color: primaryColor),
                ),
                validator: (value) {
                  value = value.trim();
                  if (value.isEmpty) {
                    return "Mandatory Field";
                  }
                  return null;
                },
                onChanged: (value) {
                  currentRider.ratingComment = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CustomButton(
                  label: "Rate now",
                  loading: loading,
                  circleColor: primaryColor,
                  textColor: secondaryColor,
                  color: primaryColor,
                  onPress: () async {
                    setState(() {
                      loading = true;
                    });
                    await firebase.updateUserById(currentRider);
                    setState(() {
                      loading = false;
                    });
                    Navigator.pop(context);
                  }),
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
