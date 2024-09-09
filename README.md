# catbreeds App

A Flutter mobile application to explore different cat breeds. This app consumes [The Cat API](https://thecatapi.com) to display cat images and breed details.

## Description

The **Cat Breeds App** allows users to view cat images and obtain detailed information about cat breeds, including intelligence, adaptability, and other traits. The app also includes a search feature to find specific breeds by name.

## Features

- List of cat breeds.
- Search functionality by breed name.
- View detailed information about each breed.
- Uses design patterns like **BLoC** and **Repository**.
- State management with **RxDart**.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/elimesa/catbreeds.git

2. Navigate to the project directory:
   cd cat-breeds-app

3. Install the dependencies:
   flutter pub get
4. Run the app:
   flutter run

## Project Structure
      lib/
      blocs/: Business logic components using the BLoC pattern.
      models/: Data models for cat breeds and images.
      providers/: API provider handling HTTP requests.
      repositories/: Interacts with providers to handle data access logic.
      screens/: Application screens (list, detail views).
      widgets/: Reusable UI components. 
## Dependencies
## Key dependencies used in this project:
    Flutter (>=2.0.0)
    RxDart
    Http
    Provider



