function [C,lags] = myxcorr(s1,s2)

% This function computes the cross correlation  by shifting the
% shorter length signal over the longer length signal. It assumes, s1 is
% of shorter (or equal) length than s2. If that assumption is not valid,
% the function will swap s1 and s2.
% Outputs: 
% C: correlation vector, stores dot product for each shift of s1
% lags: location vector, same size as C
%
% Code written by: Masoumeh Heidari Kapourchali (PhD student), University of Memphis, October-November 2015.
% Adviser: Bonny Banerjee, Ph.D.
%
% Citation: M. H. Kapourchali and B. Banerjee. (2018) "Unsupervised feature learning from time-series data using linear models", IEEE Internet of Things Journal, Vol. 5, Issue 5, pp. 3918-3926.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L1 = length(s1);
L2 = length(s2);
if L1>L2
    temp = s2;
    s2 = s1;
    s1 = temp;
end

lags = 0:L2-L1;
C = zeros(1,L2-L1+1);
for loc=lags+1 
    C(loc) = sum(s1 .* s2(loc:loc+L1-1)); 
end
end


