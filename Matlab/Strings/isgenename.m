function bool = isgenename(vector)

num = cellfun(@isnumeric, vector);

bool = zeros(size(vector));
bool(~num) = ~cellfun(@isempty, regexpi(vector(~num), '^[A-Z]{3,}[0-9]{1,4}([A-E])?$'));

% Exceptions to the rule
bool(strcmp('HO', vector)) = 1;
bool(strcmp('OM45', vector)) = 1;
bool(strcmp('YRF1-6', vector)) = 1;
bool(strcmp('ADE5,7', vector)) = 1;
bool(strcmp('ARG5,6', vector)) = 1;
bool(strcmp('MF(ALPHA)2', vector)) = 1;
bool(strcmp('DUR1,2', vector)) = 1;
bool(strcmp('MF(ALPHA)1', vector)) = 1;