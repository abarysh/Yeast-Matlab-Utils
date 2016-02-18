function pm = build_phenotype_name(pm)

% Input: a structure containing the WHO, WHAT, WHEN, WHERE, HOW and WHY parameters of a phenotype

pm.ph = cell(size(pm.who));

for i = 1 : length(pm.who)
    t = [pm.what{i} ' of ' pm.who{i}];
    
    if ~isempty(pm.when{i})
        t = [t ' ' pm.when{i}];
    end
    
%     if ~isempty(pm.how{i})
%         t = [t ' by ' pm.how{i}];
%     end

    if ~isempty(pm.condition{i})
        t = [t '; ' pm.condition{i}];
    end
    
    pm.ph{i} = t;
end

