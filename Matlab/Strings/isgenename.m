function bool = isgenename(vector)

num = cellfun(@isnumeric, vector);

bool = zeros(size(vector));
bool(~num) = ~cellfun(@isempty, regexpi(vector(~num), '^[A-Z]{3,}[0-9]{1,4}([AB])?$'));

% Exceptions to the rule
bool(strcmp('HO', vector)) = 1;
bool(strcmp('OM45', vector)) = 1;