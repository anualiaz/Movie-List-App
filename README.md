# Movie-List-App

A Flutter application for browsing and searching movies with a clean architecture and responsive UI.


## 🚀 Core Features
- **Movie API Integration**: Fetches movie data from a public or private movie API.
- **Search Functionality**: Search for movies by their name.
- **Movie List Display**: A list of movies displaying:
  - Title
  - Poster
  - Release Date
- **Movie Details Screen**: View additional information such as:
  - Overview
  - Rating

---

## 🛠️ Architecture
This project follows best practices for clean code and state management:
1. **BLoC (Business Logic Component)**: Ensures separation of UI and business logic for clean state management.
2. **Repository Pattern**: Provides an abstraction layer for API communication.
3. **Model Classes**: Parses and represents JSON data from the API.

---

## 🎨 User Interface
The app boasts a simple and user-friendly design:
1. **Search Bar**: Located at the top for quick access to search functionality.
2. **Movie List**: Displays movies in a `ListView` or `GridView` layout.
3. **Loading Indicators & Error Messages**: Improves the user experience with visual feedback.
4. **Pagination (Optional)**: Handles large datasets efficiently.

---

## 🚀 Getting Started

Follow these steps to set up and run the project:

### Prerequisites
- Install [Flutter](https://flutter.dev/docs/get-started/install).
- Set up an emulator or connect a physical device.

### Steps
```bash
# Clone the repository
git clone https://github.com/anualiaz/Movie-List-App.git

# Navigate to the project directory
cd Movie-List-App

# Install Flutter dependencies
flutter pub get

# Run the app on an emulator or connected device
flutter run

```
Author: Anu Alias
