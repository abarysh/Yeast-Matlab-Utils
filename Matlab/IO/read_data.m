function [filenames, DATA] = read_data(varargin) %type, filename, ...
 
filenames = varargin{2};
type = varargin{1};

switch type
    case 'textread' %be able to grab any number of outputs
        fid = fopen(varargin{2},'r','n','UTF-8');
        DATA = textscan(fid, varargin{3:end});
        if numel(DATA) == 1
            DATA = DATA{1};
        end
        fclose(fid);
    case 'textscan'
        fid = fopen(varargin{2},'r','n','UTF-8');
        DATA = textscan(fid, varargin{3:end});
        if numel(DATA) == 1
            DATA = DATA{1};
        end
        fclose(fid);
    case 'xlsread' 
        [~, ~, DATA] = xlsread(varargin{2:end});
    case 'dlmread'
        DATA = dlmread(varargin{2:end});
    case 'read_matrix_file'
        DATA = read_matrix_file(varargin{2:end});
    case 'importdata'
        DATA = importdata(varargin{2:end});
    case 'readtable'
        DATA = readtable(varargin{2:end});
    otherwise
        error('Not Valid Function');
end



end