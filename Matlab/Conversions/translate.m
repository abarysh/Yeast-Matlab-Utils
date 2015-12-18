% This function will take an array of names in one format (ORFs or gene names, either standard or aliases)
% and will return an array in the specified format (ORFs or gene names).

function newNames = translate(varargin)

load uncharacterized_verified_151216.mat;

%% Process inputs

if nargin == 0
    error('Not enough inputs.');
end

oldNames = varargin{1};
newNames = oldNames;

direction = {'genenames','orfs'};
if nargin > 1
    direction = {direction{~ismember(direction, varargin{2})}, varargin{2}};
end

%% Initial checks

if strcmp('genenames', direction{1})
    inds = find(cellfun(@isempty, regexp(oldNames, '^[A-Z]{3,}[0-9]+')));
    if ~isempty(inds)
        fprintf('\nThese items don''t look like gene names:\n');
        disp(oldNames(inds));
    end
end

if strcmp('orfs', direction{1})
    inds = find(cellfun(@isempty, regexp(oldNames, '^Y[A-P][RL][0-9]{3}[CW](-[ABC])*')));
    if ~isempty(inds)
        fprintf('\nThese items don''t look like ORFs:\n');
        disp(oldNames(inds));
    end
end    

%%
if ~issorted(direction)
    uv.namespace = uv.namespace';
end

translated = zeros(length(oldNames),1);

for i = 1 : length(oldNames)
    
    ind1 = find(ismember(uv.(direction{1}),oldNames{i}));
    if ~isempty(ind1)
        ind2 = find(uv.namespace(:,ind1) > 0);
        if ~isempty(ind2)
            [~,ix] = sort(uv.namespace(ind2,ind1));
            newNames(i) = uv.(direction{2})(ind2(ix(1)));
            translated(i) = 1;
        end
    end
end

%% Print report

% Names that weren't translated
inds1 = find(~translated);
inds2 = find(ismember(newNames(inds1), uv.(direction{2})));
if ~isempty(inds2)
    fprintf(['\nThese items were not translated but are already ' direction{2} ':\n']);
    disp(newNames(inds1(inds2)));
end

inds2 = setdiff([1:length(inds1)],inds2);
if ~isempty(inds2)
    fprintf(['\nThese items were not translated and don''t look like any ' direction{2} ':\n']);
    disp(newNames(inds1(inds2)));
end