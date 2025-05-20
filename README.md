# Example Chat App

A feature-rich chat application demonstrating Clean Architecture principles and BLoC pattern in Flutter.

![Chat App Banner](assets/images/banner.png)

## 📱 Features

- **Group Chat System**: Modern interface for group messaging
- **Real-time Messaging**: Beautiful message bubbles with timestamp indicators
- **Clean UI Design**: Carefully crafted user interface with custom styling
- **Date Separators**: Messages grouped by day with easy-to-navigate separators
- **User Avatars**: Profile images and customized sender information
- **Responsive Layout**: Works across various device sizes and orientations

## 🏗️ Architecture

This project follows Clean Architecture principles, separating the app into distinct layers:

- **Presentation Layer**: BLoC pattern for state management, screens, and widgets
- **Domain Layer**: Business logic, entities, and use cases
- **Data Layer**: Data sources and repositories

### Project Structure

```
lib/
├── core/
│   ├── di/               # Dependency injection setup
│   └── theme/            # App-wide theming
├── features/
│   └── chat/
│       ├── data/         # Repositories implementation, data sources
│       ├── domain/       # Entities, repositories interfaces, use cases
│       └── presentation/ # Screens, widgets, and BLoC
└── main.dart             # Entry point
```

## 🛠️ Technology Stack

- **Flutter**: UI framework
- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **google_fonts**: Typography (chose a similar typeface to the original design)
- **equatable**: Value equality
- **intl**: Internationalization and date formatting

## 📸 Preview





## 👨‍💻 Design Decisions

### BLoC Pattern

The app uses the BLoC (Business Logic Component) pattern for state management, which:
- Separates business logic from UI
- Makes code more testable
- Manages complex state transitions efficiently

### Mock Data

Currently using mock data to simulate backend responses. This allows for development without a backend dependency.

### Custom UI Components

- Custom chat bubbles with different styles for sent/received messages
- Decorative background with custom painter
- Stylized input field with animations