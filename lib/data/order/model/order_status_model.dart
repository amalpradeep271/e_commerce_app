import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/domain/order/entity/order_status_entity.dart';

class OrderStatusModel {
  final String title;
  final bool done;
  final Timestamp createdDate;

  OrderStatusModel(
      {required this.title, required this.done, required this.createdDate});

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
        title: map['title'] as String,
        done: map['done'] as bool,
        createdDate: map['createdDate'] as Timestamp);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'done': done,
      'createdDate': createdDate,
    };
  }
}

extension OrderStatusXModel on OrderStatusModel {
  OrderStatusEntity toEntity() {
    return OrderStatusEntity(
      createdDate: createdDate,
      done: done,
      title: title,
    );
  }
}

extension OrderStatusXEntity on OrderStatusEntity {
  OrderStatusModel fromEntity() {
    return OrderStatusModel(
      title: title,
      done: done,
      createdDate: createdDate,
    );
  }
}
