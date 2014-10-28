load project1_data.mat
t0 = clock;
clc

%Assuming Deviation-------------------------------------------------------------------------------------------------------
s = 0.6;
lambda = transpose(.0001:.0001:.1);
% s = transpose(0.1:0.1:1);

%Since we have decided out s value. Hence only once loop will iterate. For
%training more, uncomment the above s matrix generattion code at line 9.
for noOfCov = 1:1

%-------------------------------------------------------------------------------------------------------------------------
%Creating the design Matrix
    for model = 49 : 49
    mean = datasample(In, model);
    PhiTemp = ones(size(In,1), size(mean,1));
    for M = 1 : size(mean,1)
        for n = 1:size(In,1)
            X = In(n , :);
            Mu = mean(M , :);
            diff = X - Mu;
            firtTerm = diff/s(noOfCov)*s(noOfCov);
            val = -0.5 .* ((firtTerm) * transpose(diff));
            PhiTemp(n , M) = exp (val);
        end
    end
    %Creating the Phi Matrix with coeff of first w as 1
    Phi = [ones(size(PhiTemp,1),1) PhiTemp];
    
    %Diving the Design Matrix
    trainLen = round(0.8*data_len);
    train = double(Phi(1:trainLen,:));
    trainOut = double(Out(1:trainLen,:));

    validLen = round((data_len-trainLen)/2);
    valid = double(Phi(trainLen+1:trainLen+validLen,:));
    validOut = double(Out(trainLen+1:trainLen+validLen,:));

    testLen = data_len-trainLen-validLen;
    test = double(Phi(trainLen+validLen+1:trainLen+validLen+testLen,:));
    testOut = double(Out(trainLen+validLen+1:trainLen+validLen+testLen,:));
    
    %Saving the data of design Matrix
    fname = sprintf('PhiData_M=%d.mat', model);
    save(fname, 'train', 'trainLen', 'trainOut', 'valid', 'validLen', 'validOut', 'test', 'testLen', 'testOut', 'Phi');
    
    %-------------------------------------------------------------------------------------------------------------------------
    %Learning starts from here. Using the training set
    lambda = transpose(.0001:.0001:.1);
    Erms = ones(length(lambda),1);
    for n = 1:length(lambda) 
    
    %Calculating the weights Parameters here using the training set  
    w = ((lambda(n) * eye(size(train,2)) + (transpose(train) * train)) \ transpose(train) * trainOut);

    %Calculating Regularized Square Error--------------------------------------------------------------------------------------------
    err1 = sum(0.5*((validOut - valid*w).^2));
    err_lasso =  (lambda(n) * 0.5 * sum(w));
    err_quad = (lambda(n) * 0.5 * sum(transpose(w)*w));

    Total_Err_Lasso = err1 + err_lasso;
    Total_Err_Quad = err1 + err_quad;

    %Calculating RMS Error----------------------------------------------------------------------------------------------------------
    Erms(n , : ) = sqrt((2/validLen) * Total_Err_Quad);
    end
    
    %Calculating the Relevency Score for Training Set
    relevencyScores = Phi * w;
    
    %Plotting the final Error vs Lambda graph--------------------------------------------------------------------------------------
    figure % create new figure
    subplot(2,2,1) % first subplot
    title('First subplot')
    plot(lambda,Erms);
    subplot(2,2,2) % second subplot
    title('Second subplot')
    plot(log(lambda),Erms);
    
    fname2 = sprintf('ParameterValues');
    save(fname2,'lambda' ,'w', 'Total_Err_Lasso' ,'Total_Err_Quad', 'Erms', 'mean' ,'s', 'relevencyScores') ;
    end
end
ms2 = round(etime(clock,t0) * 1000)/60000;
fprintf('Total Time:: %s\n',num2str(ms2));

finalTrainError = 0.5378 ;




