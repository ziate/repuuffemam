import 'package:auto_size_text/auto_size_text.dart';
import 'package:efood_multivendor/controller/events_controller.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;
  //final int id;
  //final String title;
  // final String description;
  final String date;
  final String address;
  final String startDate;
  final String endDate;
  final int id;

  const Accordion(
      {Key key,
      @required this.title,
      @required this.content,
      this.date,
      this.address,
      this.startDate,
      this.endDate,
      @required this.id})
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
                border: Border.all(color: Colors.grey, width: 0.25),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        color: Colors.white)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.date,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: Colors.white)),
                    Text("${widget.startDate} - ${widget.endDate}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: Colors.white)),
                  ],
                ),
                Text(widget.address,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.white)),
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
                        child: GetBuilder<EventsController>(
                          init: EventsController(context),
                          builder: (eventsController) => TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              onPressed: () {
                                print("Pressed");
                                eventsController.attendingEvent(widget.id);
                                print("worked");
                              },
                              child: Text(
                                "Attending",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                      ),
                      SizedBox(width: 50),
                      SizedBox(
                        width: 150,
                        child: GetBuilder<EventsController>(
                          builder: (eventsController) => TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              onPressed: () {
                                eventsController.notAttendingEvent(widget.id);
                              },
                              child: Text(
                                " NOT Attending",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
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
