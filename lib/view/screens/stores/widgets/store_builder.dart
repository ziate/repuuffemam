import 'package:efood_multivendor/helper/get_substring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StoreItemBuilder extends StatelessWidget {
  const StoreItemBuilder(
      {Key key, this.rate = 0, this.storeName = "", this.imageUrl = ""})
      : super(key: key);
  final int rate;
  final String storeName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              child: Image.asset(
                imageUrl,
                // fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        getSubString(storeName),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: 18,
                        initialRating: rate.toDouble(),
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Color(0xff800022),
                        ),
                        onRatingUpdate: (rating) {
                          //  rating = model.noOfRatings!.toDouble();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
