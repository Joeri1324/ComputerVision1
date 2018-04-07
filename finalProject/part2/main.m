%% main function 

net = load('./data/pre_trained_model.mat') ;
vl_simplenn_display(net.net);

net.net
%% fine-tune cnn

[net, info, expdir] = finetune_cnn();
save './data/cnn_assignment-lenet/your_new_model' net

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile(expdir, 'your_new_model.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-caltech.mat'));
[pre_features, pre_labels, fine_features, fine_labels] = train_svm(nets, data);

%% visualize

tsne(full(pre_features), pre_labels);
tsne(full(fine_features), fine_labels);

