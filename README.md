# Fault Reporting Mobile App

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?logo=flutter)](https://flutter.dev)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

Cross-platform app for Hawassa University's IoT campus to report faults (e.g., leaks, outages) with minimal input, photos, GPS/maps (common names + coordinates), and SMS alerts to maintenance. Student MVP over 9 weeks, IoT-focused with expansion plans.

## Features

- Decentralized reporting open to students (minimal info).
- Photo upload and secure storage.
- GPS/map integration (Google Maps) with manual common names + coords.
- Twilio SMS notifications with map links.
- Security: Validation, rate limiting, API abstraction.

## Tech Stack

- Flutter (Dart)
- Firebase (Firestore, Storage, Auth)
- Twilio (SMS)
- Google Maps API + Geolocator

## Setup

1. Clone: `git clone https://github.com/FaultReportingApp.git && cd FaultReportingApp`
2. Dependencies: `flutter pub get`
3. Configure: Add Firebase files, Twilio creds, Google Maps key.
4. Run: `flutter run`

## Deployment
- Build: `flutter build apk` or `ios`.
- IoT demo; expansion in `deployment_strategy.md`.

## Usage
Submit fault with minimal details → Stores data → Sends SMS with map link.

## Testing
`flutter test`; Cyber review in Week 7.

## Contributing
Fork, branch, PR welcome.

## License
MIT - see [LICENSE](LICENSE).

## Acknowledgments
Student team at HU PCIC.
