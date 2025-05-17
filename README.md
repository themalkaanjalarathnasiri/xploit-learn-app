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


## Setup & Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/your-username/ai-vulnerability-learning-app.git
    cd ai-vulnerability-learning-app
    ```

2. **Install dependencies**:

    First, ensure you have **Flutter** installed. Then, install the required packages:

    ```bash
    flutter pub get
    ```

3. **Set up Gemini API**:

    Create a `config.dart` file and insert your **Gemini API key**:

    ```dart
    // config.dart
    const String GEMINI_API_KEY = "your-gemini-api-key";
    ```

4. **Run the app**:

    You can now run the app on an **Android emulator** or a **physical Android device**:

    ```bash
    flutter run
    ```

    **Note**: Currently, this app supports **Android** only. If you need to run it on **iOS**, additional steps and modifications will be needed.

## How It Works

### **1. Roadmap Generation and User Preferences**

- The app generates a **personalized roadmap** based on the user's **selected topics** and **skill level**. The roadmap is dynamically tailored for each user.
- **User Preferences** (e.g., topics like XSS, SQLi) are stored locally in **Hive** and used to filter and recommend relevant lessons and labs.

### **2. Gemini API Integration for Lessons**

- The **Gemini Service** generates lessons based on the user’s **last completed roadmap step** and the **next step**.
- Each lesson is created by sending a prompt to the **Gemini API**:
- The generated lesson includes explanations, examples, and additional resources.

### **3. Lab Recommendations**

- The app fetches **vulnerability labs** based on the user’s preferences. These labs are sourced via a **web scraper** that pulls hands-on exercises from trusted platforms.
- The **Lab Recommendation Page** presents a list of available labs filtered by the user’s learning path and skill level.

### **4. AI Assistant**

- The **AI Assistant** uses the **Gemini API** to answer user questions about vulnerabilities. The assistant provides contextual, real-time answers based on the user’s roadmap and selected preferences.
- The assistant is powered by **RAG (Retrieval-Augmented Generation)**, ensuring the answers are both relevant and personalized.

### **5. Progress Tracking**

- The app tracks the user’s progress through lessons and labs. Each completed lesson or lab is marked and synced across the **Profile Page** and **Roadmap**.
- A **progress tracker** provides a visual overview of the user’s journey, showing the number of steps completed and what’s next.

## Example User Interaction

1. **Roadmap**:  
 - User opens the app and sees a personalized roadmap based on their skill level and selected topics.
 - The roadmap consists of a list of **lesson cards**, each representing a specific vulnerability topic.

2. **Lesson Generation**:  
 - The user taps on a lesson card, and the Gemini API generates a detailed lesson for that specific roadmap step.

3. **Lab Recommendations**:  
 - The user is recommended relevant **labs** for hands-on practice, filtered based on the roadmap topics and their skill level.

4. **AI Assistant**:  
 - The user asks the AI assistant about a specific vulnerability (e.g., "How do I prevent SQL Injection?").
 - The assistant generates a response based on the current roadmap step and provides additional resources.

## Contributing

We welcome contributions to improve the app. To get started:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Make your changes and test thoroughly.
4. Submit a pull request for review.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### **Future Enhancements**:
- Add video tutorials or embedded video lessons from platforms like YouTube.
- Implement interactive quizzes at the end of each lesson to test knowledge.
- Enhance AI capabilities to include code walkthroughs and hands-on lab simulations.

---

This **README.md** file now reflects **Android-only support** while providing clear instructions on how to set up and run the app. Let me know if you need further refinements!
