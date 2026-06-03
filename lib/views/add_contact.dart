import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';

class AddContact extends StatefulWidget {
  AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final nameCtrl = TextEditingController();

  final phoneCtrl = TextEditingController();

  final emailCtrl = TextEditingController();

  final addressCtrl = TextEditingController();

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
    final ContactController ctrl = Get.find<ContactController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Contact')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                nameCtrl.text.isNotEmpty
                    ? nameCtrl.text[0].toUpperCase()
                    : '?',
                style: const TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: nameCtrl,
              onChanged: (_) => ctrl.clearError(),
              decoration: const InputDecoration(
                labelText: 'Name *',
                hintText: 'Enter Complete Name',
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
                hintText: '03XX-XXXXXXX',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: 16),

            // Email — optional
            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email (optional)',
                hintText: 'example@gmail.com',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),

            // Address — optional
            TextField(
              controller: addressCtrl,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Address (optional)',
                hintText: 'Enter Complete Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
            const SizedBox(height: 8),

            // Error message
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
                    : () => ctrl.addContact(
                  nameCtrl.text,
                  phoneCtrl.text,
                  email: emailCtrl.text,
                  address: addressCtrl.text,
                ),
                child: ctrl.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save Contact'),
              ),
            )),
          ],
        ),
      ),
    );
  }
}