# Deployment Log

## 1 - Flutter Android environment setup

What I did:
- Checked the Flutter environment
- Created a new Flutter project for the mobile prototype

Outcome:
- The Flutter project was created successfully
- The default app launched on the phone

Next step:
- Export the trained image classification model
- Integrate the model into the Flutter app
- Test local inference on static images before adding real-time camera classification

---

## 2 - Exported model package and added Flutter assets

What I did:
- Exported the final Round 3 model package from Edge Impulse
- Confirmed that the exported package contained a `.tflite` model file
- Copied the model into the Flutter app assets directory
- Created a labels file for the three classes: `can`, `plastic_bottle`, and `used_tissue`
- Registered the model and labels in `pubspec.yaml`
- Added the LiteRT dependency to prepare for local inference

Outcome:
- The Flutter project now contains the model file and label definitions needed for local image classification
- The app is ready for the next step: testing static image inference on Android

Next step:
- Implement static image classification in Flutter
- Verify that the model can classify a test image correctly on the Android phone
