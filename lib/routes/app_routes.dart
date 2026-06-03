import 'package:contact_book_app/views/add_contact.dart';
import 'package:contact_book_app/views/home.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../views/edit_contact.dart';

class AppRoutes {
  static const home = '/home';
  static const addContact = '/add-contact';
  static const editContact = '/edit-contact';

  static final pages = [
    GetPage(name: home, page: () => Home()),
    GetPage(name: addContact, page: () => AddContact()),
    GetPage(name: editContact, page: () => EditContact()),
  ];
}