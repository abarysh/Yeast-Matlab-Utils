% Remove all symbols that should not appear in a gene name
function newNames = clean_genename(oldNames)

newNames = regexprep(oldNames, '[ .]','');
