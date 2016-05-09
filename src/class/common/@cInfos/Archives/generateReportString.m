function string_OUT = generateReportString(obj_IN, varargin)
%==========================================================================
%% VOLVO 3P 2011
%==========================================================================
% GST 2.0
%==========================================================================
% FILENAME: generateReportString.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Generate a string with the content of the classes
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      07/06/2011  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN   	: cInfos object
%   varargin   	: pair parameter_name/parameter_value
%==========================================================================
% OUTPUT:
%   string_OUT	:  generated string
%==========================================================================
% EXCEPTION
%   ClassCastException
%==========================================================================
% Initialize local variable
% -------------------------
with_field_name    = 1;
remove_empty_field = 0;
delimiter          = '\n';

% Manage input arguments
% ----------------------
for var_i=1:2:length(varargin)

    % Check input arguments
    cast_exception = ClassCastException(...
        'Non empty string required as input');
    if ~ischar(varargin{var_i}) || ...
            isempty(varargin{var_i}); throw(cast_exception); end;

    % Define input arguments
    switch varargin{var_i}

        case 'field_name'
        
            if strcmp(varargin{var_i+1},'off')
            
                with_field_name = 0;
            
            end

        case 'delimiter'
        
            delimiter = varargin{var_i+1};
        
        case 'remove_empty_field'
        
            if strcmp(varargin{var_i+1},'on')
           
                remove_empty_field = 1;
            
            end

    end

end

% Initialize output
% -----------------
string_OUT = '';

% Get data
% --------
tmp_struct = cInfos_data;
field_list = fields(tmp_struct);

% Generate string
% ---------------
for var_i=1:length(field_list)

    current_field = field_list{var_i};
    
    if isempty(tmp_struct.(current_field)) && ...
            remove_empty_field; continue; end;
    
    if with_field_name
        
        string_OUT = [string_OUT, current_field, ' : ']; %#ok<AGROW>
    
    end

    tmp_string = tmp_struct.(current_field);
    
    if isnumeric(tmp_string)
    
        tmp_string = num2str(tmp_string);
    
    elseif isstruct(tmp_string)
    
        tmp_string = 'structure';
    
    end

    switch delimiter
    
        case '\n'
        
            % Line delimiter
            string_OUT=sprintf('%s%s\n',string_OUT,tmp_string);
        
        case '\t'
        
            % Tabulation delimiter
            string_OUT=sprintf('%s%s\t',string_OUT,tmp_string);
        
        otherwise
            
            % Default case
            string_OUT=sprintf('%s%s\n',string_OUT,tmp_string);
    
    end

end
%==========================================================================
