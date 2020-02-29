
%=================divide traning data into patches=========================
patch_divide;
%=================dictionary learning and sparse coding====================
[D,cofficents]=dlsc_demo(patch1,par.ncol,patch1,D);
%===================feature selection======================================
[patch_row1,patch_col1]=size(patch1);
feature_variance=featureselection_unsupervised(par.ncol,patch_col1,cofficents, D,Class_Train_NUM,Class_NUM,Train_NUM,patch_row1*patch_number);
% ================================decomposition============================
[a,ind]=sort(feature_variance);
coff_temp1=zeros(par.ncol,patch_col1);
coff_temp2=zeros(par.ncol,patch_col1);
temp=round(length(ind)*per);%
coff_temp1(ind((1+temp):par.ncol),:)=cofficents(ind((1+temp):par.ncol),:);
coff_temp2(ind(1:temp),:)=cofficents(ind(1:temp),:);
Train_DAT_1=D*coff_temp1;%stable
Train_DAT_2=D*coff_temp2;%unstable

temp=ones(ps,ps);
num_average=zeros(Image_row_NUM,Image_column_NUM,Train_NUM);
Train_DAT1=zeros(Image_row_NUM,Image_column_NUM,Train_NUM);
Train_DAT2=zeros(Image_row_NUM,Image_column_NUM,Train_NUM);
for g=1:patch_col1
      i=S_mem(g,1);
      j=S_mem(g,2);
      k=S_mem(g,3);
      C1=reshape(Train_DAT_1(:,g),[ps,ps]);
      C2=reshape(Train_DAT_2(:,g),[ps,ps]);
      Train_DAT1((pm*(i-1)+1):(pm*i+pm),(pm*(j-1)+1):(pm*j+pm),k)=Train_DAT1((pm*(i-1)+1):(pm*i+pm),(pm*(j-1)+1):(pm*j+pm),k)+C1;  %patch
      Train_DAT2((pm*(i-1)+1):(pm*i+pm),(pm*(j-1)+1):(pm*j+pm),k)=Train_DAT2((pm*(i-1)+1):(pm*i+pm),(pm*(j-1)+1):(pm*j+pm),k)+C2;  %patch
      num_average((pm*(i-1)+1):(pm*i+pm),(pm*(j-1)+1):(pm*j+pm),k)=num_average((pm*(i-1)+1):(pm*i+pm),(pm*(j-1)+1):(pm*j+pm),k)+temp;% %patch
end

Train_DAT1=Train_DAT1./num_average;
Train_DAT2=Train_DAT2./num_average;
Train_DAT_1=reshape(Train_DAT1,[NN,Train_NUM]);
Train_DAT_2=reshape(Train_DAT2,[NN,Train_NUM]);

% ================================learn the matrix============================
[Projection_Matrix] =learnmatrixpunsupervised(Train_DAT_1,Train_DAT_2,Train_NUM,Namana,Class_NUM,NN,Eigen_NUM,Disc_NUM);
Train_DAT=reshape(Train_DAT,[NN,Train_NUM]);
Test_DAT=reshape(Test_DAT,[NN,Test_NUM]);   
Train_SET=Projection_Matrix'*Train_DAT; % size of (Disc_NUM,Train_NUM); 
Test_SET=Projection_Matrix'*Test_DAT;   % size of (Disc_NUM,Test_NUM); 
Mean_Image=mean(Train_SET,2);  
Train_SET=Train_SET-Mean_Image*ones(1,Train_NUM);
Test_SET=Test_SET-Mean_Image*ones(1,Test_NUM);

for s=1:Train_NUM
    Train_SET(:,s)=Train_SET(:,s)/norm(Train_SET(:,s));
end
for s=1:Test_NUM
    Test_SET(:,s)=Test_SET(:,s)/norm(Test_SET(:,s));
end
%===================classification using NN classifier=====================

Train_SET=reshape(Train_SET,[Disc_NUM,Class_Train_NUM,Class_NUM]);
Test_SET=reshape(Test_SET,[Disc_NUM,Class_Test_NUM,Class_NUM]);
K=2;
i=0;
Distance_mark='L2';   %Distance_mark['Euclidean', 'L2'| 'L1' | 'Cos'] 
Recognition_rate=[];
for Select_DIM=Dim_Begin:Dim_Interval:Dim_End        % N is the total number of features
  Miss_NUM=Classifier_NN_f(Train_SET(1:Select_DIM,:,:),Test_SET(1:Select_DIM,:,:),Distance_mark);
  i=i+1;
  Recognition_rate(i)=(Test_NUM-Miss_NUM)/Test_NUM;
end
