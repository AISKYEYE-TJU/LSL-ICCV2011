function feature_variance=featureselection_unsupervised(parncol,patch_col,cofficents, D,Class_Train_NUM,Class_NUM,Train_NUM,patch_whole)
par.ncol=parncol;
a=[];
for i=1:Class_Train_NUM   
    a((Class_NUM*(i-1)+1):Class_NUM*i,1)=i;
end
for i=1:par.ncol
    coff_temp=zeros(par.ncol,patch_col);
    coff_temp(i,:)=cofficents(i,:);
    CM=D*coff_temp;
    MC=reshape(CM,[patch_whole,Train_NUM]);
    STD_MC=std(MC');                   %unsupervised feature selection
    feature_variance(i)=sum(STD_MC); 
end