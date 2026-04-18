# Smart Recycling Assistant

A mobile edge-AI image classification project for everyday waste sorting.

## Project summary
This project explores whether a lightweight image classification model can be trained using my own dataset and deployed on a smartphone to classify common waste items offline.

## Research question
Can a transfer-learning-based image classifier, trained on a self-collected dataset and deployed on a mobile phone, reliably distinguish common waste items for everyday recycling support?

## Initial classes
- plastic_bottle
- can
- used_tissue

## Planned tools
- Edge Impulse
- TensorFlow / TensorFlow Lite
- Android Studio
- GitHub

## Planned platform
- Mobile phone as the edge device

## Folder guide
- `project_idea.md` — initial project proposal
- `timeline.md` — two-week work plan
- `experiment_log.md` — ongoing development log
- `dataset_notes.md` — dataset design and collection notes
- `edge_impulse/` — screenshots, exports and training notes
- `tensorflow/` — baseline notebooks and model results
- `android_app/` — deployment notes and screenshots
- `media/` — figures, demo photos and final visuals

## Current status
The first round of self-collected image data has been completed.

Current dataset size:
- plastic_bottle: 60 images
- can: 60 images
- general_waste: 60 images

A small set of representative sample images is included in this repository, while the full dataset is stored locally for training and deployment work.

## Latest results

### Baseline model (Round 1)
- Classes: `can`, `plastic_bottle`, `general_waste`
- Validation accuracy: 56.7%
- Main issue: the `general_waste` class was too visually broad and inconsistent

### Improved model (Round 2)
- Classes: `can`, `plastic_bottle`, `used_tissue`
- Validation accuracy: 66.7%
- Weighted precision: 0.70
- Weighted recall: 0.67
- Weighted F1 score: 0.66

### Key finding
Replacing the overly broad `general_waste` class with a more visually consistent `used_tissue` class improved overall classification performance.
