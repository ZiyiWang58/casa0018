# Dataset Notes

## Final classes
- plastic_bottle
- can
- used_tissue

## Project dataset strategy
This project will use a primarily self-collected image dataset captured using a smartphone camera. The goal is to build a lightweight image classifier for mobile deployment in realistic everyday indoor waste-sorting scenarios.

## Class definitions

### plastic_bottle
Examples:
- water bottles
- soft drink bottles
- juice bottles

Inclusions:
- transparent or coloured plastic bottles
- bottles with labels
- upright, side-on, or slightly crushed bottles

Exclusions:
- plastic cups
- plastic food trays
- detergent bottles
- bottle caps alone

### can
Examples:
- soft drink cans
- energy drink cans
- other aluminium beverage cans

Inclusions:
- full cans
- empty cans
- slightly dented cans

Exclusions:
- food tins
- bottle-shaped metal containers
- foil or metal lids alone

### used_tissue
Examples:
- napkins
- facial tissues
- kitchen paper
- lightly used thin tissue paper

Inclusions:
- soft, thin, flexible paper tissue items
- slightly crumpled or partially unfolded tissue paper

Exclusions:
- coffee cups
- paper cups
- cardboard
- food boxes
- receipts
- paper bags
- yoghurt containers

## Collection principles
- collect my own images
- keep classes as balanced as possible
- include multiple lighting conditions
- include multiple backgrounds
- include multiple angles and distances
- include some cluttered real-world scenes

## Known risks
- reflective surfaces may affect image quality
- cluttered backgrounds may increase confusion
- some general waste items may visually resemble recyclable materials

## Repository storage note

The full dataset is stored locally due to repository size considerations. This repository includes a small set of representative sample images for documentation purposes only.

## First-round dataset size
- plastic_bottle: 60 images collected
- can: 60 images collected
- general_waste: 60 images collected
- total: 180 images
