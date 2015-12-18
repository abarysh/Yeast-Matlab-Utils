fid = fopen('/Users/Anastasia/Laboratory/Datasets/SGD/Essential_ORFs/15-12-15/Phenotype_Genes.tsv','r');
C = textscan(fid,'%s %s %*[^\n]','delimiter','\t');
fclose(fid);

essential_genes = unique(C{2});

save('Datasets/SGD/Essential_ORFs/15-12-15/essential_genes_151215.mat','essential_genes');