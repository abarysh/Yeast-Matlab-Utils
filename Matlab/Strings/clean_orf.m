% Remove all symbols that should not appear in an ORF name
function newNames = clean_orf(oldNames)

newNames = oldNames;

inds = find(~cellfun(@isnumeric, oldNames) & ~cellfun(@isempty, oldNames));
newNames(inds) = regexprep(oldNames(inds), '[_ .,''"`!@#$%^&*()[]{}+=|~]','');
newNames(inds) = upper(newNames(inds));
