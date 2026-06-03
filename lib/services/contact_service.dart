import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/contact_model.dart';

class ContactService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _contacts = _db.collection('contacts');

  static Future<void> addContact(ContactModel contact) async {
    await _contacts.add(contact.toMap());
  }

  static Stream<List<ContactModel>> getContacts() {
    return _contacts
        .orderBy('name')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ContactModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ),
              )
              .toList(),
        );
  }

  static Future<void> updateContact(ContactModel contact) async {
    await _contacts.doc(contact.id).update(contact.toMap());
  }

  static Future<void> deleteContact(String id) async {
    await _contacts.doc(id).delete();
  }
}
