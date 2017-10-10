
# simDEF Instruction

This instruction file attemps to walk you throught different very simple stepts for using simDEF in semantic similarity measurement of GO terms and functional similarity measurement of gene products.

You need to run the provided codes by considering their numerical order. As an example, for simDEF in MF sub-ontology, you should run the scripts in this order to find simDEF of all GO terms in MF:

	1.1.Bigrams_2_Sparse_4_R_preparation.pl
	1.2.Bigrams_2_Sparse_4_R_final.pl	### You may want to reduce the dimension here!
	2.1.MF_Name_Extractor.pl
	2.2.MF_Definition_Extractor.pl
	2.3.MF_Parents_Extractor.pl
	2.4.MF_Children_Extractor.pl
	2.5.MF_Extra_Relationship_Extractor.pl
	2.6.MF_Extended_Definition_Construction.pl	### You may want to try different combinations of GO terms' definition extention
	2.7.MF_Definition_Matrix_Construction_preparation.pl
	2.8.MF_Definition_Matrix_Construction_final.pl
	3.simDEF_MF.m	### You should find best cut-off points in here (you may want to use R script here instead of MATLAB script)

	
Here, we give a guideline for each code/script considering this order.

## A. Building the first order co-occurrence matrix: 

In this section we build the first order co-occurrence matrix (FOC matrix). To do this we need to have access to MEDLINE Abstracts (Download bigrams from: http://mbr.nlm.nih.gov/Download/) as well as our list of stop-words (included in the package)

	- After downloading MEDLINE bigrams, copy that file (i.e. extract the zip file) into the “Extra” directory.
	- In the Code directory, with the perl code “1.1.Bigrams_2_Sparse_4_R_preparation.pl” we make a sparse matrix of sirst order co-occurrence matrix (FOC matrix) for R (Or MATLAB depending on your preference). Later on by summing this bigram matrix to its transpose we would have a co-occurrence matrix. Also here we will assign to each row of this matrix (i.e. each word) an index. These indices would be stored in a separate file which will be used when we want to assign indeces to the words in the definitions of GO terms (index matching).
	- With the perl code “1.2.Bigrams_2_Sparse_4_R_final.pl” we add two needed lines to the beginning of the matrix generated in the previous step. For MATLAB we only need to add the second line so you can comment out the first line in the code if you are going to use MATLAB.

**CAVEATS:** If you are concerned that the dimensions of your GO matrices are going to be large, you can ignore those bigrams with frequencies less than a specific number. You can define _“n”_ (FOC frequency threshold) in the second code above. 

## B. Construct GO term definition and build definition matrices: 

In this step we construct extended definitions for GO terms for each GO of BP, CC and MF, and then build the definition matrices of those extended definitions. For constructing extended definitions, after downloading GO (go.obo file) from gene ontology's official website (Download from: http://geneontology.org/page/download-ontology), for each GO term, we extract name, definition, parents, children, and other directly related GO terms. We do this separately for each gene ontology. Just as an example for MF ontology: 

	- Perl code “2.1.MF_Name_Extractor.pl” extracts full name of GO terms included in MF
	- Perl code “2.2.MF_Definition_Extractor.pl” extracts definition of GO terms included in MF
	- Perl code “2.3.MF_Parents_Extractor.pl” extracts parents of GO terms included in MF
	- Perl code “2.4.MF_Children_Extractor.pl” extracts children of GO terms included in CC
	- Perl code “2.5.MF_Extra_Relationship_Extractor.pl” extracts extra related terms (such as part of, has part, regulates) to GO terms included in MF
	- Perl code “2.6.MF_Extended_Definition_Construction.pl” constructs extended definitions of the GO terms included in MF
	- Perl code “2.7.MF_Definition_Matrix_Construction_preparation.pl” constructs a sparse definition matrix of the GO terms included in MF by taking the index file (explained above) into account
	- Perl code “2.8.MF_Definition_Matrix_Construction_final.pl” constructs the final sparse definition matrix of the GO terms included in MF after adding two needed lines at the beginning of the matrix generated in the previous stage (for MATLAB you only need the second line – comment out the code for printing the first line!)

**CAVEATS.1:** We advise you to use GO included in the UMLS (Unified Medical Language System) in this step. The UMLS is a very large collection of Ontologies which includes lots and lots of medical and biomedical-related hierarchies and vocabularies; GO is only one of them (Download from: http://www.nlm.nih.gov/research/umls/licensedcontent/umlsknowledgesources.html). You can download and use perl package UMLS::Similarity (Download from: http://search.cpan.org/dist/UMLS-Similarity/) for an easy traverse in the UMLS. We recommend this for two important reasons. First, we want to have a very rich definition for each GO term; so extending definitions from GO itself can be very helpful in many cases (like what we did above). However, we seek for even a better representation of a GO term by considering the other definitions of that term which come from the other ontologies/vocabularies in the UMLS. This would enhance the richness of that extended definition and would lead us to a better estimation of similarity. Second, using the perl package suggested here would make it easier for you not only to have access to the name, parents, children (and many other information) of one GO term, but also would facilitate our traverse in GO hierarchy which is a must in other semantic similarity measures that depend on GO structure. There is file included in the Extra folder named “CUI_and_GO_Equivalence” which would map most of GO term IDs into the concepts’ CUIs in the UMLS. 

**CAVEATS.2:** Depending on your biomedical task, you might get slighter better results after examining different combinations of definition extensions. So you may want to comment out some parts of perl codes starting with 2.6.
    
## C. Build second order co-occurrence matrices: 

we build second order co-occurrence matrix (SOC matrix) for BP, CC or MF ontology in this step. Let’s say if you want to do this for MF, whether useing R or MATLAB, the script which would do that for you is “3.simDEF_MF.R” or “3.simDEF_MF.m”.

## D. Apply PMI on SOC matrices: 

This will apply pointwise mutula information (with Laplace smoothing) on a SOC matrix. While for R it is included as a function in the same R script file mentioned above, for MATLAB it is saved and ready to call using PMI.m file. These functions are highly optimized for the needed computational time. A range of the PMI result usually lies within [0, 3] interval after ignoring negative values.

## E. Find the best cut-off threshold for selecting important features: 

This step would apply cutoff threshold on a PMI-on-SOC matrix. After applying PMI on SOC matrix using the R and MATLAB codes mentioned in Step C, you can define this threshold in the following lines in the same files. In addition to lower bound threshold you may also want to apply an upper bound threshold as well. Most of the time the lower bound cut-off point is higher than 0.1 (or even higher)!
 
## F. Calculate semantic similarity: 

In this stage you will calculate the cosine of the angel between two given GO term as the degree of their similarity. You can write you own code for this computation considering that each row of the optimized PMI-on-SOC matrix (from the previous step) belongs to one GO term. However if you want to use this for your study and you have a very long list of GO terms, in order to save time, we suggest you compute the similarities of all pairs (of GO terms) in one single step instead of measuring them one pair at a time. To do this by using functions “MatrixNorm” we first normalize each vector (i.e. calculate unit vectors) in the matrix and then by multiplication of the resulted matrix with its transpose we will get another matrix which holds similarity values of all the GO terms in a GO. For example, value of the cell [34, 68] in that matrix will be the similarity of the GO terms associated with 34 and 68 rows of the optimized PMI-on-SOC matrix for that particular gene ontology.

## Future Questions

We hope simDEF as well as this explanation will help you in your projects and studies. If you have any further question, please do not hesitate to email us (corresponding author: Ahmad Pesaranghader; email address: ahmad.pgh@dal.ca), or open an issue on GitHub regarding your doubts.
