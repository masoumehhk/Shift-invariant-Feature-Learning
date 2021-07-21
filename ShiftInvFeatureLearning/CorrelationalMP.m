function [coef, lagValue, R, kernelNumbers]=correlationalMP(x, D, iterations)

%%
% This function is a shift-invariant version of matching pursuit. 
% In this code, we compute the activity of features, their shift, residual and the active feature for a given signal using a dictionary D.
% x is a m-by-1 signal.
% D is a d-by-n matrix of features where each feature is of d-by-1 dimension (d<m).
% iterations is the sparcity constraint.
% coef is the activation of each feature in kernelNumbers. lagValue is the corresponding shift. R is the residual.
% 
% Code written by: Masoumeh Heidari Kapourchali (PhD student), University of Memphis, October-November 2015.
% Adviser: Bonny Banerjee, Ph.D.
%
% Citation: M. H. Kapourchali and B. Banerjee. (2018) "Unsupervised feature learning from time-series data using linear models", IEEE Internet of Things Journal, Vol. 5, Issue 5, pp. 3918-3926.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R=x;
N = length(x);
[dimKernel numKernels]=size(D);
kernelNumbers=zeros(1,iterations-1);
coef=zeros(1,iterations-1);
lagValue=zeros(1,iterations-1);
D=normc(D);
for j=1:iterations % iterations of matching pursuit
    for i=1:numKernels
        [validCorSig, validLags] = Xcorr(D(:,i),R); %cross correlation
        [maximumValue(i),ind] = max(abs(validCorSig)); %maximum absolute value of cross correlation
        lag(i) = validLags(ind); % storing the shift of maximum value of cross correlation
        actualValue(i) = validCorSig(ind); % actual value of coefficient
    end
    [~, kernelNumbers(j)] = max(maximumValue); % which kernel has the maxmium correlation
    lagValue(j) = lag(kernelNumbers(j)); % where the kernel matched with the signal
    coef(j) = actualValue(kernelNumbers(j));
    R(lagValue(j)+1:lagValue(j)+dimKernel)= R(lagValue(j)+1:lagValue(j)+dimKernel)-coef(j)*D(:,kernelNumbers(j)); % main rule of matching pursuit 
end
end
