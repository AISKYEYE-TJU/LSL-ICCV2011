% note:
% TrainDAT.mat  ----      the training data
%               ----      tr_dat: 2d Training data matrix, each column vector is an (downsampled) 
%                            image.
%               ----      tr_lab: a row vector, each element is the label of each training sample
%               ----      im_w  : the width of image
%               ----      im_h  : the height of image
%
% TestDAT.mat   ----      the testing data
%               ----      tt_dat: 2d Training data matrix, each column vector is an (downsampled) 
%                            image matrix.
%               ----      tt_lab: a row vector, each element is the label
%               of each training sample
%
% Copyright. Mike Yang, PolyU, Hong Kong.
% reference:
% Meng Yang, Lei Zhang and David Zhang. METAFACE LEARNING FOR SPARSE
% REPRESENTATION BASED FACE RECOGNITION. ICIP, Hong Kong, 2010
clear all
clc;

path = cd;
addpath([path '\utilities']);

load TrainDAT;
load TestDAT;

par.lambda_l     =    0.001;          % parameter of l1_ls in learning
par.lambda_t     =    0.001;          % parameter of l1_ls in testing
par.dim          =    30;             % the pca dimension
par.ncol_ratio   =    1;              % the column number of Dictionary i divided by the training sample number in class i.
par.objT         =    1e-2;           % the objective gap of metaface learning
par.nIter        =    25;             % the maximal iteration number of metaface learnng

[disc_set,disc_value,Mean_Image]  =  Eigenface_f(double(tr_dat),par.dim);
tr_gdat        =    disc_set'* tr_dat;
tt_gdat        =    disc_set'* tt_dat;
tr_gdat        =    tr_gdat./ repmat(sqrt(sum(tr_gdat.*tr_gdat)),[size(tr_gdat,1) 1]); % unit norm 2
tt_gdat        =    tt_gdat./ repmat(sqrt(sum(tt_gdat.*tt_gdat)),[size(tt_gdat,1) 1]); % unit norm 2

classids = unique(tr_lab);
NumClass = length(classids);

%Metaface Dictionary Learning
for class=1:NumClass
    Class_im   =   tr_gdat(:,(tr_lab==class));
    par.ncol   =   floor(par.ncol_ratio*size(Class_im,2));
%     [D(class).d,ALPHA(class).alpha] = Metaface(Class_im, par.ncol, par.lambda_l, par.objT, par.nIter);
    [D(class).d,ALPHA(class).alpha]=Metaface_rand(Class_im,par.ncol,par.lambda_l,par.objT,par.nIter);
end

%compute recognition rate using whole class dictionary and min gap begin
    [ID,reco_ratio]  =  min_1Dwhole_reconstruct_gap(tr_gdat,tt_lab,D,NumClass,par.lambda_t);
    fprintf(['The recognition rate is ' num2str(reco_ratio)]);
%compute recognition rate using whole class dictionary and min gap end

