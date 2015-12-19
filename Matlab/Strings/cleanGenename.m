% Remove all symbols that should not appear in a gene name
function newNames = cleanGenename(oldNames)

newNames = regexprep(oldNames, '[ .]','');
