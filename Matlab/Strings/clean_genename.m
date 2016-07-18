% Remove all symbols that should not appear in a gene name
function newNames = clean_genename(oldNames)

newNames = oldNames;
inds = find(~cellfun(@isnumeric, oldNames) & ~cellfun(@isempty, oldNames));

newNames(inds) = regexprep(oldNames(inds), '[^a-zA-Z0-9'',\-]','');

%% Correct missing hyphens in ORFs (e.g., YAL064CA)

orf_length = cellfun(@length, newNames);
orf_token1 = cell(size(newNames));
orf_token2 = cell(size(newNames));

inds = find(orf_length==8);
orf_token1(inds) = cellfun(@(x) x(1:7), newNames(inds), 'UniformOutput', 0);
orf_token2(inds) = cellfun(@(x) x(8), newNames(inds), 'UniformOutput', 0);

inds2 = find(is_orf(orf_token1(inds)));
newNames(inds(inds2)) = strcat(orf_token1(inds(inds2)), '-', orf_token2(inds(inds2)));