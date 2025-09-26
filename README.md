# 🍔 Food Delivery App

A modern, responsive food delivery application built with Flutter. This app allows users to browse restaurants, view menus, add items to cart, and place food orders for delivery.

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

## ✨ Features

- 🏠 **Home Screen** - Browse featured restaurants and popular items
- 🍽️ **Menu** - View restaurant menus with categories
- 🛒 **Cart** - Add/remove items and adjust quantities
- 💳 **Checkout** - Secure payment processing
- 👤 **User Profile** - View order history and manage account
- 🌐 **Responsive Design** - Works on both mobile and tablet

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / VS Code with Flutter extensions
- Android Emulator or iOS Simulator (or a physical device)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/taran-bansal/food_delivery_app.git
   cd food_delivery_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: Bloc Pattern
- **Dependency Injection**: Provider
- **Local Storage**: Shared Preferences
- **UI Components**: Custom widgets with Material Design 3
- **Testing**: Unit and Widget tests with Mockito

## 📱 Screenshots

| Home Screen | Menu | Cart | Checkout | Order Confirmation | Profile |
|-------------|------|------|----------|----------------------|---------|
| ![Home](https://raw.githubusercontent.com/taran-bansal/food_delivery_app/refs/heads/main/assets/screenshots/home.png) | ![Menu](https://raw.githubusercontent.com/taran-bansal/food_delivery_app/refs/heads/main/assets/screenshots/menu.png) | ![Cart](https://raw.githubusercontent.com/taran-bansal/food_delivery_app/refs/heads/main/assets/screenshots/cart.png) | ![Checkout](https://raw.githubusercontent.com/taran-bansal/food_delivery_app/refs/heads/main/assets/screenshots/checkout.png) | ![Order Confirmation](https://raw.githubusercontent.com/taran-bansal/food_delivery_app/refs/heads/main/assets/screenshots/orderConfirmation.png) | ![Profile](https://raw.githubusercontent.com/taran-bansal/food_delivery_app/refs/heads/main/assets/screenshots/profile.png) |

## 🧪 Testing

Run tests using the following command:

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/checkout/presentation/screens/checkout_screen_test.dart
```

## 📂 Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   └── widgets/
├── features/
│   ├── cart/
│   │   ├── domain/
│   │   └── presentation/
│   ├── checkout/
│   │   └── presentation/
│   ├── dashboard/
│   │   └── presentation/
│   ├── home/
│   │   └── presentation/
│   └── profile/
│       └── presentation/
└── main.dart
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

[Taran Bansal](https://github.com/taran-bansal)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All contributors who helped improve this project
- The open-source community for their invaluable resources
