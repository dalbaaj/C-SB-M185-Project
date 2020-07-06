#C&SBIO M185 - Assignment 3 Source Code

#-----------------------------------------------------------------------------------#

#Required survival packages, plotting packages

library(survival)
library(survminer)
library(ggplot2)
library(ggfortify)

#-----------------------------------------------------------------------------------#

#Kaplan-Meier Method and Log-Rank Test

data <- read.csv("Official Final Data with NaN and Event Days.csv", header=TRUE)
surv_object <- Surv(time = data$event_days, event = data$vital_status)

#Repeat these two lines of code for every categorical covariate
fit <- survfit(surv_object ~ data$gender)
ggsurvplot(fit, data = data, pval=TRUE)

#-----------------------------------------------------------------------------------#

#Univariate Cox Regression

data <- read.csv("Official Final Data with NaN and Event Days.csv", header=TRUE)
surv_object <- Surv(time = data$event_days, event = data$vital_status)

#Repeat these two lines of code for every covariate
cox <- coxph(surv_object ~ karnofsky_performance_score, data = data)
summary(cox)

#-----------------------------------------------------------------------------------#

#Multivariate Cox Regression

data <- read.csv("FIXED Full Cox Training Set.csv", header=TRUE)
surv_object <- Surv(time = data$event_days, event = data$vital_status)

#Building the Cox model, only use potentially significant covariates
cox <- coxph(surv_object ~ age_at_initial_pathologic_diagnosis +
               radiation_therapy +
               postoperative_rx_tx +
               regimen_indication_d +
               drug_duration +
               performance_status, data = data)
summary(cox)

#-----------------------------------------------------------------------------------#

#Sampling patient survival times

dataTrain <- read.csv("FIXED Full Cox Training Set.csv", header=TRUE)
dataTest <- read.csv("FIXED Full Cox Testing Set (Only Covariates of Interest).csv", header=TRUE)

#Building the Cox model, only use significant covariates
surv_object <- Surv(time = dataTrain$event_days, event = dataTrain$vital_status)
cox <- coxph(surv_object ~ radiation_therapy +
               postoperative_rx_tx +
               drug_duration, data = dataTrain)

#k is the test patient index, run the following lines for each test patient index
k <- 1

#Build a survival curve for a specific patient
fit <- survfit(cox, newdata=dataTest[k,])

#Create CDF
cdf <- c(0,(1 - fit$surv),1)
times <- c(0, fit$time, 1800)

#Sample from CDF
qrand <- runif(1000)
Tsample <- approx(cdf,times,qrand)$y
test <- Tsample[!is.na(Tsample)]

#Report simulation results for patient k
mean(test)
sd(test)

#-----------------------------------------------------------------------------------#

#Evaluating predictions

data <- read.csv("Data for Testing Evaluation v2.csv", header=TRUE)
linear_regression <- lm(data$predicted_time ~ data$actual_time)

#Create scatterplot
plot(data$predicted_time ~ data$actual_time,
     main="Linear Regression of Actual vs. Predicted Survival Time",
     xlab="Actual Survival Time", ylab="Predicted Survival Time",
     pch=15, col="blue",
     axes=FALSE, ylim=range(200,1800))
axis(side=1, at=seq(0, 1650, by=100))
axis(side=2, at=seq(200, 1800, by=100))
box()
abline(linear_regression, col="blue") #Actual best-fit line
abline(0,1,lty=2) #Ideal best-fit line

#Draw error bars
for (i in 1:29){
  arrows(x0=data$actual_time[i], y0=data$predicted_time[i] - data$stddev[i],
         x1=data$actual_time[i], y1=data$predicted_time[i] + data$stddev[i],
         code=3, angle=90, length=0.1, col="blue") 
}

summary(linear_regression)