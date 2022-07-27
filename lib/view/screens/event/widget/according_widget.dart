import 'package:auto_size_text/auto_size_text.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key key, @required this.title, @required this.content})
      : super(key: key);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showContent = !_showContent;
        });
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: Dimensions.WEB_MAX_WIDTH,
            height: _showContent ? 180 : 100,
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.black)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("12/5/2022",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: Colors.grey)),
                    Text("1:00PM - 06:00PM",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: Colors.grey)),
                  ],
                ),
                Text("Child Park - Makram Ebeid - NASR CITY",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey)),
                _showContent
                    ? Flexible(
                      child: AutoSizeText(widget.content,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: Theme.of(context).primaryColor)),
                    )
                    : Container()
              ],
            ),
          ),
          _showContent
              ? Positioned(
                  bottom: -20,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {},
                            child: Text(
                              "Attending",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                      SizedBox(width: 50),
                      SizedBox(
                        width: 150,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {},
                            child: Text(
                              " NOT Attending",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
