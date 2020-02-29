function [D,cofficents]=dlsc(Data_select,parncol,patch1)
%==================learn the dictionary on the training data=======
par.lambda_l     =    0.001;          % parameter of l1_ls in learning
par.lambda_t     =    0.001;          % parameter of l1_ls in testing
par.objT         =    1e-2;           % the objective gap of metaface learning
par.nIter        =    25;             % the maximal iteration number of metaface learnng
par.ncol         =    parncol;


[D,alpha]=Metaface_rand(Data_select,par.ncol,par.lambda_l,par.objT,par.nIter);%Metaface Dictionary Learning

%==================spare coding for each patch ==========
lambda=0.001;
[patch_row,patch_col]=size(patch1);
patch_recon=[];
cofficents=[];
for i=1:patch_col
    [coff,status] = l1_ls(D, patch1(:,i), lambda); % learn the sparse cofficents for each patch
    cofficents(:,i)=coff;           
end