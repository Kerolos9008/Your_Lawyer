import 'package:Your_Lawyer/Models/lawyer.dart';
import 'package:Your_Lawyer/Models/user.dart';

class Case {
  
  final String caseId;
  final String caseNumber;
  final String year;
  final String caseType;
  final String information;
  Lawyer assignedLawyer;
  final User owner;
  bool assigned;
  String state;

  Case({this.caseId,this.caseNumber,this.year, this.assignedLawyer, this.caseType, this.information, this.owner, this.assigned, this.state});
}