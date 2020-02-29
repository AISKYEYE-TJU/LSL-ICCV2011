function  [Projection_Matrix] =learnmatrixpunsupervised(Train_DAT_1,Train_DAT_2,Train_NUM,Namana,Class_NUM,NN,Eigen_NUM,Disc_NUM)

%===================learn the matrxi p=====================================
Mean_Image_1=mean(Train_DAT_1,2);
Train_DAT_1=Train_DAT_1-repmat(Mean_Image_1,[1,Train_NUM]); 
Mean_Image_2=mean(Train_DAT_2,2);
Train_DAT_2=Train_DAT_2-repmat(Mean_Image_2,[1,Train_NUM]); 

St_1=Train_DAT_1*Train_DAT_1'/(Train_NUM-1);
St_2=Train_DAT_2*Train_DAT_2'/(Train_NUM-1);
St_Total=St_1+St_2;                            %  why not substract
[disc_set_1,disc_value_1]=Find_K_Max_Eigen(St_Total,Eigen_NUM);
St_1_Transformed=disc_set_1'*St_1*disc_set_1;
St_2_Transformed=disc_set_1'*St_2*disc_set_1;
 % Namana=0 represents using PCA alone on the stable features
St_2_Transformed=Namana*St_2_Transformed+0.001*eye(Eigen_NUM,Eigen_NUM)*trace(St_2_Transformed);
[disc_set_2,disc_value]=Find_K_Max_Gen_Eigen(St_1_Transformed,St_2_Transformed,Disc_NUM);
disc_set=disc_set_1*disc_set_2;


Projection_Matrix=disc_set;
