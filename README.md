# Wastegram

# Overview

Wasteagram is a mobile app designed to help coffee shop employees document daily food waste. With Wasteagram, users can create "posts" consisting of a photo, the number of leftover items, the current date, and the location of the device when the post is created.

The app is designed with accessibility in mind and incorporates the use of the Semantics widget in multiple places, such as interactive widgets like buttons. The codebase incorporates a model class and a few simple unit tests that test the model class. The app uses location, image_picker, cloud_firestore, and firebase_storage packages to meet the functional and technical requirements. It also incorporates Firebase Cloud Storage and Firebase Cloud Firestore for storing images and post data.

Additionally, Wasteagram incorporates Sentry error catching and Google Analytics for improved app stability and user insights. Sentry helps to track and report errors in the app, enabling developers to quickly identify and fix issues. Google Analytics provides valuable user data, such as user behavior, usage patterns, and app performance, to help improve the app's functionality and user experience.

# Installation

    Clone this repository using git clone https://github.com/ThomofBiloxi/Wasteagram.git.
    Change into the project directory using cd wasteagram.
    Install dependencies using flutter pub get.
    Create a new Firebase project and enable Firebase Storage and Firebase Firestore.
    Download the google-services.json file and add it to the android/app directory.
    Run the app using flutter run.
    
 # Media

<div style="display: flex;">
  <img src="https://github.com/ThomofBiloxi/Wasteagram/blob/main/Main%20Screen%20(No%20Posts).png?raw=true" alt="Main Screen (No Posts)" width="400">
  <img src="https://github.com/ThomofBiloxi/Wasteagram/blob/main/Main%20Screen%20(With%20Posts).png?raw=true" alt="Main Screen (With Posts)" width="400">
  <img src="https://github.com/ThomofBiloxi/Wasteagram/blob/main/New%20Post%20Creation%20Screen.png?raw=true" alt="New Post Creation Screen" width="400">
  <img src="https://github.com/ThomofBiloxi/Wasteagram/blob/main/Details%20Screen.png?raw=true" alt="Details Screen" width="400">
</div>
