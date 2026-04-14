# Project Idea

## Working title
Smart Recycling Assistant

## Problem
Everyday waste sorting is often confusing in shared accommodation, classrooms, and public indoor spaces. People may be unsure whether a waste item should be recycled or placed in general waste.

## Proposed solution
This project will build a lightweight image classification model using a self-collected dataset and deploy it on a smartphone for offline waste classification.

## Planned classes
- plastic_bottle
- can
- general_waste

## Planned workflow
1. Collect my own image dataset
2. Train a transfer learning model in Edge Impulse
3. Build a TensorFlow/TFLite deployment pipeline
4. Deploy the model on a mobile phone
5. Test the app under different real-world conditions
6. Refine the dataset and model based on errors

## Planned edge device
- Mobile phone

## Planned tools
- Edge Impulse
- TensorFlow / TensorFlow Lite
- Android Studio

## Notes from tutor feedback
- Use a mobile phone instead of a microcontroller
- Prioritise transfer learning
- Ensure the model is my own trained model, not an off-the-shelf model used as-is
