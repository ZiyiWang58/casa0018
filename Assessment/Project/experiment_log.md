# Experiment Log

## 1 - Project setup

What I did:
- Confirmed the project direction based on tutor feedback.
- Decided to use a mobile phone as the edge device.
- Chose transfer learning as the primary modelling approach.
- Set up the project documentation structure inside `Assessment/Project`.
- Updated the project README and created the initial project files.

Next step:
- Define the initial dataset classes and write a first-round data collection plan.

---

## 2 - Initial dataset definition

What I did:
- Defined the first version of the classification task.
- Chose three initial classes: `plastic_bottle`, `can`, and `general_waste`.
- Wrote inclusion and exclusion rules for each class.
- Planned the first round of data collection and decided to build a small baseline dataset first.

Reflection:
- The initial class design seemed reasonable for a first baseline.
- However, the `general_waste` category was expected to be visually broad and potentially difficult for the model to learn.

Next step:
- Collect the first round of images for all three classes.

---

## 3 - First-round image collection completed

What I did:
- Completed the first round of image collection for all three classes.
- Collected 60 images each for `plastic_bottle`, `can`, and `general_waste`.
- Renamed the images into a consistent class-based format.
- Selected representative sample images for repository documentation.

Reflection:
- The first dataset was balanced across the three classes.
- The `general_waste` class already appeared visually inconsistent because it included multiple different object types.

Next step:
- Upload the baseline dataset to Edge Impulse and train the first transfer learning model.

---

## 4 - First transfer learning baseline results

What I did:
- Uploaded the first-round dataset to Edge Impulse.
- Created the first image classification impulse.
- Generated image features and trained the first transfer learning model.
- Evaluated the model using the validation accuracy, confusion matrix, and class-level results.

Results:
- Validation accuracy: 56.7%
- Loss: 1.30
- Weighted precision: 0.39
- Weighted recall: 0.57
- Weighted F1 score: 0.46

Observations:
- `can` performed best and was classified reliably.
- `plastic_bottle` achieved moderate performance but was still confused with `can`.
- `general_waste` performed very poorly and was not classified reliably.
- The confusion matrix suggested that the third class was too visually broad and inconsistent.

Interpretation:
- The first baseline confirmed that the pipeline worked end-to-end.
- The model was learning useful features, but the class design was limiting performance.
- The major weakness of the baseline came from the overly broad `general_waste` category.

Next step:
- Redefine the third class to make it visually more consistent.

---

## 5 - Redefining the third class

What I did:
- Reviewed the first baseline confusion matrix and class-level results.
- Identified that the `general_waste` category was too visually broad.
- Replaced the third class with `used_tissue`.
- Narrowed the task to three more visually distinct classes: `can`, `plastic_bottle`, and `used_tissue`.

Reason:
- The original `general_waste` class contained too many visually inconsistent objects such as tissues, plastic bags, coffee cups, plastic food boxes, and yoghurt containers.
- This likely prevented the model from learning a stable decision boundary for that class.

Updated class definition:
- `used_tissue` includes soft, thin, flexible tissue items such as napkins, facial tissues, and kitchen paper.
- It excludes coffee cups, paper cups, rigid cardboard, yoghurt containers, food boxes, and bags.

Reflection:
- Changing the class definition was necessary to make the task more learnable.
- The new third class was expected to be more visually coherent and more distinct from the bottle and can categories.

Next step:
- Collect second-round data for `used_tissue`.
- Add harder examples for `plastic_bottle` and `can`.
- Retrain the transfer learning model.

---

## 6 - Second-round dataset collection

What I did:
- Collected 80 images for the new `used_tissue` class.
- Added 20 extra images for `plastic_bottle`.
- Added 20 extra images for `can`.
- Prepared a refined second-round dataset with more consistent class definitions.

Dataset summary:
- `can`: 80 images
- `plastic_bottle`: 80 images
- `used_tissue`: 80 images

Reflection:
- The second-round dataset was more balanced and more visually consistent.
- The new third class was much narrower and more appropriate for a small image classification task.
- The additional bottle and can images also increased variation in lighting, angle, and background.

Next step:
- Upload the refined dataset to a second Edge Impulse project.
- Train a new transfer learning model and compare it to the baseline.

---

## 7 - Second-round transfer learning results

What I did:
- Created a second Edge Impulse project for the refined dataset.
- Uploaded the second-round data for `can`, `plastic_bottle`, and `used_tissue`.
- Trained a second transfer learning model using the refined class definitions.
- Compared the second-round model against the first baseline.

Results:
- Validation accuracy: 66.7%
- Loss: 0.72
- Weighted precision: 0.70
- Weighted recall: 0.67
- Weighted F1 score: 0.66

Comparison with Round 1:
- Accuracy improved from 56.7% to 66.7%
- Loss improved from 1.30 to 0.72
- Weighted F1 improved from 0.46 to 0.66

Observations:
- `can` remained the strongest class.
- `plastic_bottle` improved but still showed confusion with `can`.
- `used_tissue` performed much better than the previous `general_waste` class, though it remained weaker than `can`.
- The data explorer showed clearer class separation than in the first-round model.

Interpretation:
- The second-round dataset design was more effective.
- Replacing the broad `general_waste` class with the more visually consistent `used_tissue` class improved model performance substantially.
- This suggests that careful class design and visual consistency are especially important in small transfer learning datasets.

Next step:
- Perform a small final refinement of the dataset by adding more challenging examples for `used_tissue` and `plastic_bottle`.
- Train an updated version of the transfer learning model.
- Review whether the extra data improves confusion between classes, especially for `used_tissue`.

---

## 8 - Final refinement round results

What I did:
- Added a small set of more difficult `used_tissue` and `plastic_bottle` images
- Added the new images to the training set
- Regenerated image features in Edge Impulse
- Increased the number of training cycles from 20 to 30
- Trained a refined version of the transfer learning model

Results:
- Validation accuracy: 75.0%
- Loss: 0.44
- Weighted precision: 0.78
- Weighted recall: 0.75
- Weighted F1 score: 0.75

Comparison with previous rounds:
- Round 1 accuracy: 56.7%
- Round 2 accuracy: 66.7%
- Round 3 accuracy: 75.0%

Interpretation:
The final refinement improved the model further. The additional difficult training examples were especially helpful for the `used_tissue` class, which became significantly more reliable than in the previous round. This suggests that targeted data collection and small training adjustments can meaningfully improve a transfer learning model for small image classification tasks.

Next step:
- Deploy the refined Round 3 classifier to a smartphone as the final edge device.
- Test the deployed system outside the training environment and record practical observations about usability and performance.
