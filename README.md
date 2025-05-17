![erasebg-transformed](https://github.com/user-attachments/assets/144c6cbc-3d5f-48ae-9d50-19fdd25ae4b8)
# Xploit Learn - An AI Integrated Mobile Learning App for Vulnerability Analysis

This project is an AI-powered mobile learning platform designed to teach users about vulnerability analysis in the context of cybersecurity. It leverages Google Gemini for personalized, context-aware lesson generation and integrates hands-on labs for practical learning. The app focuses on real-time feedback, personalized learning paths, and comprehensive cybersecurity training, helping users enhance their understanding of vulnerabilities and how to protect against them.

---

## 🔑 Key Features

- **Personalized Learning Roadmap**  
  Tailored based on user preferences and skill level (Beginner, Intermediate, Expert).

- **Gemini-Powered AI Assistant**  
  Uses the Gemini API to generate personalized lesson content and provide real-time answers to users' vulnerability-related queries.

- **Interactive Lab Recommendations**  
  Recommends practical cybersecurity labs based on the user’s learning progress and selected topics.

- **Progress Tracker**  
  Tracks user progress in both lessons and labs, with a clear display of completed steps and next objectives.

- **User Preferences**  
  Dynamically adjusts learning content and recommendations based on the user's selected vulnerability topics and skill level.

- **Hands-on Learning**  
  Includes vulnerability analysis exercises and security testing scenarios for real-world application.

- **Android-Supported**  
  Built with Flutter for Android devices.

---

## 🛠️ Technologies Used

- **Flutter**: For Android app development  
- **Google Gemini API**: For generating dynamic lesson content based on user queries  
- **Hive**: For local storage of user preferences, progress, and lesson data  
- **FAISS**: For efficient similarity search (document retrieval)  
- **Sentence-Transformers**: For generating embeddings for documents and queries  
- **Firebase**: For user authentication, real-time updates, and cloud storage *(optional for future integration)*  
- **Python (Backend)**: Used for integrating Gemini API and handling retrieval-augmented generation (RAG) logic  
- **Web Scraper**: To fetch real-world, practical vulnerability labs for hands-on learning

---

## 📁 Folder Structure
ai_vulnerability_learning_app/ 

 ├── android/ # Android-specific code for Flutter 

 ├── lib/ 

 │ ├── app.dart # Main entry point of the app 

 │ ├── screens/ 

 │ │ ├── home_screen.dart # Home page with roadmap and progress 

 │ │ ├── lesson_screen.dart # Displays detailed lesson content 

 │ │ ├── lab_recommendation.dart # Lab recommendation page 

 │ │ └── assistant_screen.dart # AI assistant for user queries 

 │ ├── widgets/ 

 │ │ ├── lesson_card.dart # Card component for displaying lessons 

 │ │ ├── lab_card.dart # Card component for displaying labs 

 │ │ └── progress_tracker.dart # Widget for tracking user progress 

 │ ├── models/ 

 │ │ ├── lesson_model.dart # Data model for lessons 

 │ │ ├── lab_model.dart # Data model for labs 

 │ │ └── user_model.dart # Data model for user preferences and progress 

 │ ├── services/ 

 │ │ ├── gemini_service.dart # Handles communication with Gemini API 

 │ │ ├── lab_service.dart # Fetches and processes lab recommendations 

 │ │ └── preference_service.dart # Manages user preferences and skill levels 

 │ ├── utils/ 

 │ │ └── constants.dart # App-wide constants (e.g., colors, API URLs) 

 │ └── config.dart # App configuration (e.g., API keys, Firebase setup) 

 ├── assets/ # Image, icons, and other assets 

 │ ├── images/ 

 │ ├── icons/ 

 │ └── documents/ # Documents for lessons (e.g., markdown files, text) 

 ├── test/ # Unit tests and widget tests 

 │ └── gemini_service_test.dart # Test cases for Gemini service 

 └── pubspec.yaml # Flutter project dependencies 

