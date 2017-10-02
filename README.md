# simDEF: Definition-based Semantic Similarity Measure of GO Terms for Functional Similarity Analysis of Genes

## Background

The rapid growth of biomedical data annotated by Gene Ontology (GO) vocabulary demands an intelligent method of semantic similarity measurement between GO terms facilitating analysis of functional similarities of genes since compared with sequence and structure similarity, functional similarity is more informative for understanding the biological roles and functions of genes. Many important applications in computational molecular biology such as gene clustering, protein function prediction, protein interaction evaluation and disease gene prioritization require functional similarity. Some existing semantic similarity measures combine similarity scores of single GO term pairs to estimate gene functional similarity, whereas others compare terms in groups to measure it. Nevertheless, all of these measures are strictly dependent on the ever-changing topological structure of GO; they are extremely task dependent leaving no room for their generalization, and none of them takes the valuable textual definition of GO terms into consideration. These limitations present the challenge of measuring gene functional similarity reliably.

## Results and conclusions

This study introduces simDEF, an efficient method for measuring semantic similarity of GO terms using their GO definitions. In essence, simDEF is an optimized version of Gloss Vector measure which is commonly used in natural language processing (NLP). Pointwise mutual information (PMI) is employed for this optimization. After constructing optimized definition-vectors of all GO terms, the cosine of the angle between terms’ definition-vectors represents the degree of similarity between them. Experimental studies show that simDEF outperforms existing semantic measures in terms of correlation with sequence homology and gene expression data and also demonstrate its superiority for prediction of true from false interactions in a protein-protein interaction (PPI) task. Relative to existing similarity measures, when validated on a yeast reference database, simDEF improves correlation with sequence homology by up to 50%, shows more than 4% correlation with gene expression in biological process hierarchy of GO, and increases protein-protein interaction (PPI) predictability by more than 2.5% in F1-score for molecular function hierarchy.

## Availability

These free codes can be used, modified and redistributed without any restrictions.  
Release date: _September, 2015_  
Documentation: _Please refer to the provided instruction file before use. (Highly recommended)_

## Datasets for the evaluation

The datasets built in the study and employed in the evaluation analyses include (see the 'EXPERIMENTAL DATA' section, 'Validation datasets' subsection for detail):
1. Sequence Homology Data (_20,167 protein pairs_)
2. Gene Expression Data (_4,800 protein pairs_)
3. PPI Data (_6,000 protein pairs_)

## Citation

simDEF: Definition-based Semantic Similarity Measure of Gene Ontology Terms for Functional Similarity Analysis of Genes
_Ahmad Pesaranghader; Stan Matwin; Marina Sokolova; Robert G. Beiko_   
Bioinformatics 2015;   
doi: [10.1093/bioinformatics/btv755](https://doi.org/10.1093/bioinformatics/btv755)
([supplementary material file](https://oup.silverchair-cdn.com/oup/backfile/Content_public/Journal/bioinformatics/32/9/10.1093_bioinformatics_btv755/2/btv755_Supplementary_Data.zip?Expires=1506981985&Signature=BtLozF2hn3DrvSPP5EbzxDAQZvIbcKbGrQ-R2kcvCy-ArKMdCwXWbLgKwHD6MQ4AxZACoW1tD1~tFmTqT52AlZ~5-JnFd99dDi77jA0-LfldtjCoWfV0u2uNSpzul9SL0BXWPocw4cxfaX~FBFKyBsY7v6um1bRqItAlqk9d70kX5mA40Vl-RLqUz6yxBVXHNllTBnQr0l2BB23LsyXIrwLEkzc5kQQes1TzRUqzUOCM9QLY7ZEhs3tZbsWBfTZPrBFMGwP3G~V9nJOdSs4vgabg3RnxqV7r9pmC-KPCP-AWWBjHKmr9Razf1qzJhum0v4lkGwKMftTDfCXI56TeSQ__&Key-Pair-Id=APKAIUCZBIA4LVPAVW3Q))
