# Weather App

## Description
This Flutter project is a weather app that allows users to fetch weather data by inputting a city name. It features a user-friendly interface and supports both portrait and landscape modes.

## Features
- **Responsive Design**: The app adjusts its layout and UI components to fit both portrait and landscape orientations.
- **State Management**: Utilizes the `provider` package for efficient state management across the app.
- **Weather Data**: Fetches real-time weather information from the WeatherAPI based on user-input city names.
- **UI Components**: Uses Google Fonts for typography and Cupertino Icons for consistent and appealing visual elements.

## Dependencies
- **cupertino_icons: ^1.0.6**
  - Provides iOS-style icons for consistent app iconography and visual elements across iOS and Android platforms.

- **provider: ^6.1.2**
  - Enables efficient state management, allowing the app to manage and update state changes across widgets seamlessly.

- **connectivity_plus: ^3.0.3**
  - Monitors network connectivity changes in real-time, ensuring the app responds appropriately to network availability.

- **google_fonts: ^6.2.1**
  - Integrates custom Google Fonts into the app for enhanced typography and aesthetic appeal in text elements.

- **http: ^1.2.1**
  - Enables HTTP requests to external APIs, such as WeatherAPI, to fetch weather data based on user-input city names.

- **fluttertoast: ^8.2.6**
  - Displays informative and user-friendly toast messages, providing feedback and notifications to the user during app interactions.

## Usage
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Ensure API keys are configured (if required).
4. Run the app using `flutter run`.


