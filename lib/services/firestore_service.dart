import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/model/character.dart';

class FirestoreService {
  static final ref =
      FirebaseFirestore.instance.collection('Characters').withConverter(
            fromFirestore: Character.fromFirestore,
            toFirestore: (Character c, _) => c.toFirestore(),
          );

  // add a new character
  static Future<void> addCharacter(Character character) async {
    await ref.doc(character.id).set(character);
  }

  // get characters once

  // update a character

  // delete a character
}
