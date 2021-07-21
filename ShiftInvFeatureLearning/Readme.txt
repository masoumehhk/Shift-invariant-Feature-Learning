Overview
===========
This package provides the source code for feature learning using shift-invariant clustering and shift-invariant sparse coding.

Included
==========
main.m: The main code for feature learning

CorrelationalMP.m: Shift invariant version of matching pursuit

Xcorr.m: cross corelation

test.mat: A sample dataset (smaller version of what is used in Fig. 3. of the paper) 

results.mat: The results for running the code using test.mat 

Citation
==========
M. H. Kapourchali and B. Banerjee. (2018) "Unsupervised feature learning from time-series data using linear models",
IEEE Internet of Things Journal, Vol. 5, Issue 5, pp. 3918-3926.

@article{kapourchali2018unsupervised,
  title={Unsupervised Feature Learning From Time-Series Data Using Linear Models},
  author={Kapourchali, Masoumeh Heidari and Banerjee, Bonny},
  journal={IEEE Internet of Things Journal},
  volume={5},
  number={5},
  pages={3918--3926},
  year={2018},
  publisher={IEEE}
}

******************************************
To run the main.m, you need to load your dataset X which is a m-by-N matrix of data points where each data point is of m-by-1 dimension.

numKernels, dimKernel, maxiteration and iterations are the parameters of the algorithm needs to be chosen by user.


numKernels is the number of features you want to learn.

dimKernel is dimension of each feature (dimKernel<m)

maxiteration is the maximum number of iterations you want the code to be run. 
   
iterations is the parameter for sparsity constraint (refers to iterations in the matching pursuit). 
Setting iterations=1, makes the sparse coding equivalent to clustering. 
