% Remove all symbols that should not appear in an ORF name
function newNames = clean_orf(oldNames)

newNames = oldNames;

inds = find(~cellfun(@isnumeric, oldNames) & ~cellfun(@isempty, oldNames));
newNames(inds) = regexprep(oldNames(inds), '[_ .,''"`!@#$%^&*()[]{}+=|~]','');
newNames(inds) = upper(newNames(inds));
newNames(inds) = strtrim(newNames(inds));

%% Correct missing hyphens (e.g., YAL064CA)

orf_length = cellfun(@length, newNames);
orf_lastchar = ~cellfun(@isempty, regexp(newNames, '[ABCD]$'));

inds = find(orf_length==8 & orf_lastchar);

for i = 1 : length(inds)
    newNames{inds(i)} = [newNames{inds(i)}(1:7) '-' newNames{inds(i)}(8)];
end
