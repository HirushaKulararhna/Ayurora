# Ayurora
Mobile application 
# 🌿 Ayurora - Ayurvedic Plant Information App

<div align="center">

![Ayurora Logo](assets/images/logo.png)

**Discover the healing power of Ayurvedic plants**

[![Flutter](https://img.shields.io/badge/Flutter-3.35.5-blue.svg)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-orange.svg)](https://firebase.google.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

[Features](#features) • [Screenshots](#screenshots) • [Installation](#installation) • [Architecture](#architecture) • [Contributing](#contributing)

</div>

---

## 📖 About

**Ayurora** is a comprehensive mobile application dedicated to Ayurvedic plants and their medicinal properties. Built with Flutter and powered by Firebase, Ayurora provides users with detailed information about traditional Indian medicinal plants, their uses, care instructions, and health benefits.

### 🎯 Purpose

- **Educate** users about Ayurvedic plants and their healing properties
- **Preserve** ancient knowledge of traditional medicine
- **Guide** users on how to grow and care for medicinal plants
- **Connect** people with natural healing alternatives

---

## ✨ Features

### 🌱 For Users

#### Plant Discovery
- **Browse Plants**: Explore comprehensive database of Ayurvedic plants
- **Detailed Information**: Sanskrit names, scientific names, medicinal properties
- **Image Gallery**: Multiple high-quality images for each plant with swipe navigation
- **Search Functionality**: Real-time search by name, category, or benefits
- **Favorite System**: Save your favorite plants for quick access

#### Plant Details
- **Growth Information**: Difficulty level, growth time, climate requirements
- **Care Instructions**: Detailed watering, lighting, soil, and harvesting guides
- **Health Benefits**: Complete list of medicinal properties and uses
- **Interesting Facts**: Historical and scientific facts about each plant
- **Growth Statistics**: Light, water, temperature, and growth rate indicators

#### User Experience
- **Firebase Authentication**: Secure email/password and Google Sign-In
- **User Profiles**: Personal profile with account information
- **Favorites Management**: Track and manage your plant collection
- **Offline Support**: Access previously viewed plants without internet
- **Responsive Design**: Optimized for all mobile screen sizes (320px - 430px)

### 👨‍💼 For Administrators

#### Admin Dashboard
- **Plant Management**: Add, edit, and delete plants from database
- **Image Upload**: Multi-image upload to Firebase Storage
- **Real-time Updates**: Changes sync instantly to all users
- **Statistics**: View total plants and recent additions
- **Role Management**: Admin access control system

#### Content Management
- **Rich Editor**: Add comprehensive plant information
- **Multi-Image Support**: Upload main thumbnail and gallery images
- **Category Management**: Organize plants by medicinal properties
- **Data Validation**: Ensure quality and completeness of information

---

## 📱 Screenshots

<div align="center">

### Authentication Flow
| Splash Screen | Welcome Screen | Login Screen |
|:---:|:---:|:---:|
| ![Splash](screenshots/splash.png) | ![Welcome](screenshots/welcome.png) | ![Login](screenshots/login.png) |

### Main Features
| Home Screen | Plant Details | Search Results |
|:---:|:---:|:---:|
| ![Home](screenshots/home.png) | ![Details](screenshots/details.png) | ![Search](screenshots/search.png) |

### User Features
| Profile | Favorites | Admin Dashboard |
|:---:|:---:|:---:|
| ![Profile](screenshots/profile.png) | ![Favorites](screenshots/favorites.png) | ![Admin](screenshots/admin.png) |

</div>

---

## 🏗️ Architecture

### Tech Stack

**Frontend:**
- Flutter 3.35.5
- Dart 3.9.2
- Material Design

**Backend:**
- Firebase Authentication (Email/Password, Google Sign-In)
- Cloud Firestore (Real-time database)
- Firebase Storage (Image hosting)

**State Management:**
- setState (Local state)
- StreamBuilder (Real-time updates)

**Key Packages:**
```yaml
firebase_core: ^2.24.2
firebase_auth: ^4.16.0
cloud_firestore: ^4.14.0
firebase_storage: ^11.6.0
google_sign_in: ^6.2.1
flutter_svg: ^1.1.6
image_picker: ^1.0.7
cached_network_image: ^3.3.1
uuid: ^4.3.3
```

### Project Structure

```
ayurora/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── constants.dart               # App-wide constants
│   │
│   ├── models/
│   │   ├── plant.dart              # Plant data model
│   │   └── user_model.dart         # User data model
│   │
│   ├── services/
│   │   ├── firebase_auth_service.dart    # Authentication logic
│   │   ├── plant_service.dart            # Plant CRUD operations
│   │   └── admin_service.dart            # Admin management
│   │
│   ├── components/
│   │   ├── custom_text_field.dart        # Reusable input field
│   │   ├── google_sign_in_button.dart    # Google auth button
│   │   └── my_bottom_navbar.dart         # Navigation bar
│   │
│   └── screens/
│       ├── splash/
│       │   └── splash_screen.dart        # App loading screen
│       │
│       ├── auth/
│       │   ├── welcome_screen.dart       # Landing page
│       │   ├── login_screen.dart         # User login
│       │   └── signup_screen.dart        # User registration
│       │
│       ├── home/
│       │   ├── home_screen.dart          # Main screen
│       │   └── components/               # Home components
│       │
│       ├── details/
│       │   └── details_screen.dart       # Plant details
│       │
│       ├── profile/
│       │   └── profile_screen.dart       # User profile
│       │
│       └── admin/
│           ├── admin_dashboard_screen.dart   # Admin panel
│           ├── add_plant_screen.dart         # Add new plant
│           └── manage_plants_screen.dart     # Edit/delete plants
│
├── assets/
│   ├── images/                    # Plant images
│   └── icons/                     # SVG icons
│
└── test/                          # Unit tests
```

### Firebase Structure

**Firestore Collections:**
```
├── users
│   └── {userId}
│       ├── name, email, photoUrl
│       └── createdAt, lastLogin
│
├── plants
│   └── {plantId}
│       ├── Basic Info (name, scientific name, Sanskrit name)
│       ├── Images (imageUrl, galleryImages[])
│       ├── Growth Data (difficulty, time, climate)
│       ├── Care Instructions[]
│       ├── Benefits[]
│       └── Interesting Facts[]
│
└── admins
    └── {email}
        └── addedAt, addedBy
```

**Storage Structure:**
```
/plants
  /{plantId}
    /main.jpg              # Thumbnail image
    /gallery/
      /1.jpg              # Gallery images
      /2.jpg
      /3.jpg
```

---

## 🚀 Installation

### Prerequisites

- Flutter SDK (3.35.5 or higher)
- Dart SDK (3.9.2 or higher)
- Android Studio / VS Code
- Firebase account
- Android/iOS device or emulator

### Setup Steps

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/ayurora.git
cd ayurora
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Firebase Configuration**

   a. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   
   b. Add Android app:
   ```bash
   # Download google-services.json
   # Place in: android/app/google-services.json
   ```
   
   c. Add iOS app (optional):
   ```bash
   # Download GoogleService-Info.plist
   # Place in: ios/Runner/GoogleService-Info.plist
   ```
   
   d. Enable Authentication:
   - Email/Password
   - Google Sign-In
   
   e. Create Firestore Database
   
   f. Enable Firebase Storage

4. **Configure Firestore Security Rules**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function isAdmin() {
      return exists(/databases/$(database)/documents/admins/$(request.auth.token.email));
    }
    
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    
    match /admins/{email} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }
    
    match /plants/{plantId} {
      allow read: if true;
      allow create, update, delete: if isAdmin();
    }
  }
}
```

5. **Configure Storage Security Rules**
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /plants/{plantId}/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

6. **Add Admin User**
   - Go to Firestore Database
   - Create collection: `admins`
   - Add document: `your-email@gmail.com`

7. **Run the app**
```bash
flutter run
```

### Android Build

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS Build

```bash
flutter build ios --release
# Use Xcode to archive and distribute
```

---

## 🎨 Design System

### Color Palette

```dart
Primary Color:   #0C9869 (Emerald Green)
Text Color:      #3C4046 (Dark Gray)
Background:      #F9F8FD (Light Gray)
Success:         #4CAF50
Error:           #F44336
Warning:         #FF9800
```

### Typography

- **Headings**: Roboto Bold (24-36px)
- **Body**: Roboto Regular (14-16px)
- **Captions**: Roboto Medium (12px)

### Design Principles

- **Natural**: Earth tones reflecting Ayurvedic heritage
- **Clean**: Minimalist interface for easy navigation
- **Accessible**: High contrast, readable fonts
- **Responsive**: Adapts to all mobile screen sizes

---

## 🔐 Security

### Authentication
- Firebase Authentication with email verification
- Secure password hashing (handled by Firebase)
- Google OAuth 2.0 integration
- Session management with secure tokens

### Data Protection
- Firestore security rules enforce access control
- Admin-only write access to plant database
- User data isolated by authentication
- Image uploads restricted to authenticated users

### Best Practices
- No sensitive data stored locally
- HTTPS-only communication
- Regular security audits
- Compliance with data protection regulations

---

## 📊 Features Roadmap

### Version 1.0.0 (Current) ✅
- [x] User authentication
- [x] Plant database with search
- [x] Detailed plant information
- [x] Image gallery with swipe
- [x] Favorites system
- [x] Admin dashboard
- [x] Firebase integration

### Version 1.1.0 (Planned)
- [ ] Push notifications for plant care reminders
- [ ] Offline mode with local database sync
- [ ] Multiple language support (Hindi, Tamil, etc.)
- [ ] AR plant identification using camera
- [ ] Community forum for plant discussions
- [ ] Export plant care guide as PDF

### Version 2.0.0 (Future)
- [ ] Marketplace for buying plants/seeds
- [ ] Expert consultation booking
- [ ] Plant disease diagnosis with AI
- [ ] Growing journal and progress tracking
- [ ] Social features (share, like, comment)
- [ ] Gamification (badges, achievements)

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Contribution Guidelines

- Follow Flutter/Dart style guide
- Write clear commit messages
- Add tests for new features
- Update documentation
- Ensure code passes all tests

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 Ayurora

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 👥 Team

**Project Lead & Developer**
- [Your Name](https://github.com/yourusername)

**Contributors**
- See [CONTRIBUTORS.md](CONTRIBUTORS.md)

---

## 📞 Contact & Support

- **Email**: support@ayurora.com
- **Website**: [www.ayurora.com](https://www.ayurora.com)
- **Issues**: [GitHub Issues](https://github.com/yourusername/ayurora/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/ayurora/discussions)

---

## 🙏 Acknowledgments

- **Ayurvedic Experts** for plant information and verification
- **Flutter Community** for amazing packages and support
- **Firebase** for robust backend infrastructure
- **Contributors** who help improve Ayurora
- **Users** for feedback and bug reports

---

## 📈 Statistics

![GitHub stars](https://img.shields.io/github/stars/yourusername/ayurora?style=social)
![GitHub forks](https://img.shields.io/github/forks/yourusername/ayurora?style=social)
![GitHub issues](https://img.shields.io/github/issues/yourusername/ayurora)
![GitHub pull requests](https://img.shields.io/github/issues-pr/yourusername/ayurora)

---

<div align="center">

**Made with ❤️ and 🌿 by the Ayurora Team**

*Bringing ancient wisdom to modern technology*

[⬆ Back to Top](#-ayurora---ayurvedic-plant-information-app)

</div>
