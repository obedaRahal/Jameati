# 🎓 Jameati – Project Management App (Flutter)

Cross-platform **project management** app built with **Flutter** for mobile, powered by a **Laravel + MySQL** backend, with real-time features and notifications.  
This repo contains the **mobile app**. Backend and UI/UX links below.

## 🔗 Links
- **Backend (Laravel + MySQL):** https://github.com/mohamadmansour18/Jamieati-Application.git
- **UI/UX (Behance):** https://www.behance.net/gallery/234729251/Jamieati-App-Service-UIUX-design

---

## ✨ Features (Mobile)
- 🔐 Authentication (email / phone) *(adapt to your auth flow if different)*
- 🔔 **Firebase Cloud Messaging** for push notifications
- 💬 **Pusher** for real-time chat & updates
- 🧠 **GetX** for state management, routing, and DI
- 🧱 Clean Code & reusable components (modules, services, data layers)
- 🌓 Light/Dark theme, RTL/LTR ready (Arabic/English)
- 📁 Project & groups: create, invite, manage members, roles
- 📈 Home statistics, top projects, notifications center
- 🔎 Search (users, groups, projects)

> *This app was developed as a university capstone/team project. See Credits below.*

---

## 🧰 Tech Stack
- **Flutter (Dart)** — Mobile app
- **GetX** — State management, navigation, DI
- **Firebase** — FCM notifications
- **Pusher** — Real-time messaging
- **Laravel + MySQL** — Backend API (separate repo)

---


---

## 🚀 Getting Started

### Prerequisites
- Flutter (stable) — https://docs.flutter.dev/get-started/install
- Android Studio / VS Code
- Backend running locally or hosted (update API base URL in `link_api.dart`)

### Installation
```bash
git clone https://github.com/obedaRahal/Jameati.git
cd Jameati
flutter pub get
flutter run


🔧 Configuration & Environment

Create and configure your environment securely:

Do not commit these files (add to .gitignore):

android/app/google-services.json

ios/Runner/GoogleService-Info.plist

lib/firebase_options.dart

Set your API base URL in:

lib/link_api.dart (or wherever you centralize endpoints)

If keys were previously pushed publicly, regenerate API keys from Firebase/Pusher and update the app.
