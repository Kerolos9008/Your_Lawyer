import 'package:Your_Lawyer/Models/case.dart';
import 'package:flutter/material.dart';

class CaseCard extends StatelessWidget {
  final Case _case;
  Color stateColor;
  CaseCard(this._case);

  @override
  Widget build(BuildContext context) {
    if (this._case.state.compareTo("in Progress") == 0) {
      stateColor = Colors.black38;
    } else if (this._case.state.compareTo("Won") == 0) {
      stateColor = Colors.green;
    } else {
      stateColor = Colors.red;
    }

    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  this._case.caseNumber,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(" for "),
                Text(
                  this._case.year,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 5, left: 20),
              child: Text(
                "Case of" + this._case.caseType,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                ),
              ),
            ),
            this._case.assigned
                ? Text("Assigned to: " +
                    this._case.assignedLawyer.firstName +
                    " " +
                    this._case.assignedLawyer.lastName)
                : Text(
                    "Not Assigned yet",
                    style: TextStyle(color: Colors.black38),
                  ),
            SizedBox(
              height: 5,
            ),
            Text(
              this._case.information,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(fontSize: 12),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 10),
              child: Text(
                this._case.state,
                style: TextStyle(fontSize: 12, color: stateColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
