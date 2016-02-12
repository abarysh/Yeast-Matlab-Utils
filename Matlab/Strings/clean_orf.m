% Remove all symbols that should not appear in an ORF name
function newNames = clean_orf(oldNames)

newNames = regexprep(oldNames, '[_ .,''"`!@#$%^&*()[]{}+=|~]','');
newNames = upper(newNames);
