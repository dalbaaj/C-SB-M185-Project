# C-SB-M185-Project
This is a C&SB M185 Group Project for Winter 2020.

This project is based on the paper, *Longitudinal Patterns in Clinical and Imaging Measurements Predict Residual Survival in Glioblastoma Patients* (PI William Hsu), which has indicated that logistic regression machine learning models which use patient data temporal patterns as features (identified with cSPADE algorithm) can better classify survival time in patients with glioblastoma. The logistic regression model used by the paper gives discretized survival output (for example, “greater than 6 months of survival,” or “less than 2 months of survival”). The goal of this project is to obtain continuous survival prediction results using Kaplan-Meier Analysis and a Cox Regression Model before comparing the performance to the logistic regression model used in the paper.  Will the Cox Regression Model provide better survival predictions? 

Note, the dataset used for this project is from from the The Cancer Genome Atlas (TCGA) specific to glioblastoma patient data (TCGA - GBM). 