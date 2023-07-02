import 'package:cloud_firestore/cloud_firestore.dart';

class Dept {
  final String id;
  final String status;
  final String type;
  final num amount;
  final DateTime date;
  final DateTime backDate;
  final String to;

  Dept({
    required this.id,
    required this.status,
    required this.type,
    required this.amount,
    required this.date,
    required this.backDate,
    required this.to,
  });

  factory Dept.fromDocumentSnapshot(DocumentSnapshot snapshot, String id) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Dept(
      id: id,
      status:"paid",
      type: data['type'],
      amount: data['amount'],
      date: (data['date'] as Timestamp).toDate(),
      backDate: (data['backDate'] as Timestamp).toDate(),
      to: data['to'],
    );
  }
}
