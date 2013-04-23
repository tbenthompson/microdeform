load('pcaReducedData.mat');
[numSamples numVars] = size(pcaReducedData);

net = network;

net.numInputs = 1;
net.inputs{1}.size = numVars;

net.numLayers = 2;
net.layers{1}.size = 50;
net.layers{2}.size = 20;

net.inputConnect(1) = 1;
net.layerConnect(2, 1) = 1;
net.outputConnect(2) = 1;
net.targetConnect(2) = 1;

net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'purelin';

net.biasConnect = [ 1 ; 1];

