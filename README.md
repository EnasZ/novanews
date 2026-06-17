# NovaNews Application 📰

**NovaNews** is a modern, high-performance news application built with Flutter using **Clean Architecture** principles. It features real-time data fetching, offline caching, smooth fluid animations, and strict adherence to decoupled UI components.

---

## 🚀 Features

* **Executive Splash Screen:** Seamless entry with dynamic scaling and a custom linear progress loader.
* **Clean Architecture:** Enforces separation of concerns across Data, Domain, and Presentation layers.
* **State Management:** Powered by `flutter_bloc` (Cubit) Version 9+ for predictable dynamic states.
* **Backend Integration:** Real-time data storage, collection, and retrieval via **Supabase**.
* **Local Caching (Hive):** Fast local storage for seamless offline readability and caching.
* **Modular Styles:** Unified typography and color palettes maintained globally via `AppStyles` and `AppColors`.

---

## 📁 Architecture & Directory Layout

The project adheres to the feature-first variant of Clean Architecture. 

```text
lib/
├── core/
│   ├── constants/       # API keys, global strings
│   ├── database/        # Hive initialization and managers
│   └── theme/           # AppColors, AppStyles, AppImages
└── feature/
    └── article/
        ├── data/
        │   ├── data_sources/ # Remote (Supabase) & Local (Hive) sources
        │   ├── model/        # Article serialization models
        │   └── repository/   # Repository implementations
        └── presentation/
            ├── cubit/        # ArticleCubit & ArticleState
            ├── screens/      # HomeScreen, ArticleDetailsScreen, Splash
            └── widgets/      # Atomic, decoupled UI components



# Get all pub dependencies
flutter pub get

# Run build runner if you generate type adapters for Hive (Optional)
flutter pub run build_runner build --delete-conflicting-outputs

# Execute the application on your connected device
flutter run