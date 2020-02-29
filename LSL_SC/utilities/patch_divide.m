
% divide each image into patches 
Train_DAT=reshape(Train_DAT,[Image_row_NUM*Image_row_NUM,Train_NUM]);
Test_DAT=reshape(Test_DAT,[Image_row_NUM*Image_row_NUM,Test_NUM]);
Train_DAT        =    Train_DAT./ repmat(sqrt(sum(Train_DAT.*Train_DAT)),[size(Train_DAT,1) 1]); % unit norm 2
Test_DAT        =    Test_DAT./ repmat(sqrt(sum(Test_DAT.*Test_DAT)),[size(Test_DAT,1) 1]); % unit norm 2

Train_DAT=reshape(Train_DAT,[Image_row_NUM,Image_row_NUM,Train_NUM]);
Test_DAT=reshape(Test_DAT,[Image_row_NUM,Image_row_NUM,Test_NUM]);

s=1;
patch1=[];
patch_number=patch_row*patch_col; % number of patches per image 
S_mem=[];
for k=1:Train_NUM
  for i=1:patch_row
    for j=1:patch_col  
      c=[];
      s=(k-1)*patch_number+patch_row*(i-1)+j;
      S_mem(s,:)=[i,j,k];
      C1= Train_DAT((pm*(i-1)+1):(pm*i+pm),(pm*(j-1)+1):(pm*j+pm),k);  %patch
      patch1(:,s)=reshape(C1,[ps*ps,1]);
    end
  end
end
