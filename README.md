# Weather

Weather is a simple weather application built with Flutter. It automatically detects your current location and provides real-time weather updates with engaging Lottie animations to reflect the current conditions.

## Features
- 📍 **Automatic Location Detection**: Uses your device's GPS to find your current city.
- 🌤️ **Real-time Weather**: Fetches up-to-date weather data including temperature and conditions.
- 🎨 **Dynamic Animations**: Displays different animations for Sunny, Rainy, Cloudy, and Snowy conditions.
- 🌓 **Dark/Light Mode Support**: Adapts to your device's system theme.

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
- An IDE (VS Code or Android Studio) with Flutter extensions.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/rafi-ghanbari/weather.git
    cd Weather
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

## 🔑 API Key Configuration (Important)

This application uses the **OpenWeatherMap API** to fetch weather data. You need to obtain your own free API key to make it work.

### How to get an API Key:
1.  Go to [OpenWeatherMap](https://openweathermap.org/) and sign up for a free account.
2.  Once logged in, navigate to the **API keys** tab (under your profile name).
3.  Create a new key (e.g., name it "Weather App") and copy the generated string.

### How to use the API Key:
1.  Open the project in your code editor.
2.  Navigate to `lib/screens/weather_screen.dart`.
3.  Locate the line inside `_WeatherScreenState`:
    ```dart
    final _weatherServices = WeatherServices('YOUR_API_KEY_HERE');
    ```
4.  Replace the placeholder (or the existing test key) with your actual API key.

> **Security Note**: Never commit your active API keys to public repositories. 

## Usage

1.  **Run the app:**
    ```bash
    flutter run
    ```
2.  **Grant Permissions**: When the app launches, allow it to access your location when prompted.
3.  **View Weather**: The app will display your current city, temperature, and condition.

## Project Structure
- `lib/models/`: Contains the `Weather` data model.
- `lib/services/`: Handles API calls to OpenWeatherMap and Location services.
- `lib/screens/`: Contains the UI code for the application.

## Third-Party Packages
- `http`: For making API requests.
- `geolocator`: For accessing device location.
- `geocoding`: For converting coordinates to city names.
- `lottie`: For showing animated weather assets.
