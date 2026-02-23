# Fault Reporting Mobile App

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-orange?logo=firebase)](https://firebase.google.com)
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
Contributions welcome! Follow these steps for junior devs:

1. **Fork the Repo**: Go to the GitHub page and click "Fork" to create your copy.
2. **Clone Locally**: `git clone https://github.com/YOUR_USERNAME/FaultReportingApp.git && cd FaultReportingApp`
3. **Create a Branch**: Use a descriptive name, e.g., `git checkout -b feature/add-login-screen` (for new features) or `bugfix/fix-sms-bug` (for fixes).
4. **Work on Changes**: Make edits in your branch. Test locally with `flutter run`.
5. **Commit Changes**: Stage files (`git add .`), commit with a clear message (`git commit -m "Added login screen with auth"`).
6. **Push to Fork**: `git push origin feature/add-login-screen`
7. **Create Pull Request (PR)**: On GitHub, go to your fork, click "Compare & pull request". Describe changes, reference issues if any.
8. **Review & Merge**: Wait for review; address feedback by pushing updates to your branch.

Best practices: Keep branches focused (one feature/fix per branch), pull main updates (`git pull origin main`), resolve conflicts early.

## License
MIT - see [LICENSE](LICENSE).

## Acknowledgments
Student team at HU, advised by Yonatan.
