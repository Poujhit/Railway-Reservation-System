import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universal_html/html.dart' as html;

import 'package:railway_reservation_website/provider/auth.dart';
import 'package:railway_reservation_website/provider/train_provider.dart';
import 'package:railway_reservation_website/provider/user_provider.dart';

class AddPassengerDetails extends StatefulWidget {
  final Map<String, String> bookingdetails;
  final String trainno;
  final int acprice;
  final int norprice;
  final int sleeperprice;
  AddPassengerDetails(
    this.bookingdetails,
    this.trainno,
    this.acprice,
    this.norprice,
    this.sleeperprice,
  );
  @override
  _AddPassengerDetailsState createState() => _AddPassengerDetailsState();
}

class _AddPassengerDetailsState extends State<AddPassengerDetails> {
  List<DynamicAddPassengerWidget> passengerWidget = [];

  @override
  void initState() {
    passengerWidget.add(DynamicAddPassengerWidget());
    super.initState();
  }

  showdialog(String text) {
    showGeneralDialog(
        barrierDismissible: false,
        barrierLabel: 'hello',
        context: context,
        pageBuilder: (ctx, _, __) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          right: 5,
                          bottom: 5,
                        ),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            html.window.location.reload();
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.blueAccent,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 30,
        ),
        ...passengerWidget,
        Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.46,
            right: MediaQuery.of(context).size.width * 0.46,
          ),
          height: 30,
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.45,
            right: MediaQuery.of(context).size.width * 0.45,
          ),
          height: 50,
          child: RaisedButton(
            child: Text(
              'Book Now',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: () async {
              Fluttertoast.showToast(msg: 'Loading....', toastLength: Toast.LENGTH_LONG);
              var traindetails = await TrainProvider.getTrainStatus(widget.bookingdetails['date'], widget.trainno);
              print(traindetails.bookedAcSeats);
              print(traindetails.bookedNorSeats);
              print(traindetails.bookedSleeperSeats);
              if (traindetails.availableAcSeats == traindetails.bookedAcSeats &&
                  traindetails.availableNorSeats == traindetails.bookedNorSeats &&
                  traindetails.availableSleeperSeats == traindetails.bookedSleeperSeats) {
                showdialog('All Seats are Booked. Try again later.');
              } else {
                int totalcost = 0;
                List<Map> passengerDetails = [];

                passengerWidget.forEach((eachWidget) async {
                  int numberchecking = 0;
                  int seatchecking = 0;
                  int genderchecking = 0;
                  int namechecking = 0;

                  if (int.tryParse(eachWidget.ageController.text) == null || eachWidget.ageController.text == '0') {
                    Fluttertoast.showToast(msg: 'age is invalid enter a valid number', toastLength: Toast.LENGTH_LONG);
                  } else {
                    numberchecking = 1;
                  }
                  if (eachWidget.seattypeController.text.toLowerCase() != 'ac' &&
                      eachWidget.seattypeController.text.toLowerCase() != 'nor' &&
                      eachWidget.seattypeController.text.toLowerCase() != 'sleeper') {
                    Fluttertoast.showToast(
                        msg: 'Seat Type is invalid. Enter properly and dont leave extra spaces.',
                        toastLength: Toast.LENGTH_LONG);
                  } else {
                    seatchecking = 1;
                  }
                  if (eachWidget.genderController.text != 'M' &&
                      eachWidget.genderController.text != 'F' &&
                      eachWidget.genderController.text != 'O') {
                    Fluttertoast.showToast(
                        msg: 'Gender is invalid. Enter properly and in Caps.', toastLength: Toast.LENGTH_LONG);
                  } else {
                    genderchecking = 1;
                  }
                  if (eachWidget.nameController.text == '' || eachWidget.nameController.text == ' ') {
                    Fluttertoast.showToast(msg: 'Name is Empty.', toastLength: Toast.LENGTH_LONG);
                  } else {
                    namechecking = 1;
                  }

                  if (namechecking == 1 && genderchecking == 1 && seatchecking == 1 && numberchecking == 1) {
                    if (eachWidget.seattypeController.text.toLowerCase() == 'ac') {
                      if (traindetails.availableAcSeats == traindetails.bookedAcSeats) {
                        showdialog('All AC Seats are Booked. Try again later.');
                        return;
                      } else {
                        print('fectchbooked doing');
                        var bookedAcSeats = await TrainProvider.fetchBookedSeatOfType(
                          widget.bookingdetails['date'],
                          widget.trainno,
                          eachWidget.seattypeController.text.toLowerCase(),
                        );
                        print('booked seats : $bookedAcSeats');
                        print('fetchbooked done');
                        int ticketno = (traindetails.availableAcSeats - bookedAcSeats).abs();
                        print('ticket no done');
                        print(ticketno);
                        print('adding passenger to list');
                        passengerDetails.add({
                          'age': eachWidget.ageController.text,
                          'gender': eachWidget.genderController.text,
                          'name': eachWidget.nameController.text,
                          'seat_no': ticketno,
                          'status': 1,
                          'seat_type': eachWidget.seattypeController.text.toLowerCase()
                        });
                        print('adding passenger done');
                        totalcost = totalcost + widget.acprice;
                        print('totalcost doneone');
                        print('update trainstatus doing');
                        await TrainProvider.updateTrainStatusForThatDayAfterBookingOneTicket(
                          widget.bookingdetails['date'],
                          widget.trainno,
                          eachWidget.seattypeController.text.toLowerCase(),
                          bookedAcSeats,
                        );
                        print('update trainstatus done');
                      }
                    } else if (eachWidget.seattypeController.text.toLowerCase() == 'nor') {
                      if (traindetails.availableNorSeats == traindetails.bookedNorSeats) {
                        showdialog('All Normal Seats are Booked. Try again later.');
                        return;
                      } else {
                        int ticketno = (traindetails.availableNorSeats - traindetails.bookedNorSeats).abs();
                        print(ticketno);

                        passengerDetails.add({
                          'age': eachWidget.ageController.text,
                          'gender': eachWidget.genderController.text,
                          'name': eachWidget.nameController.text,
                          'seat_no': ticketno,
                          'status': 1,
                          'seat_type': eachWidget.seattypeController.text.toLowerCase()
                        });
                        totalcost = totalcost + widget.norprice;
                        var bookedNorSeats = await TrainProvider.fetchBookedSeatOfType(
                          widget.bookingdetails['date'],
                          widget.trainno,
                          eachWidget.seattypeController.text.toLowerCase(),
                        );
                        await TrainProvider.updateTrainStatusForThatDayAfterBookingOneTicket(
                          widget.bookingdetails['date'],
                          widget.trainno,
                          eachWidget.seattypeController.text.toLowerCase(),
                          bookedNorSeats,
                        );
                      }
                    } else if (eachWidget.seattypeController.text.toLowerCase() == 'sleeper') {
                      if (traindetails.availableSleeperSeats == traindetails.bookedSleeperSeats) {
                        showdialog('All Sleeper Seats are Booked. Try again later.');
                        return;
                      } else {
                        int ticketno = (traindetails.availableSleeperSeats - traindetails.bookedSleeperSeats).abs();
                        print(ticketno);

                        passengerDetails.add({
                          'age': eachWidget.ageController.text,
                          'gender': eachWidget.genderController.text,
                          'name': eachWidget.nameController.text,
                          'seat_no': ticketno,
                          'status': 1,
                          'seat_type': eachWidget.seattypeController.text.toLowerCase()
                        });
                        totalcost = totalcost + widget.sleeperprice;
                        var bookedSleeperSeats = await TrainProvider.fetchBookedSeatOfType(
                          widget.bookingdetails['date'],
                          widget.trainno,
                          eachWidget.seattypeController.text.toLowerCase(),
                        );
                        await TrainProvider.updateTrainStatusForThatDayAfterBookingOneTicket(
                          widget.bookingdetails['date'],
                          widget.trainno,
                          eachWidget.seattypeController.text.toLowerCase(),
                          bookedSleeperSeats,
                        );
                      }
                    }
                  }
                  print('list $passengerDetails');
                  print('total cost $totalcost');
                  if (passengerDetails.isNotEmpty && totalcost != 0 && passengerWidget.length == 1) {
                    await UserProvider.addNewTicketToTheUser(
                      date: widget.bookingdetails['date'],
                      passengers: passengerDetails,
                      totalPrice: totalcost,
                      trainno: widget.trainno,
                    );
                    var p = Auth();
                    var userId = await p.getUserId();
                    await FirebaseFirestore.instance.collection('bookingReceipts').add({
                      'amount': totalcost,
                      'userId': userId,
                    });
                    showdialog('Booking done!!! Go to Edit Profile Page to view Your Ticket Details.');
                  }
                });
              }
            },
          ),
        ),
      ],
    );
  }
}

class DynamicAddPassengerWidget extends StatelessWidget {
  final ageController = TextEditingController();
  final nameController = TextEditingController();
  final seattypeController = TextEditingController();
  final genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
        ),
        elevation: 8,
        shadowColor: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Passenger Age:',
                  ),
                  controller: ageController,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Gender(Enter M for Male, F for Female, O for Others ):',
                    labelStyle: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  controller: genderController,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Passenger Name:',
                  ),
                  controller: nameController,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText:
                        'Enter Seat Type (Enter ac for Ac seats, nor for Normal seats, sleeper for Sleeper seats):',
                    labelStyle: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  controller: seattypeController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
