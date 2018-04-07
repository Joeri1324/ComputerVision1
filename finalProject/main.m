%% Read in data

[cars_train, ~] = readInData('./Caltech4/ImageData/cars_train/');
[airplanes_train, ~] = readInData('./Caltech4/ImageData/airplanes_train/');
[faces_train, ~] = readInData('./Caltech4/ImageData/faces_train/');
[motorbikes_train, ~] = readInData('./Caltech4/ImageData/motorbikes_train/');

[cars_test, car_file_names] = readInData('./Caltech4/ImageData/cars_test/');
[airplanes_test,airplane_file_names] = readInData('./Caltech4/ImageData/airplanes_test/');
[faces_test, faces_file_names] = readInData('./Caltech4/ImageData/faces_test/');
[motorbikes_test, motorbikes_file_names] = readInData('./Caltech4/ImageData/motorbikes_test/');

%% Extract Features Descriptors

USE_AMOUNT_OF_DATA = 10;
 
car_train_descriptors = extractFeatureDescriptors(cars_train, USE_AMOUNT_OF_DATA,  'opponent');
airplane_train_descriptors = extractFeatureDescriptors(airplanes_train, USE_AMOUNT_OF_DATA,  'opponent');
faces_train_descriptors = extractFeatureDescriptors(faces_train, USE_AMOUNT_OF_DATA,  'opponent');
motorbikes_train_descriptors = extractFeatureDescriptors(motorbikes_train, USE_AMOUNT_OF_DATA,  'opponent');

car_test_descriptors = extractFeatureDescriptors(cars_test, false,  'opponent');
airplane_test_descriptors = extractFeatureDescriptors(airplanes_test, false,  'opponent');
faces_test_descriptors = extractFeatureDescriptors(faces_test, false,  'opponent');
motorbikes_test_descriptors = extractFeatureDescriptors(motorbikes_test, false,  'opponent');

descriptors = descriptorsToMatrix([
    car_train_descriptors;
    airplane_train_descriptors;
    faces_train_descriptors;
    motorbikes_train_descriptors;
]);

%% Building Visual Vocabulary

[idx, C] = kmeans(double(descriptors'), 400);
 
%% Quantize Features Using Visual Vocabulary

[trainX, trainY, ~] = buildMatrix([
    car_train_descriptors;
    airplane_train_descriptors;
    faces_train_descriptors;
    motorbikes_train_descriptors;
], C);

[testX, testY, back] = buildMatrix([
    car_test_descriptors;
    airplane_test_descriptors;
    faces_test_descriptors;
    motorbikes_test_descriptors;
], C);

%% Train Models

best = train(trainY(:, 1), sparse(trainX), '-C -s 0');
carModel = train(trainY(:, 1), sparse(trainX), sprintf('-c %f -s 0', best(1) + 0.00001));

best = train(trainY(:, 2), sparse(trainX), '-C -s 0');
airplanesModel = train(trainY(:, 2), sparse(trainX), sprintf('-c %f -s 0', best(1) + 0.00001));

best = train(trainY(:, 3), sparse(trainX), '-C -s 0');
facesModel = train(trainY(:, 3), sparse(trainX), sprintf('-c %f -s 0', best(1) + 0.00001));

best = train(trainY(:, 4), sparse(trainX), '-C -s 0');
motorbikesModel = train(trainY(:, 4), sparse(trainX), sprintf('-c %f -s 0', best(1) + 0.00001));

%% Evaluate

[pred1, acc1, confidence1] = predict(testY(:, 1), sparse(testX), carModel);
[pred2, acc2, confidence2] = predict(testY(:, 2), sparse(testX), airplanesModel);
[pred3, acc3, confidence3] = predict(testY(:, 3), sparse(testX), facesModel);
[pred4, acc4, confidence4] = predict(testY(:, 4), sparse(testX), motorbikesModel);


[~, index1] = sortrows(confidence1, 'descend');
[~, index2] = sortrows(confidence2, 'descend');
[~, index3] = sortrows(confidence3, 'descend');
[~, index4] = sortrows(confidence4, 'descend');

%% MAP

map = mean([
    averagePrecision(pred1(index1), testY(index1, 1));
    averagePrecision(pred2(index2), testY(index2, 2));
    averagePrecision(pred3(index3), testY(index3, 3));
    averagePrecision(pred4(index4), testY(index4, 4));
]);

averagePrecision(pred1(index1), testY(index1, 1))
averagePrecision(pred2(index2), testY(index2, 2))
averagePrecision(pred3(index3), testY(index3, 3))
averagePrecision(pred4(index4), testY(index4, 4))

%% generate html

resultsToHtml([index1 index2 index3 index4], testY, {car_file_names airplane_file_names faces_file_names motorbikes_file_names}, back);
