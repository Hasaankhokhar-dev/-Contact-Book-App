import 'package:contact_book_app/services/contact_service.dart';
import 'package:get/get.dart';

import '../models/contact_model.dart';

class ContactController extends GetxController {
  var allContacts = <ContactModel>[].obs;
  var filteredContacts = <ContactModel>[].obs;
  var searchText = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToContacts();
    debounce(searchText, (callback) => _filterContacts(),
        time: const Duration(milliseconds: 300)
    );
  }

  void _listenToContacts() {
    ContactService.getContacts().listen(
      (contacts) {
        allContacts.value = contacts;
        _filterContacts();
      },
      onError: (error) {
        errorMessage.value = 'Failed to fetch contacts: $error';
      },
    );
  }

  void _filterContacts() {
    if (searchText.value.isEmpty) {
      filteredContacts.value = allContacts;
      return;
    }
    filteredContacts.value = allContacts.where((contact) {
      return contact.name.toLowerCase().contains(
        searchText.value.toLowerCase(),
      );
    }).toList();
  }

  void onSearchChanged(String value) {
    searchText.value = value;
  }

  Future<void> addContact(
    String name,
    String phone, {
    String email = '',
    String address = '',
  }) async {
    if (name.trim().isEmpty) {
      errorMessage.value = 'Name is required';
      return;
    }
    if (phone.trim().isEmpty) {
      errorMessage.value = 'Phone is required';
      return;
    }
    if (phone.trim().length < 11) {
      errorMessage.value = 'Phone number must be at least 11 characters';
      return;
    }
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final contact = ContactModel(
        id: '',
        name: name.trim(),
        phone: phone.trim(),
        email: email.trim(),
        address: address.trim(),
        createdAt: DateTime.now(),
      );
      await ContactService.addContact(contact);
      Get.back();
    } catch (e) {
      errorMessage.value = 'Failed to add contact : $e';
    } finally {
      isLoading.value = false;
    }
  }

  // updateContact
  Future<void> updateContact(
    String id,
    String name,
    String phone, {
    String email = '',
    String address = '',
  }) async {
    // Validation
    if (name.trim().isEmpty) {
      errorMessage.value = 'Name is required';
      return;
    }
    if (phone.trim().isEmpty) {
      errorMessage.value = 'Phone is required';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final updatedContact = ContactModel(
        id: id,
        name: name.trim(),
        phone: phone.trim(),
        email: email.trim(),
        address: address.trim(),
        createdAt: DateTime.now(),
      );

      await ContactService.updateContact(updatedContact);
      Get.back();
    } catch (e) {
      errorMessage.value = 'Failed to update contact: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // deleteContact
  Future<void> deleteContact(String id) async {
    try {
      await ContactService.deleteContact(id);
    } catch (e) {
      errorMessage.value = 'Failed to delete contact: $e';
    }
  }

  //clearErrorMessage
  void clearError() {
    errorMessage.value = '';
  }
}
