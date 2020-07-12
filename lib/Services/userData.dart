import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/user.dart';

class UserDataService{
  final String uid;
  UserDataService(this.uid);

  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference lawyerCollection = Firestore.instance.collection('lawyer');
  final CollectionReference caseCollection = Firestore.instance.collection('case');
  final CollectionReference requestCollection = Firestore.instance.collection('caseRequest');

  Future<void> updateUserData(String firstName, String lastName, String phoneNumber) async {
    return await userCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    });
  }
  

}