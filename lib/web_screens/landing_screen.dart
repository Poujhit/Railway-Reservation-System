import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:railway_reservation_website/provider/auth.dart';

import 'package:railway_reservation_website/web_screens/booking_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/head_bar.dart';

class LandingPageScreen extends StatefulWidget {
  @override
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  String fromdropdownValue = 'Chennai';
  String todropdownValue = 'Delhi';
  String date = '';

  Widget fromdropdown() {
    return StatefulBuilder(
      builder: (context, setDropState) {
        return Container(
          child: DropdownButton(
            isExpanded: true,
            value: fromdropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 10,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
            underline: Container(
              height: 2,
            ),
            onChanged: (String newValue) async {
              if (newValue == 'NA')
                Fluttertoast.showToast(msg: 'Choose a Proper Flat Number.', toastLength: Toast.LENGTH_SHORT);
              else {
                setDropState(() {
                  fromdropdownValue = newValue;
                });
              }
            },
            items: <String>[
              //total combinations of trains is 20.
              'Chennai',
              'Delhi',
              'Mumbai',
              'Kolkata',
            ].map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget todropdown() {
    return StatefulBuilder(
      builder: (context, setDropState) {
        return Container(
          child: DropdownButton(
            isExpanded: true,
            value: todropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 10,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
            underline: Container(
              height: 2,
            ),
            onChanged: (String newValue) async {
              if (newValue == 'NA')
                Fluttertoast.showToast(msg: 'Choose a Proper Flat Number.', toastLength: Toast.LENGTH_SHORT);
              else {
                setDropState(() {
                  todropdownValue = newValue;
                });
              }
            },
            items: <String>[
              'Delhi',
              'Kolkata',
              'Mumbai',
              'Chennai',
            ].map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var p = DateFormat('dd-MM-yyyy').format(DateTime(2020, 11, 13).subtract(Duration(days: 1)));
    print(p);
    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // for (int i = 0; i <= 6; i++) {
      //     //   var p = DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: i)));
      //     //   await FirebaseFirestore.instance
      //     //       .collection('train')
      //     //       .doc('v5d0wTmM6dBlfricsrjQ')
      //     //       .collection('trainStatus')
      //     //       .doc(p)
      //     //       .set({
      //     //     'available_ac_seats': 10,
      //     //     'available_nor_seats': 15,
      //     //     'available_sleeper_seats': 10,
      //     //     'booked_ac_seats': 0,
      //     //     'booked_nor_seats': 0,
      //     //     'booked_sleeper_seats': 0,
      //     //     'date': p,
      //     //   });
      //     // }
      //   },
      // ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          HeadBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.35,
                    right: MediaQuery.of(context).size.width * 0.35,
                    top: 30,
                    bottom: 20,
                  ),
                  height: MediaQuery.of(context).size.height * 0.9 - 70,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text(
                                'Book',
                                style: TextStyle(
                                  fontSize: 50,
                                  color: Theme.of(context).primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                ' Your ticket',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    ' From:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: fromdropdown(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    ' To:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: todropdown(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '  Choose Date:',
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    date == '' ? ' Date not taken yet' : '$date',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                      top: 13,
                                      bottom: 13,
                                      left: 25,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.calendar_today,
                                      ),
                                      onPressed: () async {
                                        SharedPreferences pref = await SharedPreferences.getInstance();
                                        var pickedDate = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            Duration(days: 6),
                                          ),
                                          initialDate: DateTime.now(),
                                        );
                                        if (pickedDate == null)
                                          date = '';
                                        else {
                                          setState(() {
                                            date = DateFormat('dd-MM-yyyy').format(pickedDate);
                                          });
                                          pref.setString('pickedDate', date);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(25),
                            child: SizedBox.expand(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  'Find Trains',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onPressed: () async {
                                  bool checkLogin = await Provider.of<Auth>(context, listen: false).autoLogin();
                                  if (todropdownValue == fromdropdownValue && date != '')
                                    Fluttertoast.showToast(msg: 'Both To and From destinations should not be same');
                                  else if (date == '' && todropdownValue != fromdropdownValue) {
                                    Fluttertoast.showToast(msg: 'Choose Date.');
                                  } else if (date == '' && todropdownValue == fromdropdownValue) {
                                    Fluttertoast.showToast(
                                        msg: 'Both To and From destinations should not be same and Choose the Date.');
                                  } else if (checkLogin == false) {
                                    Fluttertoast.showToast(msg: 'Login/SignIn via Google to Continue.');
                                  } else {
                                    // This below function down there is run to update the trainStatus for each day.
                                    // Each train has status for seven days. After a day in tht seven days is over,
                                    //this function below updates the day and seats are refreshed.
                                    //this below function has made into a python script.
                                    // var s = await FirebaseFirestore.instance.collection('train').get();

                                    // s.docs.forEach((eachTrain) async {
                                    //   var eachTrainStatus = await eachTrain.reference
                                    //       .collection('trainStatus')
                                    //       .doc(DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 6))))
                                    //       .get();
                                    //   print(eachTrainStatus.exists);
                                    //   print(eachTrainStatus.reference);
                                    //   if (!eachTrainStatus.exists) {
                                    //     await eachTrain.reference
                                    //         .collection('trainStatus')
                                    //         .doc(DateFormat('dd-MM-yyyy')
                                    //             .format(DateTime.now().subtract(Duration(days: 1))))
                                    //         .delete();
                                    //     await eachTrain.reference
                                    //         .collection('trainStatus')
                                    //         .doc(DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 6))))
                                    //         .set({
                                    //       'available_ac_seats': 10,
                                    //       'available_nor_seats': 15,
                                    //       'available_sleeper_seats': 10,
                                    //       'date':
                                    //           DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 6))),
                                    //       'booked_ac_seats': 0,
                                    //       'booked_nor_seats': 0,
                                    //       'booked_sleeper_seats': 0,
                                    //     });
                                    //   } //this is the logic for refreshing train status.
                                    // });

                                    var p = await SharedPreferences.getInstance();
                                    p.setString('from', fromdropdownValue);
                                    p.setString('to', todropdownValue);
                                    Navigator.of(context).pushNamed(
                                      BookingScreenPage.route,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
