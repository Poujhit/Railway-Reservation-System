import 'package:flutter/material.dart';

import 'package:railway_reservation_website/widgets/add_passenger_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/head_bar.dart';
import '../models/trains.dart';
import '../provider/train_provider.dart';

class BookingScreenPage extends StatelessWidget {
  static const route = '/home/booking';
  Future<Map<String, String>> bookingdetails() async {
    var pref = await SharedPreferences.getInstance();
    print(
      pref.getString('from'),
    );
    print(pref.getString('to'));
    print('date:${pref.getString('pickedDate')}');
    return {
      'from': pref.getString('from'),
      'to': pref.getString('to'),
      'date': pref.getString('pickedDate'),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          HeadBar(),
          SliverFillRemaining(
            child: FutureBuilder(
              future: bookingdetails(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return StreamBuilder(
                        stream: TrainProvider.getTrainDetails(snapshot.data['from'], snapshot.data['to']),
                        builder: (ctx, AsyncSnapshot<List<Train>> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'Book Your Ticket',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Card(
                                    // elevation: 10,
                                    margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width * 0.4,
                                      right: MediaQuery.of(context).size.width * 0.4,
                                    ),
                                    shadowColor: Colors.black,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: 20,
                                            top: 10,
                                            bottom: 15,
                                          ),
                                          child: Text(
                                            'Available Trains:',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        //put here
                                        Container(
                                          alignment: Alignment.center,
                                          child: InkWell(
                                            onTap: () {
                                              showGeneralDialog(
                                                  barrierDismissible: true,
                                                  barrierLabel: 'hello',
                                                  context: context,
                                                  pageBuilder: (ctx, _, __) {
                                                    return Dialog(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(15.0),
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * 0.3,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                top: 20.0,
                                                                left: 20,
                                                                right: 20,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    'Train Number: ',
                                                                    style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${streamSnapshot.data.first.trainno}',
                                                                    style: TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                left: 20,
                                                                right: 20,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    'Train Name: ',
                                                                    style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${streamSnapshot.data.first.trainname}',
                                                                    style: TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                left: 20,
                                                                right: 20,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    'Source: ',
                                                                    style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${streamSnapshot.data.first.source}',
                                                                    style: TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                left: 20,
                                                                right: 20,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    'Destination: ',
                                                                    style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${streamSnapshot.data.first.destination}',
                                                                    style: TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                left: 20,
                                                                right: 20,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    'Arrival Time: ',
                                                                    style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${streamSnapshot.data.first.arrivaltime}',
                                                                    style: TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                left: 20,
                                                                right: 20,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    'Depature Time: ',
                                                                    style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${streamSnapshot.data.first.depaturetime}',
                                                                    style: TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              'Seat Price: ',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(left: 5),
                                                              child: Text(
                                                                'Ac Price: ₹${streamSnapshot.data.first.seatprice['ac_seatprice']}',
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(left: 5),
                                                              child: Text(
                                                                'Normal Price: ₹${streamSnapshot.data.first.seatprice['nor_seatprice']}',
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(left: 5),
                                                              child: Text(
                                                                'Sleeper Price: ₹${streamSnapshot.data.first.seatprice['sleeper_seatprice']}',
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              'Available Seats on ${snapshot.data['date']}: ',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            FutureBuilder(
                                                              future: TrainProvider.getTrainStatus(
                                                                  snapshot.data['date'],
                                                                  streamSnapshot.data.first.trainno),
                                                              builder: (ctx,
                                                                  AsyncSnapshot<TrainDetails> trainStatusSnapshot) {
                                                                if (trainStatusSnapshot.connectionState ==
                                                                    ConnectionState.waiting)
                                                                  return Center(child: CircularProgressIndicator());
                                                                else {
                                                                  return Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.only(left: 5),
                                                                        child: Text(
                                                                          'Ac Tickets: ${trainStatusSnapshot.data.availableAcSeats - trainStatusSnapshot.data.bookedAcSeats} Nos.',
                                                                          style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(left: 5),
                                                                        child: Text(
                                                                          'Normal Tickets: ${trainStatusSnapshot.data.availableNorSeats - trainStatusSnapshot.data.bookedNorSeats} Nos.',
                                                                          style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(left: 5),
                                                                        child: Text(
                                                                          'Sleeper Tickets: ${trainStatusSnapshot.data.availableSleeperSeats - trainStatusSnapshot.data.bookedSleeperSeats} Nos.',
                                                                          style: TextStyle(
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                    ],
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                    right: 5,
                                                                    bottom: 5,
                                                                  ),
                                                                  child: ElevatedButton(
                                                                    onPressed: () => Navigator.of(ctx).pop(),
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
                                            },
                                            child: Text(
                                              streamSnapshot.data.first.trainname,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blueAccent,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Center(
                                    child: Text(
                                      'Enter Passenger Details:',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  AddPassengerDetails(
                                    snapshot.data,
                                    streamSnapshot.data.first.trainno,
                                    streamSnapshot.data.first.seatprice['ac_seatprice'],
                                    streamSnapshot.data.first.seatprice['nor_seatprice'],
                                    streamSnapshot.data.first.seatprice['sleeper_seatprice'],
                                  ),
                                  SizedBox(height: 50),
                                ],
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        });
                  } else {
                    return Text('');
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
