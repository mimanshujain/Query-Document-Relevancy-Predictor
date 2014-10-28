%Stochastic Gradient.
clc;
t2 = clock;
for M = 9:9
%fetching the data
fname = sprintf('PhiData_M=%d',M);
load(fname,'test', 'valid','validLen' ,'validOut' , 'testOut', 'testLen');

fname1 = sprintf('StocData=%d',M);
load(fname1,'ErmsStoc');

% learningRate = transpose(.01:.01:1);
learningRate = 0.41;
%Assuming weights initially 0.5
Wold(1:size(test,2),1) = 0.5;

%Initializing
k = 1;
%Calculating Initial Error
ErrorOld = sqrt((2/size(validLen,1)) * sum(0.5*((validOut - valid*Wold).^2)));

for i = 1:length(learningRate)
    n = 0;
    m = 0;

    while n > -1
    n = n+1;
	Wnew = Wold + learningRate(i) * transpose(test(n,:))*(testOut(n , : ) - test(n,:) * Wold);

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

ErmsTestStoc = ErrorNew;

end

StocErrorDiff = ErmsTestStoc - ErmsStoc;
fprintf('Total Error difference in Gradient Descent:: %s\n',num2str(StocErrorDiff));

timeTaken = round(etime(clock,t2) * 1000)/60000;
fprintf('Total Time in StocTest:: %s\n',num2str(timeTaken));

ubitName = 'mimanshu';
ubNum = 50133318;
learningRate = 0.41;

fprintf('My ubit name is %s\n',ubitName);
fprintf('My student number is %d \n',ubNum);
fprintf('the model complexity M cfs is %d\n', model);
fprintf('the model complexity M gd is %d\n', M);
fprintf('the regularization parameters lambda cfs is %4.5f\n', lambda);
fprintf('the regularization parameters lambda gd is %4.2f\n', learningRate);
fprintf('the root mean square error for the closed form solution is %4.2f\n', ErmsTest);
fprintf('the root mean square error for the gradient descent method is %4.2f\n', ErmsTestStoc);


%Below in the plotting codes used. Kept Commented Intentionally

%------------------------------------------------------------------ 
%For plot between Erms vs M

% Erms1 = double(ones(46000,1));
% M = zeros(46000,1);
% lam = zeros(46000,1);
% n = 1;
% for i = 5:50
%    fname = sprintf('ParaHyperPara=%d',i);
%    load(fname,'Erms' , 'lambda');
%    Erms1(n:n+999,1) = Erms;
%    M(n:n+999,1) = i;
%    lam(n:n+999,1) = lambda;
%    n = n + 1000;
% end
% 
% mini = min(Erms1);
% figure;
% plot(M,Erms1);
% hold on
% plot(mini,'m.')
% line(get(gca,'Xlim'),[min(Erms1) min(Erms1)])

% %------------------------------------------------------------------ 
% %For plot between Erms vs S
% Erms1 = double(ones(10000,1));
% s = double(zeros(10000,1));
% n=1;
% for i = 1:10
%    fname = sprintf('Para_s=%d',i);
%    load(fname,'Erms');
%    Erms1(n:n+999,1) = Erms;
%    s(n:n+999,1) = i/10;
%    n = n + 1000;
% end
% 
% % plot(s,Erms1);
% % mini = min(Erms1);
% [minimunErr, minIndex] = min(Erms1);
% figure;
% plot(s,Erms1);
% hold on
% % line(get(gca,'Xlim'),[min(Erms1) min(Erms1)])
% legend(strcat('Min = ',num2str(minimunErr),', minimumS = ',num2str(Erms1(minIndex))));

% % ----------------------------------------------------------------- 
% % For plot between StocErms vs M
% Erms = double(ones(4600,1));
% M = zeros(4600,1);
% n=1;
% for i = 5:50
%     fname = sprintf('StocData=%d',i);
%     load(fname,'ErmsStoc');
%     M(n:n+99,1) = i;
%     Erms(n:n+99,1) = ErmsStoc;
%     n = n + 100;
% end

% figure % create new figure
% [minimunErr, minIndex] = min(Erms);
% plot(log(lambda),Erms);
% hold on
% plot(lambda,Erms);
% legend(strcat('Min = ',num2str(minimunErr),', minimumS = ',num2str(Erms(minIndex))));
% line(get(gca,'Xlim'),[min(Erms) min(Erms)])
% 
% figure % create new figure
% subplot(2,2,1) % first subplot
% plot(log(lambda),Erms);
% subplot(2,2,2) % second subplot
% plot(lambda,Erms);

% % ----------------------------------------------------------------- 
% % For plot between StocErms vs Alpha
% figure % create new figure
% load StocData=9
% [minimunErr, minIndex] = min(ErmsStoc);
% learningRate = transpose(.01:.01:1);
% plot(learningRate,ErmsStoc);
% % plot(log(lambda),Erms);
% legend(strcat('Min = ',num2str(minimunErr),', minimumS = ',num2str(Erms(minIndex))));
% % line(get(gca,'Xlim'),[min(Erms) min(Erms)])

% % ----------------------------------------------------------------- 
% % For plot between StocErms vs M vs Alpha
% Erms = double(ones(4600,1));
% M = zeros(4600,1);
% alpha = zeros(4600,1);
% n=1;
% for i = 5:50
%     fname = sprintf('StocData=%d',i);
%     load(fname,'ErmsStoc');
%     M(n:n+99,1) = i;
%     Erms(n:n+99,1) = ErmsStoc;
%     alpha(n:n+99,1) = transpose(.01:.01:1);
%     n = n + 100;
% end
% 
% % [alpha,Erms] = meshgrid(0.01:.01:1,0.01:.1:3);
% % z = peaks(alpha,M);
% % 
% % figure
% % ribbon(Erms,z)
% plot3(M,alpha,Erms);

