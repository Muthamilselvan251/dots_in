# Health Data Hub

Health Data Hub is a Flutter application that presents personal health information through interactive body and organ views. The project focuses on recreating the supplied health dashboard designs with reusable widgets, responsive layouts, custom-painted visuals, and local sample data.

No backend, authentication, medical API, or real medical calculation is used. All displayed values are demonstration data loaded from a local JSON file.

## Features

- Genotype and phenotype overview tabs
- Interactive human-body health overview
- Organ selection panel
- Heart, lungs, kidneys, brain, bones, stomach, and intestine overviews
- Overall health-condition detail screen
- Organ-specific recommendations, strengths, and weaknesses
- Chronic disease risk-assessment cards
- Blood metrics and LDL cholesterol details
- Hormone and prolactin metric details
- Genomic health section
- Responsive dark-themed interface
- Android and iOS support

## UI and animations

The application includes several custom UI elements:

- Custom-painted health score gauges
- Animated meter needles and percentage values
- Custom hormone chart
- Futuristic blue platform with an energy-glow effect
- Animated organ images and information callouts
- Pulsing body-condition anchor points
- Smooth section and page transitions
- Animated side-menu selection

Animations are kept short and are used to explain state changes without slowing down normal interaction.

## Tech stack

- Flutter and Dart
- GetX for dependency injection, state management, and routing
- Local JSON for sample health data
- `CustomPainter` for gauges, charts, and the body platform
- Flutter asset images for organs and supporting graphics

## Project structure

```text
lib/
├── main.dart
└── src/
    ├── app/                 # App setup, bindings, routes, and pages
    ├── core/
    │   ├── constants/       # Colors, spacing, icons, and asset paths
    │   ├── data/models/     # Health, organ, score, and metric models
    │   ├── datasources/     # Local JSON data loading
    │   ├── repositories/    # Health data repository
    │   └── theme/           # Light and dark themes
    ├── features/
    │   ├── home/            # Genotype and phenotype overview
    │   ├── organ_detail/    # Organ condition and risk pages
    │   └── metric_detail/   # Blood and hormone metric pages
    └── shared/widgets/      # Reusable gauges, panels, cards, and headers

assets/
├── data/health_data.json    # Local demonstration data
└── images/                  # Body, organ, icon, and DNA assets
```

## Getting started

### Requirements

- Flutter SDK compatible with Dart `^3.9.2`
- Android Studio or Visual Studio Code
- Android emulator/device, or macOS with Xcode for iOS

### Run the project

```bash
flutter pub get
flutter run
```

To choose a connected device:

```bash
flutter devices
flutter run -d <device-id>
```

## Validation

```bash
flutter analyze
flutter test
```

## Build

Android APK:

```bash
flutter build apk --release
```

Android App Bundle:

```bash
flutter build appbundle --release
```

iOS build requires macOS and Xcode:

```bash
flutter build ios --release
```

## Local data

Health information is stored in `assets/data/health_data.json`. It contains:

- Organ information and callouts
- Health-condition scores
- Recommendations
- Strengths and weaknesses
- Risk-assessment metrics
- Blood metrics
- Hormone metrics

The repository and data-source layers parse this file into typed Dart models. The JSON can be replaced later with API responses without rebuilding the UI layer.

## Important note

This application is a UI demonstration and must not be used for medical diagnosis or treatment decisions. The values and recommendations are sample content only.
