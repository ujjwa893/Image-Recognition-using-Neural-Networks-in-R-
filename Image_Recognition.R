#LOADING THE REQUIRED PACKAGES
library(EBImage)
library(keras)

#READING THE IMAGES FROM THE SELFMADE DATASET
setwd('C:/Users/ujjwa/Downloads/U_LDataset')  #My name is Ujjwal it starts with U and ends with L
all_pics <- c('L1.jpeg','L2.jpeg','L3.jpeg','L4.jpeg','L5.jpeg','L6.jpeg','U1.jpeg','U2.jpeg',
              'U3.jpeg','U4.jpeg','U5.jpeg','U6.jpeg')
pics_UL <- list()
for (i in 1:12) {pics_UL[[i]] <- readImage(all_pics[i])}

# Exploring the dataset
print(pics_UL[1])                    #My name is "Ujjwal" it starts with U and ends with L
display(pics_UL[[1]])               #First 6 pictures are L and errored version of L,Next 6 pictues are U
print(pics_UL[8])                  #and errored version of of U
display(pics_UL[[8]])
summary(pics_UL[[1]]) #picture converted into numbers for classification,prediction
hist(pics_UL[[10]])       #intensity of 10th pic (randomly selected) lies between 0.0 to ~0.62
hist(pics_UL[[1]])
str(pics_UL)     #Structure eg mean,median,mode etc of all pics

# #Resizing all the pictures to have same dimension
for (i in 1:12) {pics_UL[[i]] <- resize(pics_UL[[i]],32,32)} #specifying dimensions
str(pics_UL)

#Reshape to convert all pics to a single vector
for (i in 1:12) {pics_UL[[i]] <- array_reshape (pics_UL[[i]], c(32,32,3))}  #vector(32*32*3)
str(pics_UL)

#Row Bind to combine the data into one vector
traina <- NULL             #data for training a for Independent Var,b for dependent Var
for (i in 1:5) {traina <- rbind(traina, pics_UL[[i]])}#combining the training data in one
str(traina)
for (i in 7:11) {traina <- rbind(traina, pics_UL[[i]])}
str(traina)
testa <- rbind(pics_UL[[6]], pics_UL[[12]])
trainb <- c(0,0,0,0,0,1,1,1,1,1 )     #y is response variable
testb <- c(0,1)#representing 'u' as 0 and 'L' as 1

# One Hot Encoding
trainLabels <- to_categorical(trainb)#when 1st col has 1 it is 's',2nd col has 1 is 'l'
testLabels <- to_categorical(testb)#creates dummy variables
trainLabels

# Creating Neural Network for the structure of the Model
model <- keras_model_sequential()
model %>%   
  layer_dense(units=512, activation='relu',input_shape =c(3072)) %>%   #Number of neurons in hidden layer=256,  
  #no of neurons in input=3072,activation function is Rectified linear function
  layer_dense(units=256, activation='relu',input_shape =c(3072)) %>% #introducing 2nd hidden layer,
  #neurons in hidden layer=128
  layer_dense(units=2, activation ='softmax') #output layer,number of neurons=2,
#activation_function=softmax
summary(model)

#Model Compilation
model %>%
  compile(loss='binary_crossentropy',
          optimizer= optimizer_rmsprop(),
          metrics=c('accuracy'))

#Fitting the model
history <- model %>%
  fit(traina,
      trainLabels,
      epochs=19,  #NUMBER OF EPOCHS OR ITERATIONS=30
      batch_size=32,
      validation_split=0.2) #20% data will be used for Validation and 80 percent of data for training