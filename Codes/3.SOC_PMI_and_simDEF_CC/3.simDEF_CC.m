addpath('../../Matrices/')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Load MEDLINE first order and CC definition matrices
load First_Order_Matrix.mtrx;	%%%  WARNING: make sure your matrix is for MATLAB not R
FOC = spconvert(First_Order_Matrix);
FOC = FOC + FOC'; % Converts a bigram matrix to a co-occurrence matrix

load CC_Definition_Matrix.mtrx;	%%%  WARNING: make sure your matrix is for MATLAB not R
CC_DEF = spconvert(CC_Definition_Matrix);
%%% Initial matrices are loaded now!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Here we start to build SOC matrix for CC
SOC = CC_DEF*FOC;
a = sum(CC_DEF,2);
a = 1./a;
n = length(a);
D = spdiags(a(:),0,n,n);
SOC = D*SOC;
SOC = SOC(:,find(sum(SOC,1)~=0));
clear D n a FOC CC_DEF;
%%% Now we have SOC matrix for CC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Here we apply PMI on CC SOC matrix
PMI_on_SOC = PMI(SOC);
clear SOC;
%%% PMI applied on CC SOC matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Applying cut-off threshold to find better features
DOWN_CUT = 0;	%%% change this value for differet cutt-off points from down
TOP_CUT = 100;	%%% change this value for differet cutt-off points from top
PMI_on_SOC(PMI_on_SOC < DOWN_CUT) = 0;
PMI_on_SOC(TOP_CUT < PMI_on_SOC) = 0;
PMI_on_SOC = PMI_on_SOC(:,find(sum(PMI_on_SOC,1)~=0));
%%% Cut-off applied on the CC PMI_on_SOC matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Compute semantic similarity of CC GO terms (cosine similarity)
PMI_on_SOC = MatrixNorm(PMI_on_SOC);
simDEF = PMI_on_SOC*PMI_on_SOC'; %%% Now we have semantic similarity of CC GO terms
%%% simDEF is now ready to be used or examined
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exit