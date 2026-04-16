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
