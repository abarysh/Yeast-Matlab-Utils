% Remove all symbols that should not appear in an ORF name
function newNames = cleanOrf(oldNames)

newNames = regexprep(oldNames, '[_ .,''"`!@#$%^&*()[]{}+=|~]','');
newNames = upper(newNames);
