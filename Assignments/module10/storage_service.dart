import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Uploads an image file to Firebase Storage and saves metadata to Firestore.
  /// Returns the download URL of the uploaded image.
  Future<String> uploadImage(File imageFile, {String? caption}) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final imageId = const Uuid().v4();
    final ext = imageFile.path.split('.').last;
    final ref = _storage.ref().child('gallery/${user.uid}/$imageId.$ext');

    // Upload image
    final uploadTask = ref.putFile(
      imageFile,
      SettableMetadata(contentType: 'image/$ext'),
    );

    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();

    // Save metadata to Firestore
    await _firestore.collection('gallery').doc(imageId).set({
      'imageId': imageId,
      'userId': user.uid,
      'userName': user.displayName ?? user.email ?? 'Unknown',
      'imageUrl': downloadUrl,
      'caption': caption ?? '',
      'storagePath': 'gallery/${user.uid}/$imageId.$ext',
      'uploadedAt': FieldValue.serverTimestamp(),
    });

    return downloadUrl;
  }

  /// Returns a stream of gallery images for the current user, ordered by upload time.
  Stream<QuerySnapshot> getMyGalleryStream() {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    return _firestore
        .collection('gallery')
        .where('userId', isEqualTo: user.uid)
        .orderBy('uploadedAt', descending: true)
        .snapshots();
  }

  /// Returns a stream of ALL gallery images across users, ordered by upload time.
  Stream<QuerySnapshot> getAllGalleryStream() {
    return _firestore
        .collection('gallery')
        .orderBy('uploadedAt', descending: true)
        .snapshots();
  }

  /// Deletes an image from Firebase Storage and its metadata from Firestore.
  Future<void> deleteImage(String imageId, String storagePath) async {
    await _storage.ref().child(storagePath).delete();
    await _firestore.collection('gallery').doc(imageId).delete();
  }
}
