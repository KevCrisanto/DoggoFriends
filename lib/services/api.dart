import 'dart:convert';
import 'package:doggo_friends/models/dog.dart';

class DogApi {
  static List<Dog> allDogsFromJson(String jsonData) {
    List<Dog> dogs = [];
    json.decode(jsonData)['dogs'].forEach((dog) => dogs.add(_forMap(dog)));
    return dogs;
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
