%% Read in data

cars_train = readInData('./Caltech4/ImageData/cars_train/');
airplanes_train = readInData('./Caltech4/ImageData/airplanes_train/');
faces_train = readInData('./Caltech4/ImageData/airplanes_train/');
motorbikes_train = readInData('./Caltech4/ImageData/motorbikes_train/');

cars_test = readInData('./Caltech4/ImageData/cars_test/');
airplanes_test = readInData('./Caltech4/ImageData/airplanes_test/');
faces_test = readInData('./Caltech4/ImageData/airplanes_test/');
motorbikes_test = readInData('./Caltech4/ImageData/motorbikes_test/');

%% Extract Features Descriptors

USE_AMOUNT_OF_DATA = 10;
 
car_train_descriptors = extractFeatureDescriptors(cars_train, USE_AMOUNT_OF_DATA);
airplane_train_descriptors = extractFeatureDescriptors(airplanes_train, USE_AMOUNT_OF_DATA);
faces_train_descriptors = extractFeatureDescriptors(faces_train, USE_AMOUNT_OF_DATA);
motorbikes_train_descriptors = extractFeatureDescriptors(motorbikes_train, USE_AMOUNT_OF_DATA);

car_test_descriptors = extractFeatureDescriptors(cars_train, 10);
airplane_test_descriptors = extractFeatureDescriptors(airplanes_train, 10);
faces_test_descriptors = extractFeatureDescriptors(faces_train, 10);
motorbikes_test_descriptors = extractFeatureDescriptors(motorbikes_train, 10);

descriptors = descriptorsToMatrix([
    car_train_descriptors;
    airplane_train_descriptors;
    faces_train_descriptors;
    motorbikes_train_descriptors;
]);

%% Building Visual Vocabulary

[idx, C] = kmeans(double(descriptors'), 400);
 
%% Quantize Features Using Visual Vocabulary

[trainX, trainY] = buildMatrix([
    car_train_descriptors;
    airplane_train_descriptors;
    motorbikes_train_descriptors;
    faces_train_descriptors;
], C);

[testX, testY] = buildMatrix([
    car_test_descriptors;
    airplane_test_descriptors;
    motorbikes_test_descriptors;
    faces_test_descriptors;
], C);

%% Train Models

carModel = train(trainY(:, 1), sparse(trainX));
airplanesModel = train(trainY(:, 2), sparse(trainX));
facesModel = train(trainY(:, 3), sparse(trainX));
motorbikesModel = train(trainY(:, 4), sparse(trainX));

%% Evaluate

predict(testY(:, 1), sparse(testX), carModel, '-b 1')



