# Android App Notes

## Goal
Build an Android mobile app for real-time waste classification.

## Platform
- Android Studio
- Flutter
- Dart
- Physical Android phone

## Current status
### Phase 1
Flutter environment setup completed and the default Flutter app ran successfully on the Android device.

### Phase 2
The Round 3 model was exported from Edge Impulse and added to the Flutter app assets together with the label file.

### Phase 3
Static image inference now works locally inside the Flutter app.

### Phase 4
The Android phone camera was integrated into the Flutter app and the camera preview worked successfully.

### Phase 5
Near-real-time on-device classification now works inside the app using the live camera view.

The current app can:
- show a live camera preview
- classify the current scene locally on the phone
- display the predicted label
- display the confidence score
- display a disposal suggestion

## Current status
The prototype is now a working handheld Android edge-AI application rather than a static model test.
