function updatePrompt(obj_IN)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: display.m
% PATH: ..\common\@cErrorManager
%==========================================================================
% ABSTRACT: Display the error
%==========================================================================
% REVISION HISTORY:
%   AUTHOR      	COMPANY     DATE        COMMENT
%	Mathieu CABANES	AROB@S      23/10/2013  Class creation
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%   varargin    : command line arguments to display (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Manage current errors
% ---------------------
if ~obj_IN.isMultipleError
    
    [current_error, tmp_type] = obj_IN.getError('last');
    current_type = {tmp_type};
    
else
    
    all_error = obj_IN.getError('all');
    
    current_error = [all_error.exception];
    current_type  = {all_error.type};
    
end

% Write current error list
% ------------------------   
% Write the different errors
for i_err = 1:length(current_error)
   
    fprintf(1, '\n');
    fprintf(1, '%s %s\n', '%', upper(strrep(current_type{i_err}, ...
        '_', ' ')));
    fprintf(1, '*** MESSAGE: %s - IDENTIFIER: %s\n', ...
        current_error(i_err).message, current_error(i_err).identifier);
    
    % Add other informations
    if ~isempty(current_error(i_err).stack)
       
        for i_stack = 1:length(current_error(i_err).stack)
            
            fprintf(1, ['    => <a href="matlab:opentoline(''%s'',%d)', ...
                '">%s > %s : %d</a>'], ...
                current_error(i_err).stack(i_stack).file, ...
                current_error(i_err).stack(i_stack).line, ...
                current_error(i_err).stack(i_stack).file, ...
                current_error(i_err).stack(i_stack).name, ...
                current_error(i_err).stack(i_stack).line);
            fprintf(1, '\n');
    
        end
        
    else
            
        fprintf(1, '\n');
        
    end

end
%==========================================================================
