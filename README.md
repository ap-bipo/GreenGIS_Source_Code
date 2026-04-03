<div align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white" alt="Supabase" />
  <img src="https://img.shields.io/badge/TensorFlow%20Lite-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white" alt="TensorFlow Lite" />
  <img src="https://img.shields.io/badge/Google%20Gemini-8E75B2?style=for-the-badge&logo=google&logoColor=white" alt="Google Generative AI" />
</div>

<h1 align="center">🌱 GreenGIS</h1>

<p align="center">
  <b>A visionary mobile application gamifying environmental sustainability through AI and Machine Learning.</b>
</p>

## 📖 Overview

**GreenGIS** is a robust, cross-platform mobile application developed with Flutter. Its mission is to raise environmental awareness and foster sustainable habits by integrating gamification, artificial intelligence, and on-device computer vision. By combining educational content with interactive real-world challenges, GreenGIS aims to make going green both accessible and engaging.

---

##  Key Features

- **Secure Authentication**  
  Enterprise-level user management and secure login/registration workflows, powered by **Supabase**.
- **Smart AI Buddy** _(AIBuddyFeature)_  
  An intelligent conversational assistant leveraging **Google Generative AI (Gemini)**. It provides real-time, context-aware answers to user queries regarding sustainability and environmental science.
- **Vision-Powered Green Challenges** _(GreenChallengeFeature)_  
  Interactive eco-challenges (e.g., waste sorting, recycling classification) validated in real-time using on-device machine learning via **TensorFlow Lite**.
- **Learn & Play Modules** _(LearnAndPlayFeature)_  
  Interactive, gamified flashcards and robust educational resources engineered to teach sustainable habits in a vibrant and fun environment.

- **Dynamic User Personalization**  
  Customizable user profiles, secure session handling, and specialized UI states based on live user data configurations.

---

##  Tech Stack & Architecture

GreenGIS is built with modern, scalable, and high-performance technologies:

### **Presentation Layer (Frontend)**

- [Flutter](https://flutter.dev/) (SDK `>=3.10.7`)
- [Dart](https://dart.dev/)
- **UI Assets:** `flutter_svg`, custom markdown parsing via `flutter_markdown_plus`.

### **Backend & Database Auth**

- [Supabase](https://supabase.com/) (`supabase_flutter`) for PostgreSQL database mapping and seamless authentication.

### **AI & Machine Learning Layer**

- **LLM Engine:** [Google Generative AI API](https://ai.google.dev/) for intelligent chat.
- **Computer Vision:** [TensorFlow Lite](https://www.tensorflow.org/lite) (`tflite_flutter`) for blazing-fast, offline object detection.
- **Media Processing:** `image_picker` and `image` formatting components.

---

##  Project Architecture

The codebase adheres to clean-architecture concepts, separating UI rendering from business logic:

```text
lib/
├── main.dart                  # Application entry point & initialization (Supabase)
├── Pages/                     # View layer (UI Screens & Layouts)
│   ├── AIBuddyFeature/        # AI chatbot interfaces
│   ├── GreenChallengeFeature/ # Computer vision challenges UI
│   ├── LearnAndPlayFeature/   # Gamified education components
│   ├── IntroductionPages/     # Onboarding workflows
│   ├── HomePage.dart          # Main dashboard
│   └── LoginPage.dart         # Authentication views
└── Services/                  # Business logic, repositories & APIs
    ├── Authentication/        # Auth state management
    ├── ObjectDetection/       # TensorFlow inference engine logic
    ├── FlashcardServices/     # Education data provisioning
    └── Users/                 # Supabase querying and profile logic
```

---

##  Getting Started

Follow these instructions to set up the project locally for development and testing.

### Prerequisites

- **Flutter SDK** (`>= 3.10.7`)
- **Dart SDK**
- Android Studio / Xcode (for device emulation)

### Installation Guide

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-username/GreenGIS.git
   cd GreenGIS/green_gis
   ```

2. **Acquire Dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Environment Variables (Supabase)**
   Navigate into `lib/main.dart` and bind your Supabase project keys:

   ```dart
   await Supabase.initialize(
     url: 'YOUR_SUPABASE_URL',
     anonKey: 'YOUR_SUPABASE_ANON_KEY',
   );
   ```

4. **Integrate TFLite Models**
   Ensure your `.tflite` model and labels are placed inside the project's `assets/` directory and referenced correctly in your `pubspec.yaml`.

5. **Start the Application**
   ```bash
   flutter run
   ```

---

##  Contributing

Contributions, issues, and feature requests are always welcome! Feel free to check the issues page if you want to contribute.

## 📄 License

This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.
