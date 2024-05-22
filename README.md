# Project Overview

This project is a communication application enabling real-time video and audio communication, leveraging Agora for video and audio call functionalities. The app is built using Flutter for the front-end and Firebase for the back-end to handle user authentication, user data management, and push notifications.

# Project Details

Website: https://currant-e9b8d.web.app

# Features

1. User Authentication
   Sign Up/Log In: Users can sign up and log in using email and password.
   Profile Setup: Users can set up their profile with a profile picture and username.
   Password Reset: Users can reset their password via email.

2. Contacts and Invitations
   Sync Contacts: Sync phone contacts to find and connect with other users.
   Invite Friends: Invite non-users to join the app via SMS or social media.

3. Video Call Functionality
   One-on-One Video Call: Users can initiate and receive one-on-one video calls.
   Group Video Call: Users can initiate and join group video calls.
   Audio Call: Users can switch to audio-only calls if needed.
   Call Controls: Mute/unmute microphone, turn on/off camera, and switch camera (front/back).
   Screen Sharing: Option to share the screen during a video call.

4. Call Notifications
   Incoming Call Notifications: Push notifications for incoming calls.
   Missed Call Notifications: Notifications for missed calls.
   In-App Call Alerts: Alerts for incoming calls within the app.

5. Chat Functionality
   In-Call Chat: Text chat during video calls.
   Persistent Chat: Separate chat functionality to message contacts outside of video calls.

6. User Profiles
   View Profiles: View other users’ profiles.
   Edit Profile: Update profile picture, username, and status.

# Front-End (Flutter)

Framework: Flutter for building cross-platform mobile applications.
State Management: Provider, Riverpod, or other state management solutions.
Routing: Named routes or other suitable routing solutions in Flutter.
UI Design: Custom widgets, Material Design, animations, and responsive design for various screen sizes.

# Back-End (Firebase)

Authentication: Firebase Authentication for user management.
Database: Firestore for storing user profiles, contacts, and chat messages.
Storage: Firebase Storage for storing profile pictures.
Functions: Firebase Cloud Functions for backend logic such as sending notifications.
Notifications: Firebase Cloud Messaging (FCM) for push notifications.
Security Rules: Firestore and Storage security rules to protect user data.
Video Calling (Agora)
SDK: Agora SDK for real-time video and audio communication.
Features: Support for one-on-one and group video calls, audio calls, screen sharing, and call controls.
