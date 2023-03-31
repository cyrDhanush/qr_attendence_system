import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

// collection references

CollectionReference userref = firestore.collection('users');
CollectionReference classref = firestore.collection('classes');

String demostudentid = '8ckoVyigc1aFCtEyuR0qV0PzbrF2';
String democlassid = 'zShjgLIyDOi3cz7J7228';
// String democlassid = 'YKoQyDEF3XJxnwwqEROT';
