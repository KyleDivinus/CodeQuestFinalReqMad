import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save player data to Firestore
  Future<void> savePlayerData(String playerId, Map<String, dynamic> data) async {
    try {
      await _db.collection('players').doc(playerId).set(data);
      print("Player data saved successfully.");
    } catch (e) {
      print("Error saving player data: $e");
    }
  }

  // Get player data from Firestore
  Future<Map<String, dynamic>?> getPlayerData(String playerId) async {
    try {
      DocumentSnapshot doc = await _db.collection('players').doc(playerId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      } else {
        print("No player data found for playerId: $playerId");
        return null;
      }
    } catch (e) {
      print("Error retrieving player data: $e");
      return null;
    }
  }

  // Update player data in Firestore
  Future<void> updatePlayerData(String playerId, Map<String, dynamic> data) async {
    try {
      await _db.collection('players').doc(playerId).update(data);
      print("Player data updated successfully.");
    } catch (e) {
      print("Error updating player data: $e");
    }
  }

  // Delete player data from Firestore
  Future<void> deletePlayerData(String playerId) async {
    try {
      await _db.collection('players').doc(playerId).delete();
      print("Player data deleted successfully.");
    } catch (e) {
      print("Error deleting player data: $e");
    }
  }
}