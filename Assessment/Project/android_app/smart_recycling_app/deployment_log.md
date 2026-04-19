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

---

## 3 - Static image inference successful on Android

What I did:
- Exported a float32 version of the trained Round 3 model from Edge Impulse for Flutter integration
- Implemented a basic classifier service for loading the model and running local inference
- Built a simple Flutter test screen for static image classification
- Ran the Flutter app on a physical Android phone

Outcome:
- The app successfully ran the model locally on the Android phone
- A static test image was classified successfully inside the Flutter app
- The test output returned the class `can` with a confidence score of 54.2%

Interpretation:
- This confirms that the trained image classification model can be integrated into a custom Flutter application and run locally on a handheld Android device
- The deployment pipeline from Edge Impulse export to mobile inference is now working

Next step:
- Replace the static test workflow with image input from the phone camera
- Build a real-time or near-real-time classification interface
- Add clearer result presentation and disposal guidance for the final prototype

---

## 4 - Camera preview integrated into Flutter app

What I did:
- Added the Flutter camera plugin
- Configured Android camera permission in the manifest
- Implemented a dedicated camera preview screen
- Tested the app on a physical Android phone
- Verified that the phone camera could be accessed successfully inside the custom Flutter app

Outcome:
- The app can now display a live camera preview on the Android phone
- This confirms that the project is ready to move from static local inference to camera-based classification

Next step:
- capture frames from the camera preview
- run periodic on-device inference on the current image
- display the prediction and confidence directly on top of the live camera view
- 
