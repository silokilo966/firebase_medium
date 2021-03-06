import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todoapp/models/post_model.dart';
import 'package:firebase_todoapp/models/user_model.dart';

class DatabaseService {
  String? uid;
  DatabaseService({this.uid});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Posts from snapshot
  Stream<List<Posts>> get userPosts {
    return _firestore
        .collection("posts")
        .snapshots()
        .map(_userPostsFromSnapshot);
  }

  //PostList from snapshot
  List<Posts> _userPostsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Posts(
        title: doc.get('title') ?? '',
        description: doc.get('description') ?? '',
        photo: doc.get('imageurl') ?? '',
      );
    }).toList();
  }

  Future updatePosts(String title, String description, String photo) async {
    return await _firestore.collection("posts").add({
      "title": title,
      "description": description,
      "imageurl": photo,
    });
  }

  Future updateUserData(String username, String email) async {
    return await _firestore.collection("users").doc(uid).set({
      "username": username,
      "email": email,
    });
  }

  //userData from snapshot

  Stream<List<UserModel>> get userData {
    return _firestore
        .collection("users")
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  //user list from snapshot
  List<UserModel> _userDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
        username: doc.get('username') ?? '',
        email: doc.get('email') ?? '',
      );
    }).toList();
  }
}
