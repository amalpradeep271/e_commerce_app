import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserFirebaseService {
  Future<Either> getUser();
}

class UserFirebaseServiceImpl extends UserFirebaseService {
  @override
  Future<Either> getUser() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;

      var userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser?.uid)
          .get()
          .then((value) => value.data());

      return Right(userData);
    } catch (e) {
      return const Left('An error Occured.');
    }
  }
}
