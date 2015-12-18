function bool = isorf(vector)

num = cellfun(@isnumeric, vector);

bool = zeros(size(vector));
bool(~num) = ~cellfun(@isempty, regexpi(vector(~num), '^Y[A-P][RL][0-9]{3}[CW](-[A-E])*'));