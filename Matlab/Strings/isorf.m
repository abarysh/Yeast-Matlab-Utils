function bool = isorf(vector)

bool = cellfun(@isempty, regexpi(vector, '^Y[A-P][RL][0-9]{3}[CW](-[A-E])*'));