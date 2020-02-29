function Miss_NUM=Classifier_NN_f(Train_DAT,Test_DAT,Distance_mark)

% NN classifier function;
%Distance_mark           :   ['Euclidean', 'L2'| 'L1' | 'Cos']

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 2, 
    error('Not enought arguments!'); 
elseif nargin < 3
    Distance_mark='L2'; 
end
%Note: NARGIN Number of function input arguments.
% When it is inside the body of a user-defined function, NARGIN returns the number of input arguments that were used to call the function.

[DIM, Class_Train_NUM, Class_NUM]=size(Train_DAT);
[DIM, Class_Test_NUM, Class_NUM]=size(Test_DAT);


% classification
Miss_NUM=0;

for k=1:Class_NUM
   for m=1:Class_Test_NUM 
    
    Test=Test_DAT(:,m,k);
    
    min_dist=1e+30;
    for t=1:Class_NUM
      for s=1:Class_Train_NUM 
         Train=Train_DAT(:,s,t);
         V=Test-Train;
         
         switch Distance_mark
         case {'Euclidean', 'L2'}
              dist=norm(V,2); % Euclead (L2) distance
         case 'L1'
              dist=norm(V,1); % L1 distance
         case 'Cos'
             dist=acos(Test'*Train/(norm(Test,2)*norm(Train,2)));     % cos distance
         otherwise
              dist=norm(V,2); % Default distance
         end

        if min_dist>dist
          min_dist=dist;
          Class_No=t;
       end
      end
    end
    if Class_No~=k % strncmp is to compare the first n characters of two strings
        Miss_NUM=Miss_NUM+1;
    end
    
   end
 end

