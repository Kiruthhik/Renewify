# Renewify

Renewify is a comprehensive platform designed to facilitate the adoption of renewable energy solutions for households in India. It combines a Flutter mobile app and a Flask web app to offer personalized solar analysis, biogas digester AR visualization, real-time energy monitoring, and a community forum.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation Guide](#installation-guide)
- [Usage](#usage)
  - [Solar Installation](#solar-installation)
  - [Biogas Digester Installation](#biogas-digester-installation)
  - [Loans & Subsidies](#loans--subsidies)
  - [Electricity Monitoring](#electricity-monitoring)
  - [Gas Level Monitoring](#gas-level-monitoring)
  - [Updates](#updates)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Renewify aims to include green energy in every household by making it easy for users to transition to renewable energy sources. The app provides information, recommendations, and tools for solar panel and biogas digester installations, financial assistance, real-time monitoring, and maintenance updates.

## Features

- **Solar Installation**: Personalized solar panel recommendations based on residence area, rooftop space, and climate.
- **Biogas Digester Installation**: AR visualization of biogas digesters and direct contact with installation centers.
- **Loans & Subsidies**: Information on available financial assistance for renewable energy installations.
- **Electricity Monitoring**: Real-time tracking of electricity generation and consumption, fault detection, and future consumption advice.
- **Gas Level Monitoring**: Monitoring of biogas and LPG gas levels with leak detection.
- **Updates**: Maintenance procedures, technological advancements, and community forum.

## Installation Guide

### Prerequisites

- Flutter SDK
- Dart
- Python 3.x
- Flask
- ARKit (for iOS)
- ARCore (for Android)

### Steps

1. Clone the repository:
    ```bash
    git clone https://github.com/Kiruthhik/Renewify.git
    ```
2. Navigate to the project directory:
    ```bash
    cd Renewify
    ```
3. Install dependencies for the Flutter app:
    ```bash
    flutter pub get
    ```
4. Install dependencies for the Flask backend:
    ```bash
    pip install -r requirements.txt
    ```
5. Run the Flask backend:
    ```bash
    flask run
    ```
6. Run the Flutter app:
    ```bash
    flutter run
    ```

## Usage

### Solar Installation

1. **Enter Details**: Provide residence area, rooftop space, and climate information.
2. **View Recommendations**: Get suggestions for solar panel and inverter types.
3. **Installation Points**: Review important points before installation.
4. **Contact Centers**: Find and contact government-verified solar installation centers.
5. **Apply for NOC**: Apply for a no-objection certificate from the municipality through the app.

### Biogas Digester Installation

1. **Requirement Criteria**: Check if the home meets the criteria for a biogas digester.
2. **AR Visualization**: Use the app's AR feature to visualize the digester in the home.
3. **Contact Centers**: Contact biogas installation centers directly through the app.

### Loans & Subsidies

1. **View Options**: See available loans and subsidies for financial assistance.
2. **Apply**: Directly apply for selected financial aid options through the app.

### Electricity Monitoring

1. **Track Generation**: Monitor daily electricity generation and consumption.
2. **View Graphs**: Analyze electricity generation and consumption through visual graphs.
3. **Bill Reduction**: See the reduction in electricity bills and share reports.
4. **Fault Detection**: Raise complaints for system faults.
5. **Usage Advice**: Get monthly advice based on average consumption and sunlight availability.

### Gas Level Monitoring

1. **Monitor Levels**: Check the levels of biogas and LPG gas.
2. **Raise Complaints**: Report errors and issues.
3. **Leak Detection**: Receive phone alarms for gas leaks.

### Updates

1. **Maintenance Procedures**: Access maintenance tips for solar and biogas systems.
2. **Technological Advancements**: Read and post updates on new technologies in renewable energy.

## Contributing

We welcome contributions from the community. Please read our [Contributing Guidelines](CONTRIBUTING.md) for more information.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
