% demo
% 
% please note that:
% 1 In this experiment, the size of images is 32*32 ;
% 2 the experiment result is affected by the paramter: per and Namana. 
% 3 It takes a long time to learn the dictionray. If you want to run the expriment for many times, the same dictionray can be used.
%%
% Image_row_NUM;Image_column_NUM;                        % size of images 
% NN=Image_row_NUM*Image_column_NUM;                     % dimenison of examples
% Class_Sample_NUM                                       % number of images per class 
% Class_Train_NUM                                        % number of images per class for training data
% Class_Test_NUM                                         % number of images per class for test data
% Class_NUM                                              % number of classes
% Train_NUM                                              % number of examples for training
% Test_NUM                                               % number of examples for testing
% Eigen_NUM                                              % number of dimensions for PCA 
% Disc_NUM                                               % number of dimensions for further subspace learning
% pm                                                     % overlap between two patches 
% ps                                                     % size of one patch(ps*ps)
% par.ncol                                               % size of dictionary
% patch_row=(Image_row_NUM-pm)/pm;                       % number of patches per row 
% patch_col=(Image_column_NUM-pm)/pm;                    % number of patches per column 
% Dim_Begin; Dim_End; Dim_Interval;                      % 
% Dim_Total_NUM=(Dim_End-Dim_Begin)/Dim_Interval+1;      % 
% per                                                    % the percentage of LDP(less discriminative part)
% Namana                                                 % 
%% YaleB
clear all
close all
load demo_yaleb
per=0.1;
Namana=1;
USCP;
fprintf('%7.3f',Recognition_rate);
 
clear all
close all
load demo_yaleb
per=0.2;
Namana=0.6;                    % 
SSCP;
fprintf('%7.3f',Recognition_rate);


% AR
clear all
close all
load demo_ar 
per=0.2;
Namana=1;
USCP;
fprintf('%7.3f',Recognition_rate);

clear all
close all
load demo_ar
per=0.2;
Namana=0.4;
SSCP;
fprintf('%7.3f',Recognition_rate);


%% The dictionary 'D' is previously learned and saved in the demo data. The experiment can be run faster.
%  YaleB(the dictionary has been learned and saved in the data' demo_yaleb ')
clear all
close all
load demo_yaleb
per=0.1;
Namana=1;
USCP_demo;
fprintf('%7.3f',Recognition_rate);
 
clear all
close all
load demo_yaleb
per=0.2;
Namana=0.6;                    % 
SSCP_demo;
fprintf('%7.3f',Recognition_rate);


% AR(the dictionary has been learned and saved in the data' demo_ar ')

clear all
close all
load demo_ar 
per=0.2;
Namana=1;
USCP_demo;
fprintf('%7.3f',Recognition_rate);

clear all
close all
load demo_ar
per=0.2;
Namana=0.4;
SSCP_demo;
fprintf('%7.3f',Recognition_rate);