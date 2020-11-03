import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:railway_reservation_website/models/ticket.dart';
import 'package:railway_reservation_website/models/user.dart';
import 'package:railway_reservation_website/provider/user_provider.dart';

import '../widgets/head_bar.dart';
import '../provider/auth.dart';

class ProfileEditPageScreen extends StatefulWidget {
  static const route = '/home/editprofile';
  @override
  _ProfileEditPageScreenState createState() => _ProfileEditPageScreenState();
}

class _ProfileEditPageScreenState extends State<ProfileEditPageScreen> {
  int edituserIdmode = 0;
  int editEmailmode = 0;
  int editProfilemode = 0;

  TextEditingController userNameController;
  TextEditingController emailController;
  TextEditingController profileController;

  Widget ticketTile(String hint, String value) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: hintText(text: hint, left: 10, fontsize: 18),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: AutoSizeText(
                value,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget hintText(
      {String text, double top = 0, double left = 0.0, double right = 0, double bottom = 0, double fontsize = 14}) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, bottom: bottom, right: right),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontsize,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget divider() {
    return Divider(
      indent: 100,
      endIndent: 130,
      thickness: 1,
      color: Colors.grey,
    );
  }

  @override
  void initState() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    profileController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    profileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<Auth>(context, listen: false).userId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          HeadBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                FutureBuilder(
                  future: Provider.of<Auth>(context, listen: false).getUserId(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.data == '')
                        return Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.4,
                          ),
                          child: Center(
                            child: Text(
                              '       Sign in to See and Edit you Profile.',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      else
                        return Column(
                          children: [
                            StreamBuilder(
                              stream: UserProvider.getUserDetails(snapshot.data),
                              builder: (context, AsyncSnapshot<List<User>> streamSnapshot) {
                                if (streamSnapshot.hasData)
                                  return Column(
                                    children: [
                                      Card(
                                        margin: const EdgeInsets.only(
                                          top: 30,
                                          bottom: 30,
                                          left: 20,
                                          right: 20,
                                        ),
                                        elevation: 10,
                                        shadowColor: Colors.black,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: hintText(text: 'User Name:', left: 10, fontsize: 18),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: edituserIdmode == 0
                                                        ? Container(
                                                            margin: EdgeInsets.only(
                                                              left: 20,
                                                            ),
                                                            child: Container(
                                                              margin: const EdgeInsets.only(right: 10),
                                                              child: AutoSizeText(
                                                                streamSnapshot.data[0].name,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : TextField(
                                                            controller: userNameController,
                                                          ),
                                                  ),
                                                  Expanded(
                                                    child: edituserIdmode == 0
                                                        ? IconButton(
                                                            icon: Icon(Icons.edit),
                                                            onPressed: () {
                                                              userNameController.text = streamSnapshot.data[0].name;
                                                              setState(() {
                                                                edituserIdmode = 1;
                                                              });
                                                            },
                                                          )
                                                        : IconButton(
                                                            icon: Icon(Icons.save),
                                                            onPressed: () async {
                                                              if (userNameController.text != '') {
                                                                setState(() {
                                                                  edituserIdmode = 0;
                                                                });
                                                                await UserProvider.editUserName(
                                                                    userNameController.text, snapshot.data);
                                                              } else
                                                                Fluttertoast.showToast(
                                                                    msg: 'UserName cannot be empty.');
                                                            },
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            divider(),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: hintText(text: 'Email:', left: 10, fontsize: 18),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: editEmailmode == 0
                                                        ? Container(
                                                            margin: EdgeInsets.only(
                                                              left: 20,
                                                            ),
                                                            child: Container(
                                                              margin: const EdgeInsets.only(right: 10),
                                                              child: AutoSizeText(
                                                                streamSnapshot.data[0].email,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : TextField(
                                                            controller: emailController,
                                                          ),
                                                  ),
                                                  Expanded(
                                                    child: editEmailmode == 0
                                                        ? IconButton(
                                                            icon: Icon(Icons.edit),
                                                            onPressed: () {
                                                              emailController.text = streamSnapshot.data[0].email;
                                                              setState(() {
                                                                editEmailmode = 1;
                                                              });
                                                            },
                                                          )
                                                        : IconButton(
                                                            icon: Icon(Icons.save),
                                                            onPressed: () async {
                                                              if (emailController.text != '') {
                                                                if (emailController.text.contains('@')) {
                                                                  setState(() {
                                                                    editEmailmode = 0;
                                                                  });
                                                                  await UserProvider.editEmail(
                                                                      emailController.text, snapshot.data);
                                                                } else
                                                                  Fluttertoast.showToast(msg: 'Invalid Email.');
                                                              } else
                                                                Fluttertoast.showToast(msg: 'Email cannot be empty.');
                                                            },
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            divider(),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: hintText(text: 'Profile:', left: 10, fontsize: 18),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: editProfilemode == 0
                                                        ? Image.network(
                                                            streamSnapshot.data[0].profileUrl,
                                                            height: 100,
                                                            width: 100,
                                                          )
                                                        : TextField(
                                                            controller: profileController,
                                                          ),
                                                  ),
                                                  Expanded(
                                                    child: editProfilemode == 0
                                                        ? IconButton(
                                                            icon: Icon(Icons.edit),
                                                            onPressed: () {
                                                              profileController.text =
                                                                  streamSnapshot.data[0].profileUrl;
                                                              setState(() {
                                                                editProfilemode = 1;
                                                              });
                                                            },
                                                          )
                                                        : IconButton(
                                                            icon: Icon(Icons.save),
                                                            onPressed: () async {
                                                              if (profileController.text != '') {
                                                                if (profileController.text.contains('https')) {
                                                                  setState(() {
                                                                    editProfilemode = 0;
                                                                  });
                                                                  await UserProvider.editProfilePhoto(
                                                                      profileController.text, snapshot.data);
                                                                } else
                                                                  Fluttertoast.showToast(msg: 'Invalid Url.');
                                                              } else
                                                                Fluttertoast.showToast(
                                                                    msg: 'This Field cannot be empty.');
                                                            },
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            divider(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                else
                                  return Center(child: CircularProgressIndicator());
                              },
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            Text(
                              'Tickets:',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            //this is where tickets and its status are shown
                            StreamBuilder(
                              stream: UserProvider.getuserTickets(snapshot.data),
                              builder: (ctx, AsyncSnapshot<List<Ticket>> ticketsSnapshot) {
                                print(ticketsSnapshot.hasData);
                                if (ticketsSnapshot.hasData) {
                                  if (ticketsSnapshot.data.isEmpty) {
                                    return Text('NO Tickets Available for this user.');
                                  } else {
                                    return Column(
                                        children: ticketsSnapshot.data.map((eachTicket) {
                                      return Card(
                                        elevation: 10,
                                        margin: EdgeInsets.all(20),
                                        shadowColor: Colors.black,
                                        child: Column(
                                          children: [
                                            ticketTile('SNO:', eachTicket.sno.toString()),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            divider(),
                                            ticketTile('Ticket Id:', eachTicket.ticId),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            divider(),
                                            ticketTile('Train Number:', eachTicket.trainno),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            divider(),
                                            ticketTile(
                                                'Ticket Status:',
                                                eachTicket.ticketStatus == 0
                                                    ? 'Cancelled'
                                                    : eachTicket.ticketStatus == 1
                                                        ? 'Booked'
                                                        : 'Waiting'),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            divider(),
                                            Container(
                                              margin: const EdgeInsets.only(top: 10),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: hintText(text: 'Passengers:', left: 10, fontsize: 18),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Container(
                                                      margin: const EdgeInsets.only(right: 100),
                                                      child: DataTable(
                                                        columns: [
                                                          DataColumn(
                                                            label: Text(
                                                              'Age',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Text(
                                                              'Gender',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Text(
                                                              'Seat Number',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Text(
                                                              'Seat Type',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Text(
                                                              'Status',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                        rows: eachTicket.passengers.map((eachPassenger) {
                                                          return DataRow(
                                                            cells: [
                                                              DataCell(
                                                                Text(
                                                                  '${eachPassenger['age']}',
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  '${eachPassenger['gender']}',
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  '${eachPassenger['name']}',
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  '${eachPassenger['seat_no']}',
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  '${eachPassenger['seat_type']}',
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  eachPassenger['status'] == 0
                                                                      ? 'Waiting'
                                                                      : 'Confirmed',
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            divider(),
                                            ticketTile('Total Price:', '${eachTicket.totalPrice}'),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            divider(),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList());
                                  }
                                } else
                                  return Center(child: CircularProgressIndicator());
                              },
                            ),
                          ],
                        );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
