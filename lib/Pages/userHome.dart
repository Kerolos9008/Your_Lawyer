import 'package:Your_Lawyer/Models/lawyer.dart';
import 'package:Your_Lawyer/Models/user.dart';
import 'package:Your_Lawyer/Pages/SideDrawer/addCase.dart';
import 'package:Your_Lawyer/Pages/SideDrawer/myCases.dart';
import 'package:Your_Lawyer/Pages/SideDrawer/profile.dart';
import 'package:Your_Lawyer/Services/userData.dart';
import 'package:Your_Lawyer/Widgets/lawyerCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserHomePageState();
  }
}

class UserHomePageState extends State<UserHomePage> {
  List<Lawyer> _lawyersList = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // UserDataService _userDataService =
    //     UserDataService(Provider.of<User>(context).uid);
    // this._lawyersList = _userDataService.getLawyers();
    return Scaffold(
      backgroundColor: Colors.brown[100],
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(
                Icons.add_circle_outline,
              ),
              title: Text('New case'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCasePage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.work,
              ),
              title: Text('My cases'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCasesPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
              ),
              title: Text('Feedbacks'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserHomePage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.supervised_user_circle,
              ),
              title: Text('Lawyers requests'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserHomePage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
              ),
              title: Text('My Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
              ),
              title: Text('Log out'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserHomePage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Text("Lawyerito"),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('lawyer').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SpinKitChasingDots(
              color: Colors.brown[400],
            );
          } else {
            _lawyersList = [];
            snapshot.data.documents.forEach((doc) {
              Lawyer lawyer = new Lawyer(
                email: doc['email'],
                firstName: doc['firstName'],
                lastName: doc['lastName'],
                image: doc['image'],
                officeAddress: doc['officeAddress'],
                phoneNumber: doc['phoneNumber'],
                since: doc['since'],
                nationalId: doc['nationalId'],
              );
              print("lawyer:" + lawyer.toString());
              _lawyersList.add(lawyer);
            });
            print("length = " + _lawyersList.length.toString());
            return Container(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) =>
                    LawyerCard(_lawyersList[index]),
                itemCount: _lawyersList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                  height: 7,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
