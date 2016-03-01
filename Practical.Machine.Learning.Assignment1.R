library(caret)
library(rpart)
library(randomForest)
library(rpart.plot)

##### Load the data sets and replace the missing values with "NA"
train <- read.csv("pml-training.csv",na.strings = c("NA","","#DIV/0!"))
test <- read.csv("pml-testing.csv",na.strings = c("NA","","#DIV/0!"))

##### Delete the columns filled with NAs
train <- train[,colSums(is.na(train)) == 0]
test <- test[,colSums(is.na(test)) == 0]

##### Delete the columns with useless variables
train<-train[,-c(1:7)]
test<-test[,-c(1:7)]

##### Separte Training Data to allow Cross Validation
inTrain <- createDataPartition(y = train$classe, p = 0.75, list = FALSE)
subtraining <- train[inTrain, ]  
testtraining <- train[-inTrain, ]  

##### Get the dimensions of datasets
dim(subtraining)   # 14718 obs. of 53 variables
dim(testtraining)  # 4904 obs. of 53 variables

##### Create a CART model
modFit1<-train(classe~.,data=subtraining,method="rpart")
precition1<-predict(modFit1,testtraing)
print(modFit1)

##### Create a randomforest model
modFit2<-train(classe~.,data=subtraining,method="rf",trControl=trainControl(number = 4))
precition2<-predict(modFit2,testtraining)
print(modFit2)

##### Cross Validation
prediction3<-predict(modFit2,test)
prediction3
table(prediction3,test$classe)
