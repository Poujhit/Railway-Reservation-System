import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:railway_reservation_website/provider/auth.dart';
import '../models/user.dart';
import '../models/ticket.dart';

class UserProvider {
  static Stream<List<User>> getUserDetails(String userId) {
    var alldocs = FirebaseFirestore.instance
        .collection('users')
        .where('user_id', isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => User(
                email: e.get('email') ?? '',
                name: e.get('name') ?? '',
                profileUrl: e.get('profile_url') ?? '',
                userId: e.get('user_id') ?? '',
              ),
            )
            .toList());
    return alldocs;
  }

  static Stream<List<Ticket>> getuserTickets(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tickets')
        .orderBy('sno', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => Ticket(
                passengers: e.get('passengers') ?? [],
                ticId: e.get('tic_id') ?? '',
                ticketStatus: e.get('ticket_status') ?? 0,
                totalPrice: e.get('total_price') ?? 0,
                sno: e.get('sno') ?? 0,
                date: e.get('date'),
                trainno: e.get('train_no') ?? '',
              ),
            )
            .toList());
  }

  static Future<void> editUserName(String newUserName, dynamic userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'name': newUserName,
    });
  }

  static Future<void> editEmail(String newEmail, dynamic userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'email': newEmail,
    });
  }

  static Future<void> editProfilePhoto(String newurl, dynamic userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'profile_url': newurl,
    });
  }

  static Future<void> addNewTicketToTheUser({
    String date,
    List<dynamic> passengers,
    int totalPrice,
    String trainno,
  }) async {
    var auth = Auth();
    var userid = await auth.getUserId();
    var userDetails = await FirebaseFirestore.instance.collection('users').where('user_id', isEqualTo: userid).get();
    String randomId = userDetails.docs.first.reference.collection('tickets').doc().id;
    var allTickets = await userDetails.docs.first.reference.collection('tickets').get();
    var currSno = allTickets.docs.length;

    userDetails.docs.first.reference.collection('tickets').doc(randomId).set({
      'date': date,
      'passengers': passengers,
      'sno': currSno + 1,
      'tic_id': randomId,
      'ticket_status': 1,
      'total_price': totalPrice,
      'train_no': trainno,
    });
  }
}
