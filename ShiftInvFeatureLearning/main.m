clc;clear;close all;

%%
% In this code, we compute a dictionary D of shift-invariant features from a given dataset X.
% X is a m-by-N matrix of data points where each data point is of m-by-1 dimension.
% D is a d-by-n matrix of features where each feature is of d-by-1 dimension (d<m).
% numKernels, dimKernel, maxiteration and iterations are the parameters of the algorithm needs to be chosen by user.   
% iterations is the sparsity constraint. iterations=1, makes the sparse coding equivalent to clustering.

% Code written by: Masoumeh Heidari Kapourchali (PhD student), University of Memphis, October-November 2015.
% Adviser: Bonny Banerjee, Ph.D.
%
% Citation: M. H. Kapourchali and B. Banerjee. (2018) "Unsupervised feature learning from time-series data using linear models", IEEE Internet of Things Journal, Vol. 5, Issue 5, pp. 3918-3926.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
load test %  Loading a sample dataset of puretones with f \in {10 20 30 40 50},FS=1000 
X=s; % Each column is a datapoint
% for i=1:size(TRAIN,2)
%     TRAIN(:,i)=normc(TRAIN(:,i)-mean(TRAIN(:,i)));
% end
numSamples=size(X,2);

%%
%%%%% Initialize parameters
Iteration=1;
maxiteration = 50;% 3e+2;    % maximum number of iterations the code should be run
winlen=size(X,1); % Dimansion of data
meanValue=zeros(winlen,1);
count=0;
numKernels = 20;       % Number of features
dimKernel = 100;        % Dimansion of features 
D=normc(ones(dimKernel,numKernels)); % Initializing the dictionary
alpha = 0.1; % Learning rate
min_alpha = 1e-3; % Minimum learning rate
kernelCounter=zeros(numKernels,1); % To check how much each feature is activated

%%% Sparsity constraint (iterations of matching pursuit), iterations=1 makes the sparse coding equivalent to clustering.
iterations=1; %ceil(0.2*numKernels); 

%% Main code
for Iteration = Iteration:maxiteration
    Iteration
%     erCounter=0;
    for ii =1:numSamples
        %%% zeropadding for the case dimKernel==winlen
%         x = normc([zeros(10,1); TRAIN(:,ii); zeros(10,1)]- mean([zeros(10,1); TRAIN(:,ii); zeros(10,1)]));
        x=normc(X(:,ii)-mean(X(:,ii)));
        count = count+1;
        if mod(count,1e6*numKernels)==0 % Decreasing learning rate over time
            alpha = max(alpha/(1+alpha), min_alpha);
        end             
        [coefficients, shift, residual, kernelNumbers]=CorrelationalMP(x,D,iterations);
        
        %%% To get the error for each datapoint
%         erCounter=erCounter+1;
%         ErrL2(erCounter) = 100*(norm(residual));
        for i=1:iterations
            windowR=residual(shift(i)+1:shift(i)+dimKernel);
            D(:,kernelNumbers(i))=normc(D(:,kernelNumbers(i))+alpha*windowR*coefficients(i));
            kernelCounter(kernelNumbers(i))=kernelCounter(kernelNumbers(i))+abs(coefficients(i)); 
        end
    end
end
   %%% Add if you want. Keeps only the learned features
%     D=D(:,find(kernelCounter>0.1*median(kernelCounter))); 

    save('results')
