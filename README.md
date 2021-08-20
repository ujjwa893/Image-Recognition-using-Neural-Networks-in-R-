# Image-Recognition-using-Neural-Networks-in-R-
The objective of the project is to identify characters of   handwritten images of the first and last characters of my name-"Ujjwal" which are U and L.The U_LDataset consists of  12 pictures .First 6 pictures are L and errored version of L,Next 6 pictues are U and errored version of of U.The detailed steps are-
#Resizing all the pictures to have same dimension
#Reshape to convert all pics to a single vector
#Row Bind to combine the data into one vector
#One Hot Encoding
#Creating Neural Network for the structure of the Model

The details of the neural network are-
Number of neurons in hidden layer=256, 
no of neurons in input=3072,activation function is Rectified linear function
introducing 2nd hidden layer,neurons in hidden layer=128
activation_function=softmax

#Model Compilation
#Fitting the model
#NUMBER OF EPOCHS OR ITERATIONS=30
#20% data will be used for Validation and 80 percent of data for training

