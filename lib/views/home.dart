import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/contact_controller.dart';
import '../models/contact_model.dart';
import '../routes/app_routes.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ctrl = Get.find<ContactController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      floatingActionButton:FloatingActionButton(onPressed: () =>  Get.toNamed(AppRoutes.addContact),
        child: const Icon(Icons.person_add , color: Colors.grey),
      ),
      body: Column(
        children: [
          Padding(
              padding:const EdgeInsets.all(16),
              child: TextField(
                onChanged: ctrl.onSearchChanged,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
          ),
          Expanded(child: Obx(() {
            if(ctrl.isLoading.value){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(ctrl.filteredContacts.isEmpty){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.contacts_outlined,
                        size: 80, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      ctrl.searchText.value.isNotEmpty
                          ? 'No contacts found'
                          : 'No contacts available',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (ctrl.searchText.value.isEmpty)
                      const Text(
                        '+ button se contact add karo',
                        style: TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
              );
            }
            return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: ctrl.filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = ctrl.filteredContacts[index];
                  return _ContactCard(contact: contact, controller: ctrl);
                },
            );
           },)
          )
        ],
      ),
    );
  }
}
class _ContactCard extends StatelessWidget {
  final ContactModel contact;
  final ContactController controller;
  const _ContactCard({super.key, required this.contact, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            contact.name[0].toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.phone),
            if (contact.email.isNotEmpty)
              Text(
                contact.email,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.editContact, arguments: contact),
              icon: const Icon(Icons.edit, color: Colors.blue),
            ),
            IconButton(
              onPressed: () => _confirmDelete(context),
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ]
        )
      ),
    );
  }
  void _confirmDelete(BuildContext context)
  {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete this "${contact.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteContact(contact.id);
              Get.back();
            } ,
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

}

