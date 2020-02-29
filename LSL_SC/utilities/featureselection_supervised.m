function feature_variance=featureselection_supervised(parncol,patch_col,cofficents, D,Class_Train_NUM,Class_NUM,Train_NUM,patchsize)
par.ncol=parncol;
a=[];
for i=1:Class_Train_NUM   
    a((Class_NUM*(i-1)+1):Class_NUM*i,1)=i;
 end
for i=1:par.ncol
    coff_temp=zeros(par.ncol,patch_col);
    coff_temp(i,:)=cofficents(i,:);
    CM=D*coff_temp;
    MC=reshape(CM,[patchsize,Train_NUM]);
    CMD=reshape(MC,[patchsize,Class_Train_NUM,Class_NUM]);
    class_mean=mean(CMD,2);
    Wv=sum(sum((CMD-repmat(class_mean,[1,Class_Train_NUM])).^2,1),3);  % within class viarance
    overall_mean=mean(class_mean,3);
    Bv=sum((class_mean-repmat(overall_mean,[1,1,Class_NUM])).^2,3);  % between class viarance
    Wv=Wv+1e-16;
    Dv=sum(Bv)/sum(Wv);
    feature_variance(i)=Dv;  
end