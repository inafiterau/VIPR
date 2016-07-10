clear;
load('diabetes_uci_scale.mat');
d_range = 3:3;
P = 2;
Solver = @SVMclassificationSolver;
Predict = @SVMclassificationPredict;
ComputeLoss = @ComputeKNNloss;
LossParams = 3;
SelectionMethod = 'greedy';
SelectionParams = 0;
[VIPRmodel] = VIPRTrainModel(Solver, X, Y, d_range, P, ComputeLoss, LossParams, SelectionMethod, SelectionParams);
[VIPRmodel] = VIPRaddFeatureNames(VIPRmodel, Features);
[FigHandles] = VIPRPlotModel(VIPRmodel);