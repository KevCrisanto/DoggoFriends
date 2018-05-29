import 'dart:async';
import 'dart:convert';
import 'package:doggo_friends/models/dog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DogApi {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  FirebaseUser firebaseUser;

  DogApi(FirebaseUser user) {
    this.firebaseUser = user;
  }

  static Future<DogApi> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return new DogApi(user);
  }

  static List<Dog> allDogsFromJson(String jsonData) {
    List<Dog> dogs = [];
    json.decode(jsonData)['dogs'].forEach((dog) => dogs.add(_forMap(dog)));
    return dogs;
  }

  Future<List<Dog>> getAllDogs() async {
    return (await Firestore.instance.collection('dogs').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  StreamSubscription watch(Dog dog, void onChange(Dog dog)) {
    return Firestore.instance
        .collection('dogs')
        .document(dog.documentId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Dog _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;
    return new Dog(
      documentId: snapshot.documentID,
      externalId: data['id'],
      name: data['name'],
      description: data['description'],
      avatarUrl: data['image_url'],
      location: data['location'],
      likeCounter: data['like_counter'],
      isAdopted: data['adopted'],
      pictures: new List<String>.from(data['pictures']),
      attributes: new List<String>.from(data['attributes']),
    );
  }

  static Dog _forMap(Map<String, dynamic> map) {
    return new Dog(
      externalId: map['id'],
      name: map['name'],
      description: map['description'],
      avatarUrl: map['image_url'],
      location: map['location'],
      likeCounter: map['like_counter'],
      isAdopted: map['adopted'],
      pictures: new List<String>.from(map['pictures']),
      attributes: new List<String>.from(map['attributes']),
    );
  }
}
