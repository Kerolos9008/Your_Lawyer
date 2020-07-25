import 'package:Your_Lawyer/Models/case_type.dart';
import 'package:Your_Lawyer/Models/user.dart';
import 'package:Your_Lawyer/Services/userData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'myCases.dart';

class AddCasePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddCasePageState();
  }
}

class AddCasePageState extends State<AddCasePage> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  List<DropdownMenuItem<dynamic>> _items = [];

  // text field state
  String caseId = '';
  String caseNumber = '';
  String year = '';
  String caseType = CaseType.getCaseTypes()[0].caseTypeName;
  String information = "";
  List<String> _caseTypes = [];

  @override
  initState() {
    super.initState();
    CaseType.getCaseTypes().forEach((element) {
      _items.add(
        new DropdownMenuItem(
          child: Text(element.caseTypeName),
          value: element.caseTypeName,
        ),
      );
    });
    print(caseType);
    print(_items.length);
  }

  @override
  Widget build(BuildContext context) {
    UserDataService _userDataService =
        new UserDataService(Provider.of<User>(context).uid);
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text("New case"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Case Number",
                    labelStyle: TextStyle(color: Colors.pink),
                    hintText: "123165",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    ),
                  ),
                  validator: (val) =>
                      (val.isEmpty || !RegExp(r"^[0-9]*$").hasMatch(val))
                          ? 'Enter a valid case number'
                          : null,
                  onChanged: (val) {
                    setState(() => caseNumber = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "For Year",
                    labelStyle: TextStyle(color: Colors.pink),
                    hintText: "2019",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    ),
                  ),
                  validator: (val) => (val.isEmpty ||
                          !RegExp(r"^[0-9]{4}$").hasMatch(val) ||
                          (int.parse(val) > 2020))
                      ? 'Enter a valid year'
                      : null,
                  onChanged: (val) {
                    setState(() => year = val);
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Type",
                    labelStyle: TextStyle(color: Colors.pink),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    ),
                  ),
                  value: caseType,
                  items: _items,
                  onChanged: (value) {
                    caseType = value;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Case Information",
                    labelStyle: TextStyle(color: Colors.pink),
                    hintText: "This case is about ....",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    ),
                  ),
                  validator: (val) => (val.isEmpty)
                      ? 'Enter some information about the case.'
                      : null,
                  onChanged: (val) {
                    setState(() => information = val);
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: loading
                      ? SpinKitChasingDots(
                          color: Colors.brown,
                          size: 14.0,
                        )
                      : Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () {
                    dynamic result = _userDataService.createCase(
                        caseNumber,
                        year,
                        caseType,
                        information,
                        Provider.of<User>(context));
                    if (result != null) {
                      setState(() {
                        error = 'again';
                      });
                      // setState(() {
                      //   caseNumber = '';
                      //   caseType = _caseTypes[0];
                      //   information = '';
                      //   year = '';
                      // });
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MyCasesPage()));
                    } else {
                      error = 'there has been an error please try again later.';
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
