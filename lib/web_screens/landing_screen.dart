import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
              'Kanyakumari',
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
              'Kanyakumari',
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
    return Scaffold(
      backgroundColor: Colors.white,
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
                                  flex: 2,
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
                                  flex: 2,
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
                                    date == '' ? ' Date not taken yet' : '   $date',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
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
                                      onPressed: () {
                                        showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            Duration(days: 7),
                                          ),
                                          initialDate: DateTime.now(),
                                        ).then((pickedDate) {
                                          setState(() {
                                            date = DateFormat('dd-MM-yyyy').format(pickedDate);
                                          });
                                        });
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
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  'Find Trains',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onPressed: () {},
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
