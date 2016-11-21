% Remove all symbols that should not appear in an ORF name
function newNames = clean_orf(oldNames)

newNames = oldNames;

inds = find(~cellfun(@isnumeric, oldNames) & ~cellfun(@isempty, oldNames));
% newNames(inds) = regexprep(oldNames(inds), '[_ .,''"`!@#$%^&*()[]{}+=|~]','');
newNames(inds) = regexprep(oldNames(inds), '[^a-zA-Z0-9-]','');
newNames(inds) = upper(newNames(inds));
newNames(inds) = strtrim(newNames(inds));

%% Correct missing hyphens (e.g., YAL064CA)

orf_length = cellfun(@length, newNames);
orf_token1 = cell(size(newNames));
orf_token2 = cell(size(newNames));

inds = find(orf_length==8);
orf_token1(inds) = cellfun(@(x) x(1:7), newNames(inds), 'UniformOutput', 0);
orf_token2(inds) = cellfun(@(x) x(8), newNames(inds), 'UniformOutput', 0);

inds2 = find(is_orf(orf_token1(inds)) & ismember(orf_token2(inds),{'A','B','C','D','E'}));
newNames(inds(inds2)) = strcat(orf_token1(inds(inds2)), '-', orf_token2(inds(inds2)));
