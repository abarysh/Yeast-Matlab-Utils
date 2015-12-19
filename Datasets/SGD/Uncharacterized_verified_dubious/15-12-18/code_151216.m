addpath(genpath('/Users/Anastasia/Laboratory/Utils/'))

fid = fopen('results.tsv','r');
C = textscan(fid, '%s %s %s %s','delimiter','\t');
fclose(fid);

dbids = C{1};
orfs = C{2};
genenames = C{3};
aliases = C{4};

for i = 1 : length(aliases)
    aliases{i} = regexp(aliases{i}, ' ', 'split');  
end

uv.orfs = unique(orfs);
uv.genenames = unique([genenames; [aliases{:}]']);

% Only retain 3-letter code genenames
uv.genenames(~isgenename(uv.genenames)) = [];

uv.namespace = zeros(length(uv.orfs),length(uv.genenames));

for i = 1 : length(dbids)
    
    ix = find(ismember(uv.orfs, orfs(i)));
    iy = find(ismember(uv.genenames, genenames(i)));
    iz = find(ismember(uv.genenames, aliases{i}));
    
    % Re-establish the same order that the aliases appear in the original list
    [~,ind1,ind2] = intersect(uv.genenames(iz), aliases{i});
    [~,ind3] = sort(ind2);
    iz = iz(ind1(ind3));
    
    % Populate the namespace matrix such that the main genename is #1 and all the aliases are #2, #3 etc. in order
    if ~isempty(ix) && ~isempty(iy)
        uv.namespace(ix, iy) = 1;    
    end
    
    if ~isempty(ix) && ~isempty(iz)
        uv.namespace(ix, iz) = [1:length(iz)]+1;   
    end

end

uvd = uv;

save('uncharacterized_verified_dubious_151218.mat','uvd');