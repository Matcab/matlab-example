function updateErrorLog(obj_IN, varargin)
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

% Get the error log filename
% --------------------------
if isempty(obj_IN.error_filename); return; end;

% Define if the file already exist
% --------------------------------
exist_file = exist(obj_IN.error_filename, 'file')==2;

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
% open error log file
fid = fopen(obj_IN.error_filename, 'a');

% Manage error in file opening
if (fid == -1); return; end;

% Define header if necessary
if ~exist_file
    
    fprintf(fid, '%s\n', ...
        '%=================================================');
    fprintf(fid, '%s %s %s %s\n', '%',  obj_IN.applicative_id, ...
        'ERROR LOG FILE - initiated the', datestr(now, 'yyyy/mm/dd'));
    fprintf(fid, '%s\n', ...
        '%=================================================');
    
end
   
% Write the different errors
for i_err = 1:length(current_error)
   
    fprintf(fid, '\n');
    fprintf(fid, '%s %s %s %s\n', '%', upper(strrep(current_type{i_err}, ...
        '_', ' ')), 'generated the', datestr(now));
    fprintf(fid, '*** MESSAGE: %s - IDENTIFIER: %s\n', ...
        current_error(i_err).message, current_error(i_err).identifier);
    
    % Add other informations
    if ~isempty(current_error(i_err).stack)
       
        for i_stack = 1:length(current_error(i_err).stack)
            
            fprintf(fid, '    => FILE: %s\n', ...
                current_error(i_err).stack(i_stack).file);
            fprintf(fid, '    => FUNCTION: %s (Line: %d)\n', ...
                current_error(i_err).stack(i_stack).name, ...
                current_error(i_err).stack(i_stack).line);
            
        end
            
    end
    
    % Manage cause error
    if ~isempty(current_error(i_err).cause)
        
        % Define the list of causes
        cause_error = current_error(i_err).cause;
        
        % Display the error informations
        for i_cause = 1:length(cause_error)
            
            fprintf(fid, '*** MESSAGE: %s - IDENTIFIER: %s\n', ...
                cause_error{i_cause}.message, cause_error{i_cause}.identifier);

            % Add other informations
            if ~isempty(cause_error{i_cause}.stack)
                
                for i_stack = 1:length(cause_error{i_cause}.stack)
                    
                    fprintf(fid, '    => FILE: %s\n', ...
                        cause_error{i_cause}.stack(i_stack).file);
                    fprintf(fid, '    => FUNCTION: %s (Line: %d)\n', ...
                        cause_error{i_cause}.stack(i_stack).name, ...
                        cause_error{i_cause}.stack(i_stack).line);
                    
                end
                
            end
            
        end
        
    end
    
end

fprintf(fid, '%s\n', '%=================================================');

% Close the file
fclose(fid);
%==========================================================================
