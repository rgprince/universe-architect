# Universe Architect 🌌

A professional-grade creative writing application for Linux and Android, designed to help authors build complex fictional universes with an integrated knowledge base, rich-text editor, and AI-powered co-authoring assistant.

[![Flutter Version](https://img.shields.io/badge/Flutter-3.24.5-02569B?logo=flutter)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Android-brightgreen)](https://github.com/rgprince/universe-architect)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

![Universe Architect Banner](https://via.placeholder.com/1200x400/1a1a2e/16213e?text=Universe+Architect+%7C+Professional+Creative+Writing)

---

## ✨ Features

### 📝 Rich Text Editor
- **Powered by flutter_quill**: Professional WYSIWYG editing experience
- **HTML Export**: Convert your writing to clean, formatted HTML
- **View Toggle**: Switch between editor and HTML preview modes
- **Responsive Design**: Optimized for both desktop and mobile

### 🗂️ World-Building Database
- **Universes**: Organize multiple story worlds
- **Books & Chapters**: Structure your novels with proper hierarchy
- **Entities System**:
  - Characters with custom attributes
  - Locations with geographical data
  - Items and artifacts
  - Events and timelines
- **Relationship Graph**: Map connections between entities
- **Scenes Management**: Link narrative scenes to your books

### 🤖 AI Co-Author (Phase 4 - In Development)
- **Context-Aware Suggestions**: RAG (Retrieval Augmented Generation) pipeline
- **Entity Recognition**: Automatically fetch relevant world-building data
- **Gemini Integration**: Powered by Google's Generative AI

### 🎨 Adaptive UI
- **Desktop Mode**: Three-pane layout (Navigation | Editor | Inspector)
- **Mobile Mode**: Drawer navigation + Bottom sheet inspector
- **900px Breakpoint**: Seamless transition between layouts
- **Dark Mode Ready**: Modern, clean interface

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.24.5 or higher ([Installation Guide](https://docs.flutter.dev/get-started/install))
- **For Linux**: GTK+ 3.0 development libraries
- **For Android**: Android SDK 35 (automatically managed by Flutter)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/rgprince/universe-architect.git
   cd universe-architect
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate database code** (drift ORM)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run on your platform**
   
   For Linux:
   ```bash
   flutter run -d linux
   ```
   
   For Android:
   ```bash
   flutter run -d android
   ```

### Building Release Versions

**Linux Desktop**:
```bash
flutter build linux --release
# Binary will be in: build/linux/x64/release/bundle/
```

**Android APK**:
```bash
flutter build apk --release
# APK will be in: build/app/outputs/flutter-apk/app-release.apk
```

---

## 📁 Project Structure

```
universe_architect/
├── lib/
│   ├── data/                    # Data layer (drift database)
│   │   ├── database.dart        # Main database class
│   │   ├── providers/           # Riverpod providers
│   │   └── tables/              # Table definitions (9 tables)
│   │       ├── universes.dart
│   │       ├── books.dart
│   │       ├── chapters.dart
│   │       ├── scenes.dart
│   │       ├── entities.dart
│   │       └── relationships.dart
│   ├── ui/                      # UI layer
│   │   ├── layouts/             # Responsive layouts
│   │   │   ├── desktop_layout.dart
│   │   │   └── mobile_layout.dart
│   │   ├── responsive_scaffold.dart
│   │   ├── editor/              # Rich text editor
│   │   ├── books/               # Book management screens
│   │   ├── entities/            # Entity screens (characters, locations)
│   │   └── chat/                # AI chat interface
│   ├── services/                # Business logic
│   │   ├── ai_text_service.dart
│   │   ├── clipboard_service.dart
│   │   ├── export_service.dart
│   │   └── backup_service.dart
│   └── main.dart                # App entry point
├── android/                     # Android platform config
├── linux/                       # Linux platform config
├── test/                        # Widget & unit tests
└── pubspec.yaml                 # Dependencies
```

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|-----------|
| **Framework** | Flutter 3.24.5 |
| **Database** | drift (SQLite ORM) with compile-time safety |
| **State Management** | flutter_riverpod + code generation |
| **Rich Text** | flutter_quill 9.6.0 |
| **AI Integration** | google_generative_ai (Gemini API) |
| **Clipboard** | super_clipboard + super_native_extensions |
| **Navigation** | go_router with ShellRoute |
| **Graph Visualization** | graphview (for relationship mapping) |

---

## 📊 Development Roadmap

### ✅ Phase 1: The "Constellation" Data Layer (Completed)
- [x] drift database configuration
- [x] 9 interconnected tables with foreign keys
- [x] Entity type system (Character, Location, Item, Event)
- [x] Relationship graph structure
- [x] JSON attribute storage for flexible templates

### ✅ Phase 2: The "Mission Control" UI (Completed)
- [x] Responsive scaffold implementation
- [x] Desktop 3-pane layout
- [x] Mobile drawer + bottom sheet
- [x] flutter_quill integration
- [x] HTML export functionality
- [x] Widget tests (100% passing)

### 🚧 Phase 3: The Interoperability Engine (In Progress)
- [ ] ClipboardService with HTML + plain text
- [ ] Linux Wayland clipboard error handling
- [ ] Advanced export formats (DOCX, PDF)
- [ ] Email integration

### 📅 Phase 4: The Intelligence Module (Planned)
- [ ] RAG pipeline implementation
- [ ] Entity extraction from prompts
- [ ] Context injection for Gemini API
- [ ] Chat history persistence
- [ ] Conversation management UI

---

## 🧪 Testing

Run all tests:
```bash
flutter test
```

Run with coverage:
```bash
flutter test --coverage
```

Current test coverage:
- Widget tests for responsive layouts ✅
- Editor screen functionality tests ✅
- Database query tests ✅

---

## 🐛 Known Issues

1. **flutter_quill API Compatibility**: Version 9.6.0 requires specific constructor usage
   - Solution: Use `QuillEditor.basic(controller: ...)` without `configurations` parameter
   - Use `QuillToolbar.simple(...)` instead of `QuillToolbar.basic(...)`

2. **Android Build**: Requires compileSdk 35
   - Already configured in `android/app/build.gradle`

3. **Linux Clipboard**: May require additional permissions on Wayland
   - Error handling implemented in Phase 3

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines
- Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide
- Write tests for new features
- Update documentation as needed
- Run `flutter analyze` before committing

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Flutter Team** for the amazing cross-platform framework
- **drift** for compile-time safe SQLite ORM
- **flutter_quill** for rich text editing capabilities
- **Google Gemini** for AI integration

---

## 📧 Contact

**Developer**: rgprince  
**Repository**: [https://github.com/rgprince/universe-architect](https://github.com/rgprince/universe-architect)  
**Issues**: [Report a bug or request a feature](https://github.com/rgprince/universe-architect/issues)

---

<p align="center">Made with ❤️ for creative writers everywhere</p>
