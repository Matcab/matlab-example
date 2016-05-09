function status_OUT = isInteger(value_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: isInteger.m
% PATH    : class\exception
%==========================================================================
% ABSTRACT: Check if the value is an integer number
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      25/07/2011  Creation
%   Marc BALME              AROB@S      19/08/2011  Support of the vector
%                                                	and matrix
%	Mathieu CABANES         AROB@S      28/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM: 
%==========================================================================
% INPUT:
%   value_IN   	: value to test
%==========================================================================
% OUTPUT:
%   status_OUT	: true if it is an integer
%==========================================================================
% Check for empty values
% ----------------------
if isempty(value_IN); status_OUT = true; return; end;

% Check for matrix, vector and single value
% -----------------------------------------
for var_i = 1:size(value_IN,1)

    for var_j = 1:size(value_IN,2)
    
        if ~isnumeric(value_IN(var_i, var_j))
        
            tmp_out_j(var_j) = false; %#ok<AGROW>
        
        elseif round(value_IN(var_i, var_j))~=value_IN
        
            tmp_out_j(var_j) = false; %#ok<AGROW>
        
        else

            tmp_out_j(var_j) = true; %#ok<AGROW>
        
        end

    end

    tmp_out_i = all(tmp_out_j);

end

% Define status of value to test
% ------------------------------
status_OUT = all(tmp_out_i);
%==========================================================================
