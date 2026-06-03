import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';
import '../models/contact_model.dart';

class EditContact extends StatefulWidget {
  EditContact({super.key});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final ContactModel contact = Get.arguments as ContactModel;
  final ContactController ctrl = Get.find<ContactController>();
  late final nameCtrl = TextEditingController(text: contact.name);
  late final phoneCtrl = TextEditingController(text: contact.phone);
  late final emailCtrl = TextEditingController(text: contact.email);
  late final addressCtrl = TextEditingController(text: contact.address);

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: const Text('Edit Contact')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            CircleAvatar(
              radius: 40,
              child: Text(
                contact.name[0].toUpperCase(),
                style: const TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: nameCtrl,
              onChanged: (_) => ctrl.clearError(),
              decoration: const InputDecoration(
                labelText: 'Name *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              onChanged: (_) => ctrl.clearError(),
              decoration: const InputDecoration(
                labelText: 'Phone *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email (optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: addressCtrl,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Address (optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
            const SizedBox(height: 8),

            Obx(() => ctrl.errorMessage.value.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                ctrl.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            )
                : const SizedBox.shrink()),

            const SizedBox(height: 8),

            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ctrl.isLoading.value
                    ? null
                    : () => ctrl.updateContact(
                  contact.id,
                  nameCtrl.text,
                  phoneCtrl.text,
                  email: emailCtrl.text,
                  address: addressCtrl.text,
                ),
                child: ctrl.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Update Contact'),
              ),
            )),
          ],
        ),
      ),
    );
  }
}