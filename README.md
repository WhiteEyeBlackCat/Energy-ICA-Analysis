# Energy Futures Market Analysis via Independent Component Analysis
This repository contains the data preprocessing and Independent Component
Analysis (ICA) workflow used to study structural factors in energy futures
markets.


## Background and Motivation
Energy futures markets involve multiple interconnected commodities such as
power, natural gas, coal, and crude oil. Price dynamics across these markets
are often driven by latent structural factors, including fuel switching,
market integration, and policy-related shocks.

This project applies Independent Component Analysis (ICA) and Sparse ICA
to disentangle latent factors underlying multivariate energy futures prices.


## Methodology Overview
The analysis consists of the following steps:

1. Data preprocessing and unit harmonization
   - Currency conversion to USD
   - Unit normalization across commodities
   - Commodity category consolidation

2. Independent Component Analysis (ICA)
   - FastICA applied to log-return series
   - Component alignment and sign normalization

3. Sparse ICA
   - Sparse ICA implemented in R
   - Automatic sparsity selection via a BIC-like criterion
   - Comparison with FastICA results

The goal is to identify interpretable latent components representing
structural market drivers.


## Repository Structure

.
├── ICA.ipynb            # FastICA analysis and component interpretation
├── preprocess.ipynb     # Data cleaning, currency conversion, unit harmonization
├── exchange.ipynb       # Exchange rate processing
└── README.md


## Data Availability
Due to data licensing and redistribution restrictions, raw and intermediate
energy futures price data are not included in this repository.

The analysis can be reproduced by running the preprocessing notebooks with
appropriate data sources.
Only derived results required for demonstrating the methodology are provided.


## Software Requirements
- Python 3.x
  - pandas
  - numpy
  - scikit-learn
  - matplotlib

- R
  - sparseICA

