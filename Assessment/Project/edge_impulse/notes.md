## Baseline model results

The first transfer learning baseline achieved 56.7% validation accuracy.

Observations:
- The model classified `can` most reliably.
- `plastic_bottle` achieved moderate performance but was sometimes confused with `can`.
- `general_waste` performed very poorly and was never correctly classified in the validation set.
- This suggests that the `general_waste` category is visually too broad and inconsistent.

Planned improvements:
- collect a more visually consistent set of `general_waste` examples
- add more difficult bottle and can images
- reduce background bias and improve class balance in real-world scenes

## Round 2 transfer learning results

Dataset:
- can: 80 images
- plastic_bottle: 80 images
- used_tissue: 80 images

Training setup:
- Transfer learning
- 20 training cycles
- Learning rate: 0.0005
- Data augmentation: enabled

Results:
- Validation accuracy: 66.7%
- Loss: 0.72
- Weighted precision: 0.70
- Weighted recall: 0.67
- Weighted F1 score: 0.66

Observations:
- `can` remained the strongest class
- `plastic_bottle` improved but was still confused with `can`
- `used_tissue` performed much better than the previous `general_waste` category, but remains the weakest class overall

Conclusion:
Changing the third category to a more visually consistent class improved model performance substantially.
