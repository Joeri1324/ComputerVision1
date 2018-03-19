%% Read in data

cars_train = readInData('./Caltech4/ImageData/cars_train/');
airplanes_train = readInData('./Caltech4/ImageData/airplanes_train/');
faces_train = readInData('./Caltech4/ImageData/airplanes_train/');
motorbikes_train = readInData('./Caltech4/ImageData/motorbikes_train/');

%% Extract Features Descriptors

USE_AMOUNT_OF_DATA = 10;

descriptors = [];  
car_descriptors = {};
for i = 1:10
    fv = extractFeatures(cars_train{i});
    car_descriptors{i} = fv;
    descriptors = [descriptors, fv];
end

airplane_descriptors = {};
for i = 1:10
    fv = extractFeatures(airplanes_train{i});
    airplane_descriptors{i} = fv;
    descriptors = [descriptors, fv];
end   

faces_descriptors = {};
for i = 1:10
    fv = extractFeatures(faces_train{i});
    faces_descriptors{i} = fv;
    descriptors = [descriptors, fv];
end

motorbikes_descriptors = {};
for i = 1:10
    fv = extractFeatures(motorbikes_train{i});
    motorbikes_descriptors{i} = fv;
    descriptors = [descriptors, fv];
end

%% Building Visual Vocabulary

[idx, C] = kmeans(double(descriptors'), 400);
 
%% Quantize Features Using Visual Vocabulary

bow_cars = {};
for i = 1:size(car_descriptors, 2)
    bow_cars{i} = descriptorsToWords(double(car_descriptors{i}), C);
end

bow_airplanes = {};
for i = 1:size(airplane_descriptors, 2)
    bow_airplanes{i} = descriptorsToWords(double(airplane_descriptors{i}), C);
end

bow_faces = {};
for i = 1:size(faces_descriptors, 2)
    bow_faces{i} = descriptorsToWords(double(faces_descriptors{i}), C);
end

bow_motorbikes = {};
for i = 1:size(car_descriptors, 2)
    bow_motorbikes{i} = descriptorsToWords(double(motorbikes_descriptors{i}), C);
end

 %% Representing images by frequencies of visual words

features_cars = {};
for i = 1:size(bow_cars, 2)
    features_cars{i} = histcounts(bow_cars{i}, size(C, 1));
end

features_airplanes = {};
for i = 1:size(bow_airplanes, 2)
    features_airplanes{i} = histcounts(bow_airplanes{i}, size(C, 1));
end

features_faces = {};
for i = 1:size(bow_faces, 2)
    features_faces{i} = histcounts(bow_faces{i}, size(C, 1));
end

features_motorbikes = {};
for i = 1:size(bow_cars, 2)
    features_motorbikes{i} = histcounts(bow_motorbikes{i}, size(C, 1));
end

%% Support Vector Machine

% generate dataset

% cars

X = [];
carY = [];
airplanesY = [];
facesY = [];
motorbikesY = [];

for i = 1:size(features_cars, 2)
    X = [X; features_cars{i}];
    carY = [carY, 1];
    airplanesY = [airplanesY, 0];
    facesY = [facesY, 0];
    motorbikesY = [motorbikesY, 0];
end
for i = 1:size(features_airplanes, 2)
    X = [X; features_airplanes{i}];
    carY = [carY, 0];
    airplanesY = [airplanesY, 1];
    facesY = [facesY, 0];
    motorbikesY = [motorbikesY, 0];
end
for i = 1:size(features_faces, 2)
    X = [X; features_faces{i}];
    carY = [carY, 0];
    airplanesY = [airplanesY, 0];
    facesY = [facesY, 1];
    motorbikesY = [motorbikesY, 0];
end
for i = 1:size(features_motorbikes, 2)
    X = [X; features_motorbikes{i}];
    carY = [carY, 0];
    airplanesY = [airplanesY, 0];
    facesY = [facesY, 0];
    motorbikesY = [motorbikesY, 1];
end


%% Train Models

carModel = train(carY', sparse(X), '-c 1');
airplanesModel = train(airplanesY', sparse(X), '-c 1');
facesModel = train(facesY', sparse(X), '-c 1');
motorbikesModel = train(motorbikesY', sparse(X), '-c 1');

%% Evaluate




