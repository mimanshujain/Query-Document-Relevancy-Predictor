model = 49;
fname = sprintf('PhiData_M=%d.mat', model);
load(fname, 'test', 'testLen', 'testOut' ,'Phi' , 'validOut', 'valid', 'validLen');

fname2 = sprintf('ParameterValues');
load(fname2, 'w');

lambda = 0.001;
n = 1;
%-------------------------------------------------------------------------------------------------------------------------
%Testing starts from here. Using the testing set

%Calculating the weights Parameters here using the testing set  
wTest = ((lambda(n) * eye(size(test,2)) + (transpose(test) * test)) \ transpose(test) * testOut);

wDiff = w - wTest;

%Calculating Regularized Square Error--------------------------------------------------------------------------------------------
err1 = sum(0.5*((validOut - valid*wTest).^2));
err_lasso =  (lambda(n) * 0.5 * sum(wTest));
err_quad = (lambda(n) * 0.5 * sum(transpose(wTest)*wTest));

Total_Err_Lasso = err1 + err_lasso;
Total_Err_Quad = err1 + err_quad;

%Calculating RMS Error----------------------------------------------------------------------------------------------------------
ErmsTest = sqrt((2/validLen) * Total_Err_Quad);
ErmsDiff = ErmsTest - finalTrainError;
fprintf('Difference in Error of Test and Train:: %f',ErmsDiff); 
% 
% fprintf('My ubit name is %s\n',ubitName);
% fprintf('My student number is %d \n',ubNum);
% fprintf('the model complexity M cfs is %d\n', model);
% fprintf('the model complexity M gd is %d\n', M);
% fprintf('the regularization parameters lambda cfs is %4.2f\n', lambda);
% fprintf('the regularization parameters lambda gd is %4.2f\n', learningRate);
% fprintf('the root mean square error for the closed form solution is %4.2f\n', ErmsTest);
% fprintf('the root mean square error for the gradient descent method is %4.2f\n', ErmsTestStoc);

