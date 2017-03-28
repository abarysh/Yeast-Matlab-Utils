% Remove all symbols that should not appear in a gene name
function newNames = clean_genename(oldNames)

newNames = upper(oldNames);
inds = find(~cellfun(@isnumeric, newNames) & ~cellfun(@isempty, newNames));

newNames(inds) = regexprep(newNames(inds), '[^a-zA-Z0-9'',\-]','');

%% Fix some common genename issues in yeast

newNames = regexprep(newNames, 'ADE5\-*7', 'ADE5,7');
newNames = regexprep(newNames, 'ARG5\-*6', 'ARG5,6');
newNames = regexprep(newNames, 'DUR1\-*2', 'DUR1,2');
newNames = regexprep(newNames, 'MF\-*ALPHA\-*1', 'MF(ALPHA)1');
newNames = regexprep(newNames, 'MF\-*ALPHA\-*2', 'MF(ALPHA)2');
newNames = regexprep(newNames, 'AI5\-*ALPHA', 'AI5_ALPHA');
newNames = regexprep(newNames, 'AI5\-*BETA', 'AI5_BETA');


%% Correct missing hyphens in ORFs (e.g., YAL064CA)

orf_length = cellfun(@length, newNames);
orf_token1 = cell(size(newNames));
orf_token2 = cell(size(newNames));

inds = find(orf_length==8);
orf_token1(inds) = cellfun(@(x) x(1:7), newNames(inds), 'UniformOutput', 0);
orf_token2(inds) = cellfun(@(x) x(8), newNames(inds), 'UniformOutput', 0);

inds2 = find(is_orf(orf_token1(inds)));
newNames(inds(inds2)) = strcat(orf_token1(inds(inds2)), '-', orf_token2(inds(inds2)));