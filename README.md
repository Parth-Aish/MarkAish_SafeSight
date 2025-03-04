# SafeSight_MarkAish: Women Safety Analytics Prototype

SafeSight is an innovative Flutter-based prototype designed to enhance women’s safety by proactively analyzing public CCTV feeds, integrating wearable biometrics, and leveraging advanced AI analytics to predict and prevent potential threats.

## Overview

SafeSight combines multiple cutting-edge technologies to create a multi-layered safety solution. It:
- **Analyzes public CCTV feeds** in real time using AI to detect suspicious behavior and alert authorities preemptively.
- **Designates virtual safe zones** by partnering with local businesses (cafés, stores, etc.) where users can seek immediate help.
- **Predicts high-risk situations** by processing historical data, weather, event schedules, and transit patterns.
- **Integrates wearable technology** that monitors subtle physiological stress indicators and auto-triggers alerts without manual input.
- **Employs sound analytics** to detect distress signals (e.g., screams, breaking glass) even in noisy environments.
- **Utilizes Telegram API integration** for secure OTP and alert messaging (via configured Bot Token and ChatID).
- **Shares real-time location data** to guide users towards safe routes and nearby safe zones.

> **Note:** The hardware components (advanced CCTV and audio models) are part of an ongoing patent process and further negotiations. This prototype represents a conceptual model and proof-of-concept.

## Features

- **AI-Driven CCTV Analysis:** Automatically scans live video feeds for unusual behavior patterns.
- **Virtual Safe Zones:** Displays safe points on the map where users can get immediate assistance.
- **Predictive Threat Mapping:** Uses machine learning to generate real-time safety heatmaps based on diverse data sources.
- **Wearable Integration:** A jewelry-like wearable monitors stress levels (using sensors like galvanic skin response) and triggers alerts.
- **Ambient Sound Analytics:** Continuously analyzes environmental audio to detect distress cues while preserving privacy.
- **Telegram Integration:** Sends OTPs and emergency alerts using a Telegram Bot (configure with Bot Token and ChatID).
- **Location-Based Alerts:** Provides users with real-time directions to safe areas and recommended safer routes.
- **Community & Urban Design Impact:** Supports community watch initiatives and works with urban planners for dynamic safety solutions.

## Tech Stack

- **Frontend & Mobile App:** Flutter & Dart
- **AI & Machine Learning:** Python libraries (ANN, LSTM, CNN, RNN, SVM)
- **APIs & Integrations:**
  - Google Maps API (location tracking & safe zone visualization)
  - Telegram API (secure OTP and alert messaging)
- **Wearable Sensors:** Biometric data acquisition for stress detection
- **Data Analytics:** Real-time data aggregation for predictive threat scoring

## Prototype Disclaimer

This project is a prototype designed to showcase potential AI-driven safety solutions. Advanced hardware integrations and the detailed CCTV/audio analysis modules are under patent review and further development with industry partners.

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Git](https://git-scm.com/downloads)
- An IDE such as [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)

### Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Parth-Aish/SafeSight_MarkAish.git
   ```
2. **Navigate to the Project Directory:**
   ```bash
   cd SafeSight_MarkAish
   ```
3. **Install Flutter Dependencies:**
   ```bash
   flutter pub get
   ```
4. **Configure Environment Variables:**
   - Create a `.env` file (or use your preferred configuration method) to store sensitive data such as:(Do It In Home Screen And OTP Sending Screen)
     ```
     TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
     TELEGRAM_CHAT_ID=your_telegram_chat_id_here
     ```
5. **Run the Application:**
   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have ideas for improvements or new features.

## License

This project is open-source under the [MIT License](LICENSE).

## Contact

For further inquiries or to discuss collaboration opportunities, please contact:

- **MarkAish Team, Chandigarh University**
- **Lead Developer:** Parth (23BAI70549)
- **UI/UX Designer:** M.Devasis Singh (23BAI70549)
