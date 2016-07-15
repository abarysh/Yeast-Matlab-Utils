% Remove all symbols that should not appear in a gene name
function newNames = clean_genename(oldNames)

newNames = oldNames;
inds = find(~cellfun(@isnumeric, oldNames) & ~cellfun(@isempty, oldNames));

newNames(inds) = regexprep(oldNames(inds), '[^a-zA-Z0-9'',]','');
