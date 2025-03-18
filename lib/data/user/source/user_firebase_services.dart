import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class UserFirebaseService {
  Future<Either> getUser();
  Future<Either<String, String>> uploadProfileImage(File imageFile);
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
  
  @override
  Future<Either<String, String>> uploadProfileImage(File imageFile) async{
       try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String fileName = 'users/$userId/profile.jpg';

      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'image': imageUrl,
      });
      return Right(imageUrl);
    } catch (e) {
      return const Left('Error uploading image');
    }
  }
}
