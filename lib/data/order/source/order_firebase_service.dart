import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/order/model/order_registration_req_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OrderFirebaseService {

  Future<Either> orderRegistration(OrderRegistrationReqModel order);
  Future<Either> getOrders();
}

class OrderFirebaseServiceImpl extends OrderFirebaseService {

  @override
  Future<Either> orderRegistration(OrderRegistrationReqModel order) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Orders')
          .add(
            order.toMap(),
          );

      for (var item in order.products) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Cart')
            .doc(item.id)
            .delete();
      }

      return const Right('Order registered successfully');
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either> getOrders() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .collection('Orders')
          .get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again');
    }
  }
}
