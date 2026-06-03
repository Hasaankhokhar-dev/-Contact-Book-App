# 📒 Contact Book App

A Flutter contact management app built with Firebase Firestore and GetX state management. Add, edit, delete and search contacts with real-time cloud sync.

---

## ✨ Features

- ➕ Add, edit and delete contacts
- 🔍 Real-time search by name
- 📋 Contacts sorted A-Z automatically
- ☁️ Cloud sync with Firebase Firestore
- ⚡ Real-time updates with Firestore streams
- 📱 Clean and simple UI

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | UI Framework |
| GetX | State Management + Navigation |
| Firebase Firestore | Cloud Database |
| Firebase Core | Firebase Setup |

---

## 📁 Project Structure

```
lib/
├── main.dart
├── routes/
│   └── app_routes.dart
├── features/
│   └── contacts/
│       ├── models/
│       │   └── contact_model.dart
│       ├── services/
│       │   └── contact_service.dart
│       ├── controllers/
│       │   └── contact_controller.dart
│       ├── views/
│       │   ├── contacts_view.dart
│       │   ├── add_contact_view.dart
│       │   └── edit_contact_view.dart
│      
│     
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6
  firebase_core: ^3.6.0
  cloud_firestore: ^5.4.4
```

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Hasaankhokhar-dev/-Contact-Book-App.git
cd contact-book
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Firebase setup

- Go to Firebase Console — [console.firebase.google.com](https://console.firebase.google.com)
- Create a new project
- Add Android/iOS app
- Download `google-services.json`
- Place it inside `android/app/` folder
- Configure using FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

### 4. Firestore setup

In Firebase Console:
```
Firestore Database → Create Database → Start in test mode
```

### 5. Run the app

```bash
flutter run
```

---

## 🗄️ Firestore Structure

```
contacts/                    ← collection
  {contactId}/               ← document (auto ID)
    name: "Ali Ahmed"
    phone: "03001234567"
    email: "ali@gmail.com"   ← optional
    address: "Lahore"        ← optional
    createdAt: Timestamp
```

---

## 🏗️ Architecture

This app follows **MVVM architecture** with GetX:

```
View  →  Controller  →  Service  →  Firebase
         (logic)        (calls)
```

- **Model** — data structure (ContactModel)
- **Service** — Firebase calls only
- **Controller** — business logic, validation, state management
- **View** — UI only, observes controller

---

## ⚙️ Key Concepts Used

**Real-time Stream:**
```dart
// Firestore changes automatically reflect in UI
ContactService.getContacts().listen((contacts) {
  allContacts.value = contacts;
});
```

**Search with Debounce:**
```dart
// Waits 300ms before filtering — avoids filtering on every keystroke
debounce(searchText, (_) => _filterContacts(),
    time: Duration(milliseconds: 300));
```

**A-Z Sorting:**
```dart
// Fetch data sorted from Firestore
_contacts.orderBy('name').snapshots()
```

---

## 🔒 Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /contacts/{contactId} {
      // Test mode — open access
      allow read, write: if true;

      // Production — authenticated users only
      // allow read, write: if request.auth != null;
    }
  }
}
```

---

## 👨‍💻 Author

**Muhammad Hasaan Altaf**
- Flutter Developer
 
---

## 📄 License

This project is open source — feel free to use and modify.
