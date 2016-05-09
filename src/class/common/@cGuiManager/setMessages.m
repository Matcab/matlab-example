function obj_OUT = setMessages(obj_IN)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setMessages.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Set the messages 
%==========================================================================
% REVISION HISTORY:
%   AUTHOR      	COMPANY     DATE        COMMENT
%	Mathieu CABANES	AROB@S      23/09/2013  Class creation
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cGuiManager object
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cGuiManager object
%==========================================================================

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Verify if the filename is valid
% -------------------------------
if isempty(obj_OUT.message_filename); return; end;

% Read the corresponding message filename
% ---------------------------------------
% open the file
fid = fopen(obj_OUT.message_filename, 'r');

% Manage error in file opening
if (fid <0); return; end;

% Read file content
file_content = textscan(fid, '%s%s', 'CommentStyle', '%', 'Delimiter', ...
    '\t', 'MultipleDelimsAsOne', 1);

% Close
fclose(fid);

% Create specific message structure
% ---------------------------------
for i_message = 1:length(file_content{1})
            
    obj_OUT.messages.(deblank(file_content{1}{i_message})) = ...
        file_content{2}{i_message};
    
end
%==========================================================================
