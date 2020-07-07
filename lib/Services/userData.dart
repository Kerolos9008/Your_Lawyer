import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService{
  final String uid;
  UserDataService(this.uid);

  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference lawyerCollection = Firestore.instance.collection('lawyer');
  final CollectionReference caseCollection = Firestore.instance.collection('case');
  final CollectionReference requestCollection = Firestore.instance.collection('caseRequest');

  
  

}