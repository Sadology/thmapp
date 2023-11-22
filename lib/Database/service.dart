import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? Avatar;
  String? Bio;
  String? userName;
  bool? isAdmin;
  String? Roll;
  String? Merit;
  UserData(
      {this.Avatar,
      this.Bio,
      this.userName,
      this.isAdmin,
      this.Roll,
      this.Merit});
  factory UserData.fromMap(Map<String, dynamic>? data) {
    data = data ?? {};
    return UserData(
        userName: data['userName'] ?? '',
        Avatar: data['Avatar'] ?? '',
        Bio: data['Bio'] ?? '',
        isAdmin: data['isAdmin'] ?? false,
        Roll: data['Roll'] ?? '',
        Merit: data['Merit'] ?? '');
  }

  data() {}
}

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<UserData> userDataStream(email) {
    return db.collection('Registry').doc(email).snapshots().map((snap) {
      if (snap.exists) {
        return UserData.fromMap(snap.data());
      } else {
        return UserData();
      }
    });
  }
}
