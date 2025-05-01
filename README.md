# Chrono Loco: Fast Clock

Chrono Loco is a cross-platform mobile app for model railroaders that simulates a fast clock and keeps it synchronized across multiple devices in real time. Perfect for multi-operator layouts or solo sessions where accurate, accelerated timekeeping is essential.

## 🚂 Features

- Simulates accelerated "fast time" for train operations
- Syncs across multiple devices instantly using Firebase
- One device acts as the host, others follow the clock in real time
- Adjustable time rate (e.g. 4x faster than real time)
- Built with Flutter for both Android and iOS support

## 🛠️ How It Works

1. A user starts a session as the **host**, which sets the clock and speed.
2. The app writes the current time and speed to Firebase Realtime Database.
3. Other users connect as **clients** and their clocks auto-sync with the host.
4. Any changes made by the host (pause, resume, speed) update instantly on all clients.

## 💡 Why I Built This

Model railroaders often use fast clocks to simulate time passing more quickly during operations. Coordinating multiple clocks manually (or using legacy hardware) is error-prone and limiting. Chrono Loco makes synchronized fast time easy, portable, and hardware-free.

## 🧰 Tech Stack

- **Flutter**: Cross-platform mobile development
- **Dart**: Main programming language
- **Firebase Realtime Database**: Syncing time and settings across devices
- **Google Cloud**: Infrastructure for hosting and authentication

## 📈 Future Improvements

- User login and invite system
- Custom clock faces and display options
- Session logs and operation reports
- Offline fallback with delayed syncing

## 📷 Screenshots


