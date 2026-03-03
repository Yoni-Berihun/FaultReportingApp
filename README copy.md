# Fault Reporting Flutter App
**Hawassa University IoT Campus — Anonymous Fault Reporting System**

## Screens
| Screen | Route | Description |
|--------|-------|-------------|
| Home | `/` | Form: phone, description, photo, GPS/manual location |
| Map Preview | `/map-preview` | OpenStreetMap with pin + report summary |
| Confirmation | `/confirmation` | Success animation + tracking ID |

## Project Structure
```
lib/
├── main.dart              # App entry + GoRouter config
├── models/
│   └── fault_report.dart  # FaultReport data model
└── screens/
    ├── home_screen.dart         # Report form
    ├── map_preview_screen.dart  # Map + confirm
    └── confirmation_screen.dart # Success page
```

## Setup

### 1. Prerequisites
```bash
flutter --version   # Requires Flutter 3.10+
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Android permissions
Copy the contents of `android/app/src/main/AndroidManifest.xml` into your project,
or manually add these permissions to your existing manifest:
- `ACCESS_FINE_LOCATION`
- `ACCESS_COARSE_LOCATION`
- `CAMERA`
- `READ_EXTERNAL_STORAGE` / `WRITE_EXTERNAL_STORAGE`
- `INTERNET`

Also add the FileProvider entry for `image_picker`.

### 4. iOS permissions
Add the keys from `ios/Runner/Info.plist` into your project's Info.plist:
- `NSLocationWhenInUseUsageDescription`
- `NSCameraUsageDescription`
- `NSPhotoLibraryUsageDescription`

### 5. Android minimum SDK
In `android/app/build.gradle`, set:
```gradle
android {
    defaultConfig {
        minSdkVersion 21   // required by geolocator
        targetSdkVersion 34
    }
}
```

### 6. Run
```bash
flutter run
```

## Dependencies
| Package | Purpose |
|---------|---------|
| `go_router` | Screen navigation |
| `geolocator` | GPS location |
| `image_picker` | Camera + gallery |
| `flutter_map` | OpenStreetMap tiles |
| `latlong2` | LatLng coordinates |

## Notes
- Map uses **OpenStreetMap** (free, no API key needed)
- Falls back to Hawassa University coordinates (7.0621, 38.4755) if GPS is unavailable
- Photo is optional; description + phone + location are required
- Tracking ID is generated locally (random alphanumeric)
