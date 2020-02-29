function  [Projection_Matrix] =learnmatrixpsupervised(Train_DAT_1,Train_DAT_2,Train_NUM,Namana,Class_NUM,NN,Eigen_NUM,Disc_NUM)

%% learn the pca matrix 
Mean_Image_1=mean(Train_DAT_1,2);
Train_DAT_1=Train_DAT_1-repmat(Mean_Image_1,[1,Train_NUM]); 
Mean_Image_2=mean(Train_DAT_2,2);
Train_DAT_2=Train_DAT_2-repmat(Mean_Image_2,[1,Train_NUM]); 

St_1=Train_DAT_1*Train_DAT_1'/(Train_NUM-1);   % the global scatter matrix of MDP
St_2=Train_DAT_2*Train_DAT_2'/(Train_NUM-1);   % the global scatter matrix of LDP
St_Total=St_1+St_2;                            % the global scatter matrix   
[disc_set_1]=Find_K_Max_Eigen(St_Total,Eigen_NUM); % get the pca projection matrix 

%% Construct the between-class scatter matrix based on Train_DAT_1 (stable):
% to evaluate class_mean
dim=NN; % the dimension of the column of the Train_SET
SN=Train_NUM/Class_NUM; % SN denote the sample number per class

k=1;
class_mean=zeros(dim,Class_NUM);
for s=1:Class_NUM
    temp=class_mean(:,s);
    for t=1:SN
      temp=temp+Train_DAT_1(:,k);
      k=k+1;
   end
   class_mean(:,s)=temp/SN;
end
% to evaluate Sb
S=zeros(dim,dim);
total_mean=Mean_Image_1;
for t=1:Class_NUM
   V=class_mean(:,t)-total_mean;
   S=S+V*V';
end
Sb=S/Class_NUM;

%% construct the within-class scatter matrix based on Train_DAT_1 (stable):
% to evaluate Sw
S=zeros(dim,dim);
k=1;
for s=1:Class_NUM
    temp=class_mean(:,s);
    for t=1:SN
      V=Train_DAT_1(:,k)-temp;
      S=S+V*V';
      k=k+1;
   end
end
Sw=S/Train_NUM;

%% learn the final projection matrix 
St_Total1=Namana*Sw+(1-Namana)*St_2;  % the scatter matrix to minimize 
Sb_Transformed=disc_set_1'*Sb*disc_set_1;  % the scatter matrix to maximize 
St_Total1_Transformed=disc_set_1'*St_Total1*disc_set_1;
St_Total_Transformed=St_Total1_Transformed+0.001*eye(Eigen_NUM,Eigen_NUM)*trace(St_Total1_Transformed);
[disc_set_2]=Find_K_Max_Gen_Eigen(Sb_Transformed,St_Total_Transformed,Disc_NUM);
disc_set=disc_set_1*disc_set_2;
Projection_Matrix=disc_set;
