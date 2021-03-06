setwd('../../Matrices/')

install.packages("Matrix")
library(Matrix)

######################################
############ PMI Function ############
PMI<-function(x){
	m <- log10(Matrix(1, dim(x)[1], dim(x)[2]))+log10((rowSums(x)+ dim(x)[2]))
	cat("Done with the rows add\n")

	n <- t(log10(t(Matrix(1, dim(x)[1], dim(x)[2])))+log10((colSums(x)+ dim(x)[1])))
	cat("Done with the columns add\n")

	pmi<-log10(((x+1)*(sum(x)+dim(x)[1]*dim(x)[2])))-(m+n)
	return(pmi)
}
######################################


######################################
##### Matrix Normalizer Function #####
MatrixNorm<-function(m){
	m_rs <- 1/(sqrt(rowSums(m*m)))
	v <- Diagonal(n= length(m_rs), m_rs)
	out <- v%*%m
	return(out)
}
######################################


######################################
### Load MEDLINE first order and CC definition matrices
FOC <- readMM(file='First_Order_Matrix.mtrx') ###  WARNING: make sure your matrix is for R not MATLAB
FOC <- FOC + t(FOC)	### Converts a bigram matrix to a co-occurrence matrix

CC_DEF <- readMM(file='CC_Definition_Matrix.mtrx') ###  WARNING: make sure your matrix is for R not MATLAB
### Initial matrices are loaded now!
######################################


######################################
### Here we start to build SOC matrix for CC
SOC <- CC_DEF%*%FOC;
a <- rowSums(M)
a <- 1/a
D <- Diagonal(n= length(a), a)
SOC <- D%*%SOC
SOC <- SOC[,colSums(SOC)!=0]
rm (D, a, FOC, CC_DEF)
### Now we have SOC matrix for CC
######################################


######################################
### Here we apply PMI on CC SOC matrix
PMI_on_SOC <- PMI(SOC)
rm (SOC)
### PMI applied on CC SOC matrix
######################################


######################################
### Applying cut-off threshold to find better features
DOWN_CUT <- 0;	### change this value for differet cutt-off points from down
TOP_CUT <- 100;	### change this value for differet cutt-off points from top
PMI_on_SOC[which(PMI_on_SOC < DOWN_CUT)] <- 0;
PMI_on_SOC[which(TOP_CUT < PMI_on_SOC)] <- 0;
PMI_on_SOC <- PMI_on_SOC[,colSums(PMI_on_SOC)!=0]
### Cut-off applied on the CC PMI_on_SOC matrix
######################################


######################################
### Compute semantic similarity of CC GO terms (cosine similarity)
PMI_on_SOC <- MatrixNorm(PMI_on_SOC)
simDEF <- PMI_on_SOC%*%(t(PMI_on_SOC)) ### Now we have semantic similarity of CC GO terms
### simDEF is now ready to be used or examined
######################################
