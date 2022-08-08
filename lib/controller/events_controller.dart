import 'dart:developer';

import 'package:efood_multivendor/data/api/api.dart';
import 'package:efood_multivendor/data/model/body/event_model.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/view/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsController extends GetxController {
  List<Event> _events = [];
  final BuildContext _context;

  EventsController(this._context);

  List<Event> get events => _events;

  @override
  void onInit() {
    // TODO: implement onInit
    getEvents();
    super.onInit();
  }

  void getEvents() async {
    try {
      Map dataReturned = await API().getRequest(
        url: AppConstants.EVENTS_URI,
      );
      List listOfEventsJson = [];
      listOfEventsJson = dataReturned['data'];
      log(listOfEventsJson.toString());
      print("-----------------------------------------------------");
      log(listOfEventsJson.toString());
      for (int i = 0; i < listOfEventsJson.length; i++) {
        _events.add(
          Event(
            id: listOfEventsJson[i]['id'],
            address: listOfEventsJson[i]['address'],
            date: listOfEventsJson[i]['date'],
            description: listOfEventsJson[i]['description'],
            endDate: listOfEventsJson[i]['end_date'],
            startDate: listOfEventsJson[i]['start_date'],
            title: listOfEventsJson[i]['title'],
          ),
        );
      }
      update();
    } catch (e, t) {
      log("Error in getEvents in category controller $e");
      print(t);
      Scaffold.of(_context).showSnackBar(
        SnackBar(
          content: Text('Error, try again later'),
        ),
      );
    }
  }

  void attendingEvent(int id) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String token = _sharedPreferences.get(AppConstants.TOKEN);
    // print(token);
    try {
      Map dataReturned = await API().getRequest(
        url: "https://repuffapp.com/api/v1/events/attend/$id?attend=1",
        //body: ,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      log(dataReturned.toString());
      Get.snackbar('ATTENDING!', 'We noticed that you will attend');
      Get.to(DashboardScreen(pageIndex: 0));
      // Scaffold.of(_context).showSnackBar(
      //   SnackBar(
      //     content: Text('Error, try again later'),
      //   ),
      // );

      update();
    } catch (e, t) {
      log("Error in getEvents in category controller ");
      print(t);
      Get.snackbar('There is a problem try again later', e);
    }
  }

  void notAttendingEvent(int id) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String token = _sharedPreferences.get(AppConstants.TOKEN);

    try {
      Map dataReturned = await API().getRequest(
        url: "https://repuffapp.com/api/v1/events/attend/$id?attend=0",
        //body: ,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      Get.snackbar('NOT ATTENDING!', 'We noticed that you will NOT attend');
      Get.to(DashboardScreen(pageIndex: 0));
      // Scaffold.of(_context).showSnackBar(
      //   SnackBar(
      //     content: Text('Error, try again later'),
      //   ),
      // );

      update();
    } catch (e, t) {
      log("Error in getEvents in category controller $e");
      print(t);
      Get.snackbar('ERROR!', 'There is a problem try again later');
    }
  }
}
