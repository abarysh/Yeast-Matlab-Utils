function bool = is_genename(vector)

num = cellfun(@isnumeric, vector);

bool = zeros(size(vector));
bool(~num) = ~cellfun(@isempty, regexpi(vector(~num), '^[A-Z]{3,}[0-9]{1,4}([A-E])?$'));

bool(~cellfun(@isempty, regexpi(vector(~num), '^RP[LS]?[0-9]+[A-E]*'))) = 1;    % example: RPL45A
bool(~cellfun(@isempty, regexpi(vector(~num), '^[A-Z]{3,}[0-9]{1,4}-[0-9]$'))) = 1; % example: YRF1-6
bool(~cellfun(@isempty, regexpi(vector(~num), '^[A-Z]{3,}[0-9],[0-9]$'))) = 1;  % example: ADE5,7
bool(~cellfun(@isempty, regexpi(vector(~num), '^OM[0-9]{2}$'))) = 1;    % example: OM45

% Exceptions to the rule
bool(strcmp('HO', vector)) = 1;
bool(strcmp('MF(ALPHA)1', vector)) = 1;
bool(strcmp('MF(ALPHA)2', vector)) = 1;
bool(strcmp('IMP2''', vector)) = 1;



