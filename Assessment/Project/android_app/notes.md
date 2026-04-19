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
The current test screen can load the model, run inference on a test image, and display the predicted class and confidence score.

## Current model result in app
- Prediction: `can`
- Confidence: 54.2%

## Next goal
Move from static inference to camera-based classification.
