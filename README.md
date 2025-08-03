# UK Nature Reserve Data Logging App

A Flutter mobile application for logging wildlife sightings in UK nature reserves, now featuring local data storage with plans for decentralized synchronization.

## Recent Updates (v2.0)

This app has been modernized and moved away from Firebase to local data storage:

### ✅ What's New
- **Local Database**: All data now stored locally using SQLite
- **Offline-First**: App works completely offline
- **Modern Flutter**: Updated to Flutter 3.x with latest dependencies
- **Local Authentication**: Simple credential storage replacing Firebase Auth
- **Future-Ready Sync**: Architecture prepared for decentralized synchronization

### 🚀 Features

- **User Authentication**: Local account creation and login
- **Wildlife Logging**: Record butterfly sightings with species, count, location, and timestamp
- **Location Services**: GPS-based location capture
- **Google Maps Integration**: View sightings on interactive maps
- **Species Database**: Comprehensive UK butterfly species list
- **Data Export**: Export your data for backup or sharing
- **Offline Operation**: Full functionality without internet connection

### 📱 Technical Stack

- **Framework**: Flutter 3.x
- **Database**: SQLite (via sqflite package)
- **Authentication**: Local credential storage with SHA-256 hashing
- **Location**: Geolocator package for GPS functionality
- **Maps**: Google Maps Flutter integration
- **Storage**: SharedPreferences for app settings

### 🔄 Future Synchronization Options

See [SYNC_OPTIONS.md](SYNC_OPTIONS.md) for detailed information about planned decentralized synchronization features, including:

- Peer-to-peer device communication
- Distributed database solutions
- Manual data export/import
- Self-hosted sync servers
- Multi-cloud backup options

## Getting Started

### Prerequisites
- Flutter 3.0 or higher
- Android Studio / VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/rdash99/Uk-Nature-Reserve-Data-Logging-App.git
cd Uk-Nature-Reserve-Data-Logging-App/app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Set up Google Maps API key:
   - Get an API key from Google Cloud Console
   - Add it to `android/app/src/main/AndroidManifest.xml`
   - Add it to `ios/Runner/AppDelegate.swift`

4. Run the app:
```bash
flutter run
```

### Usage

1. **Create Account**: Register with email and password
2. **Login**: Use your credentials to access the app
3. **Log Sightings**: Navigate to "Add Sighting" to record wildlife observations
4. **View Data**: Your sightings are stored locally and accessible offline
5. **Export Data**: Use the export feature to backup or share your data

## Data Structure

### Local Database Schema

#### Users Table
- `id`: Unique user identifier
- `email`: User email address
- `password_hash`: SHA-256 hashed password
- `first_name`: User's first name
- `surname`: User's surname
- `created_at`: Account creation timestamp

#### Butterfly Sightings Table
- `id`: Auto-increment primary key
- `user_id`: Reference to user
- `species`: Butterfly species name
- `number_seen`: Count of butterflies observed
- `date`: Date of sighting (DD-MM-YYYY)
- `time`: Time of sighting (HH-MM-SS)
- `latitude`: GPS latitude
- `longitude`: GPS longitude
- `created_at`: Record creation timestamp

## Migration from Firebase

This version removes all Firebase dependencies and replaces them with local alternatives:

- **Firebase Auth** → Local authentication with encrypted password storage
- **Cloud Firestore** → SQLite local database
- **Firebase Analytics** → Removed (can be re-added with local analytics)
- **Firebase Storage** → Local file storage via path_provider

All existing functionality is preserved while gaining:
- Complete offline operation
- No external service dependencies
- User data privacy and control
- Faster app performance
- No ongoing costs

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Roadmap

- [ ] Data export/import functionality
- [ ] Peer-to-peer sync capabilities
- [ ] Enhanced species identification features
- [ ] Bird sighting support (currently butterfly-focused)
- [ ] Data visualization and statistics
- [ ] Multi-language support

## Support

For issues, questions, or contributions, please open an issue on GitHub or contact the maintainers.
 
