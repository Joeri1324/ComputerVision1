function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
run(fullfile(fileparts(mfilename('fullpath')), ...
  '..', 'matconvnet-1.0-beta25', 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-caltech.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = [];



%% update model

net = update_model();

%% TODO: Implement getCaltechIMDB function below

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
  disp(imdb.images);
else
  imdb = getCaltechIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1, batch) ;

if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getCaltechIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment

airplanesTrain = permute(readInData('./ImageData/airplanes_train/'), [1 2 3 4]);
carsTrain = permute(readInData('./ImageData/cars_train/'), [1 2 3 4]);
facesTrain = permute(readInData('./ImageData/faces_train/'), [1 2 3 4]);
motorbikesTrain = permute(readInData('./ImageData/motorbikes_train/'), [1 2 3 4]);

airplanesTest = permute(readInData('./ImageData/airplanes_test/'), [1 2 3 4]);
carsTest = permute(readInData('./ImageData/cars_test/'), [1 2 3 4]);
facesTest = permute(readInData('./ImageData/faces_test/'), [1 2 3 4]);
motorbikesTest = permute(readInData('./ImageData/motorbikes_test/'), [1 2 3 4]);

data = single(cat(4, airplanesTrain, carsTrain, facesTrain, motorbikesTrain, airplanesTest, carsTest, facesTest, motorbikesTest));
training_size = size(airplanesTrain, 4) + size(carsTrain, 4) + size(facesTrain, 4) + size(motorbikesTrain, 4);
test_size = size(airplanesTest, 4) + size(carsTest, 4) + size(facesTest, 4) + size(motorbikesTest, 4);

sets = single([
    single(ones([training_size, 1])); 
    single(ones([test_size, 1]) + 1);
]);

labels = single([
    single(ones([size(airplanesTrain, 4), 1]));
    single(ones([size(carsTrain, 4), 1]) + 1);
    single(ones([size(facesTrain, 4), 1]) + 2);
    single(ones([size(motorbikesTrain, 4), 1]) + 3);
    single(ones([size(airplanesTest, 4), 1]));
    single(ones([size(carsTest, 4), 1]) + 1);
    single(ones([size(facesTest, 4), 1]) + 2);
    single(ones([size(motorbikesTest, 4), 1]) + 3);
]);

dataMean = mean(data(:, :, :, sets == 1), 4);

data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = single(labels') ;
imdb.images.set = single(sets');
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end

function [images] = readInData(folderName)

    imagefiles = dir(strcat(folderName, '*.jpg')); 
    
    nfiles = length(imagefiles);    % Number of files found
    
    image = imread(strcat(folderName, imagefiles(1).name));
    images = single(zeros(32, 32, 3, nfiles));

    for ii=1:nfiles
       currentfilename = strcat(folderName, imagefiles(ii).name);
       image = imread(currentfilename);  
       currentimage = imresize(im2double(image), [32 32]);
       if size(currentimage, 3) == 1
           currentimage = cat(3, currentimage, currentimage, currentimage);
       end
  
       images(:, :, :, ii) = im2single(currentimage);  
    end
end
