%Stochastic Gradient.
clc;
t2 = clock;
for M = 9:9
%fetching the data
fname = sprintf('PhiData_M=%d',M);
load(fname,'train', 'valid','validLen' ,'validOut' , 'trainOut');

% learningRate = transpose(.01:.01:1);
learningRate = 0.41;
%Assuming weights initially 0.5
Wold(1:size(train,2),1) = 0.5;

%Initializing
ErmsStoc = ones(length(learningRate),1);
k = 1;
%Calculating Initial Error
ErrorOld = sqrt((2/size(validLen,1)) * sum(0.5*((validOut - valid*Wold).^2)));

for i = 1:length(learningRate)
    n = 0;
    m = 0;

    while n > -1
    n = n+1;
	Wnew = Wold + learningRate(i) * transpose(train(n,:))*(trainOut(n , : ) - train(n,:) * Wold);

	err1 = sum(0.5*((validOut - valid*Wnew).^2));
	
% 	%Calculating RMS Error------------------------------------------------------------------------------
	ErrorNew = sqrt((2/validLen) * err1);
	ErrorDiff = ErrorOld - ErrorNew;
    
    %Breaking Condition-----------------------------------------------------------------------------
    if ErrorDiff < ErrorNew/100
       break;
    end
 
    Wold = Wnew;
	ErrorOld = ErrorNew;
    
    end
end

ErrorStoc = ErrorNew;

fname = sprintf('StocData=%d',M);
save(fname,'ErmsStoc')

end

timeTaken = round(etime(clock,t2) * 1000)/60000;
fprintf('Total Time:: %s\n',num2str(timeTaken));
