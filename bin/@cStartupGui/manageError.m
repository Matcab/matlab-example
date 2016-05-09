function manageError(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: manageError.m
% PATH    : ..\bin\@cStartupGui
%==========================================================================
% ABSTRACT: manange error occuring during initialisaiton process
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      16/05/2011  Creation
%	Mathieu CABANES         AROB@S      15/02/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN  	: cStartupGui object
%   varargin    : command line argument of manageError (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================

% Manage error treatement only if it exist
% ----------------------------------------
if isempty(obj_IN.error_list); return; end;

% Log file management
% -------------------
% Define filename to save error messages
if (nargin > 1) && exist(varargin{1}, 'dir')
    
    filename = fullfile(varargin{1}, 'start_error.log');
    
elseif (nargin > 1) && ~isempty(regexp(varargin{1}, '\.log$', 'once'))
    
    filename = varargin{1};
    
else
    
    filename = 'start_error.log';
    
end

% Define if the file already exist
% --------------------------------
exist_file = exist(filename, 'file')==2;

% Define error messages
% ---------------------
short_msg = {}; % Short message to display to user

for i_err = 1:length(obj_IN.error_list)
    
    % Create short message
    short_msg{end+1} = ['** ' obj_IN.error_list{i_err}.message]; %#ok<AGROW>
    
    % Manage cause of exceptions
    if isa(obj_IN.error_list{i_err}, 'MException') && ...
            ~isempty(obj_IN.error_list{i_err}.cause)
        
        for i_cause = 1:length(obj_IN.error_list{i_err}.cause)

            % Define the current cause
            current_cause = obj_IN.error_list{i_err}.cause{i_cause};
            
            % Update short message
            short_msg{end+1} = ['   => CAUSE: ' current_cause.message]; %#ok<AGROW>
                        
        end
        
    end
    
end

% Concatenate and create complete messages
msg_tmp = short_msg;

if length(msg_tmp)>1
    
    short_msg = {sprintf(['[%s] Warning(s) and/or Error(s) have been ', ...
        'generated during the initialization process.'], ...
        datestr(now,13)); ''; ['Some functionalities may not work ', ...
        ' properly. Here are the details: ']; msg_tmp{1}};
    
    for i_msg = 2:length(msg_tmp)
    
        short_msg{end+1} = (msg_tmp{i_msg}); %#ok<AGROW>
    
    end
    
else
    
    short_msg = {sprintf(['[%s] Warning(s) and/or Error(s) have been ', ...
        'generated during the initialization process.'], ...
        datestr(now,13)); ''; ['Some functionalities may not work ', ...
        ' properly. Here are the details: ']; msg_tmp{:}};
    
end

% Display messages in the starting gui
% ------------------------------------
set(obj_IN.LbLog, 'String', short_msg);

% Feed Log file message
% ---------------------
% Write message
fid = fopen(filename, 'a');

% Manage error in file opening
if (fid == -1); return; end;

% Define header if necessary
if ~exist_file
    
    fprintf(fid, '%s\n', ...
        '%=================================================');
    fprintf(fid, '%s ERROR LOG FILE - initiated the %s \n', ...
        '%', datestr(now, 'yyyy/mm/dd'));
    fprintf(fid, '%s\n', ...
        '%=================================================');
    
end
   
% Write the different errors
for i_err = 1:length(obj_IN.error_list)
   
    fprintf(fid, '\n');
    fprintf(fid, '%s ERROR generated during initialization the %s\n', ...
        '%s', datestr(now));
    fprintf(fid, '*** MESSAGE: %s - IDENTIFIER: %s\n', ...
        obj_IN.error_list{i_err}.message, obj_IN.error_list{i_err}.identifier);
    
    % Add other informations
    if ~isempty(obj_IN.error_list{i_err}.stack)
       
        for i_stack = 1:length(obj_IN.error_list{i_err}.stack)
            
            fprintf(fid, '    => FILE: %s\n', ...
                obj_IN.error_list{i_err}.stack(i_stack).file);
            fprintf(fid, '    => FUNCTION: %s (Line: %d)\n', ...
                obj_IN.error_list{i_err}.stack(i_stack).name, ...
                obj_IN.error_list{i_err}.stack(i_stack).line);
            
        end
            
    end
    
    % Manage cause error
    if ~isempty(obj_IN.error_list{i_err}.cause)
        
        % Define the list of causes
        cause_error = obj_IN.error_list{i_err}.cause;
        
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

fclose(fid);
%==========================================================================
