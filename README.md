# C-SB-M185-Project
#This is our C&SB M185 Group Project for Winter 2020

#Project is based on previous research which has indicated that logistic regression machine learning models that use patient data temporal patterns as features (identified with cSPADE) can better classify survival time in patients with glioblastoma. This logistic regression model used by the paper listed above gives discretized survival output (for example, “greater than 6 months of survival,” or “less than 2 months of survival”).
#Goal of project is to determine if the logistic regression model used in the paper Longitudinal Patterns in Clinical and Imaging Measurements Predict Residual Survival in Glioblastoma Patients (PI Dr. William Hsu) still perform well when tumor volume analysis is automated and temporal patterns in the data are minimized (generated using only KPS scores as opposed to other neurological measures)? Will a cox regression model be better at predicting survival under these data conditions?
#Will use public database from the The Cancer Genome Atlas (TCGA) specific to glioblastoma patient data (TCGA - GBM)
