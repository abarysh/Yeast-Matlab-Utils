% This function will take an array of names in one format (ORFs or gene names, either standard or aliases)
% and will return an array in the specified format (ORFs or gene names).

function [newNames, translated, ambiguous] = translate(oldNames, varargin)

load uncharacterized_verified_dubious_170322.mat;
uv = uvd;

%% Process inputs

newNames = oldNames;

direction = {'genenames','orfs'};
if nargin > 1
    direction = {direction{~ismember(direction, varargin{1})}, varargin{1}};
end

verbose = ismember({'verbose'}, varargin);

%% Initial checks

fprintf('\nAll items: %d\n', length(oldNames));

if strcmp('genenames', direction{1})
    inds = find(~is_genename(oldNames));
    if ~isempty(inds)
        fprintf('\nItems don''t look like gene names: %d\n', length(inds));
    end
end

if strcmp('orfs', direction{1})
    inds = find(~is_orf(oldNames));
    if ~isempty(inds)
        fprintf('\nItems don''t look like ORFs: %d\n', length(inds));
    end
end 

%%
if ~issorted(direction)
    uv.namespace = uv.namespace';
end

translated = zeros(length(oldNames),1);
ambiguous = zeros(length(oldNames),1);

for i = 1 : length(oldNames)
    
    ind1 = find(ismember(uv.(direction{1}),oldNames{i}));
    if ~isempty(ind1)
        ind2 = find(uv.namespace(:,ind1) > 0);
        
        if length(ind2) > 1
            ambiguous(i) = 1;
        end
        
        if ~isempty(ind2)
            [~,ix] = sort(uv.namespace(ind2,ind1));
            newNames(i) = uv.(direction{2})(ind2(ix(1)));
            translated(i) = 1;
        end
    end
end

% Fix the "quotes" issue
inds = find(strcmp('""', newNames));
newNames(inds) = oldNames(inds);

%% Print report
   
% Names that weren't translated
inds1 = find(~translated);
fprintf('\nItems that were not translated: %d\n', length(inds1));

inds2 = find(ismember(newNames(inds1), uv.(direction{2})));
fprintf(['\t\t - but are already ' direction{2} ': %d\n'], length(inds2));

if strcmp(direction{2}, 'orfs')
    inds3 = find(~ismember(newNames(inds1), uv.(direction{2})) & is_orf(newNames(inds1)));
else
    inds3 = find(~ismember(newNames(inds1), uv.(direction{2})) & is_genename(newNames(inds1)));
end
fprintf(['\t\t - or look like ' direction{2} ': %d\n'], length(inds3));

fprintf('\t\t - other: %d\n', length(inds1)-length(inds2)-length(inds3));


inds1 = find(ambiguous);
if ~isempty(inds1)
    fprintf(['\nItems that are ambiguous (have more than 1 translation, a random one was picked): %d\n'], length(inds1));
end
    
