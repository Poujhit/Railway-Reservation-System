import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:universal_html/html.dart';
import '../models/trains.dart';

class TrainProvider {
  static Stream<List<Train>> getTrainDetails(String from, String to) {
    var alldocs = FirebaseFirestore.instance
        .collection('train')
        .where('source', isEqualTo: from)
        .where('destination', isEqualTo: to)
        .limit(1)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => Train(
                arrivaltime: e.get('arrival_time') ?? '',
                depaturetime: e.get('depature_time') ?? '',
                destination: e.get('destination') ?? '',
                seatprice: e.get('seat_price') ?? {},
                source: e.get('source') ?? '',
                trainname: e.get('train_name') ?? '',
                trainno: e.get('train_no') ?? '',
              ),
            )
            .toList());
    return alldocs;
  }

  static Future<TrainDetails> getTrainStatus(String date, String trainno) async {
    var traindoc =
        await FirebaseFirestore.instance.collection('train').where('train_no', isEqualTo: trainno).limit(1).get();

    var trainstatus =
        await traindoc.docs.first.reference.collection('trainStatus').where('date', isEqualTo: date).limit(1).get();
    var finalTrainStatus = trainstatus.docs
        .map(
          (e) => TrainDetails(
            availableAcSeats: e.get('available_ac_seats'),
            availableNorSeats: e.get('available_nor_seats'),
            availableSleeperSeats: e.get('available_sleeper_seats'),
            date: e.get('date'),
            bookedAcSeats: e.get('booked_ac_seats'),
            bookedNorSeats: e.get('booked_nor_seats'),
            bookedSleeperSeats: e.get('booked_sleeper_seats'),
          ),
        )
        .toList();

    print(trainstatus.docs.first.data());

    return finalTrainStatus.first;
  }

  static Future<int> fetchBookedSeatOfType(
    String date,
    String trainno,
    String seattype,
  ) async {
    var traindoc =
        await FirebaseFirestore.instance.collection('train').where('train_no', isEqualTo: trainno).limit(1).get();
    var trainstatus =
        await traindoc.docs.first.reference.collection('trainStatus').where('date', isEqualTo: date).limit(1).get();
    if (seattype == 'ac') {
      print('ac seats: ${trainstatus.docs.first.get('booked_ac_seats')}');
      return trainstatus.docs.first.get('booked_ac_seats');
    } else if (seattype == 'nor') {
      return trainstatus.docs.first.get('booked_nor_seats');
    } else
      return trainstatus.docs.first.get('booked_sleeper_seats');
  }

  static Future<void> updateTrainStatusForThatDayAfterBookingOneTicket(
      String date, String trainno, String seatType, int noOfBookedSeats) async {
    var traindoc =
        await FirebaseFirestore.instance.collection('train').where('train_no', isEqualTo: trainno).limit(1).get();
    var trainstatus =
        await traindoc.docs.first.reference.collection('trainStatus').where('date', isEqualTo: date).limit(1).get();
    if (seatType == 'ac') {
      print('here');
      print(trainstatus.docs.first.reference);
      await trainstatus.docs.first.reference.update({
        'booked_ac_seats': noOfBookedSeats + 1,
      });
    } else if (seatType == 'nor') {
      await trainstatus.docs.first.reference.update({
        'booked_nor_seats': noOfBookedSeats + 1,
      });
    } else if (seatType == 'sleeper') {
      await trainstatus.docs.first.reference.update({
        'booked_sleeper_seats': noOfBookedSeats + 1,
      });
    }
  }
}
