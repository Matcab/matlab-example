function obj_OUT = initialize(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: initialize.m
% PATH    : ..\bin\@cStartupGui
%==========================================================================
% ABSTRACT: Initialize the cStartupGui interface
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      26/04/2011  Creation
%	Mathieu CABANES         AROB@S      15/02/2013  Migration to MATLAB
%                                                   2011b
%	Mathieu CABANES         AROB@S      07/11/2013  Update to manage handle
%                                                   inheritence
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN  	: cStartupGui object
%   varargin   	: command line argument of initialize (see VARARGIN)
%==========================================================================
% OUTPUT:
%   obj_OUT 	: updated cStartupGui object
%==========================================================================

% Initialize object
% -----------------
obj_OUT = obj_IN;

% Manage step list data
% ---------------------
[actions, action_sizes] = LocalTreatActions(obj_OUT.step_list);

% Define maximum length of lines to write
% ---------------------------------------
action_lengths = cellfun(@(x)(size(x,2)), actions, 'UniformOutput', false);
line_length    = 6*max(cell2mat(action_lengths));

% Create Window
% -------------
obj_OUT = obj_OUT.createFigure(actions, action_sizes, line_length);
%==========================================================================

function [actions_OUT, size_OUT] = LocalTreatActions(actions_IN)
%==========================================================================
%% DESCRIPTION: Define actions to display in the interface
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   actions_IN	: Actions defining the initialization process
%==========================================================================
% OUTPUT:
%   actions_OUT : Actions defining the initialization process
%   size_OUT    : Size of each actions
%==========================================================================
% Define line length
% ------------------
line_length = 50;

% Loop on input actions
% ---------------------
for i_action = 1:length(actions_IN)
    
    % Line delimiter position
    line_step = [1, regexp(actions_IN{i_action}, '\n\w'), ...
        length(actions_IN{i_action})];
    
    for i_line_step = 2:length(line_step)
        
        % Calculate number of lines which can be defined
        nb_line = ceil((line_step(i_line_step) - ...
            line_step(i_line_step-1)) / line_length);
        
        % Find spaces in string
        space_pos = regexp(actions_IN{i_action}( ...
            line_step(i_line_step-1):line_step(i_line_step)), ' ');
        
        % Go to next loop if only one line is found
        if (nb_line == 1); continue; end
        
        % Define default separator position
        separator = line_length * (1:nb_line-1);
        
        % Try to set separator in space
        if ~isempty(space_pos)
            
            % Get distance between space and line ideal size
            [val,idx] = min(abs(repmat(space_pos', 1, nb_line-1) - ...
                repmat(separator, size(space_pos,2), 1)));
            separator(val < (line_length/2)) = ...
                space_pos(idx(val < line_length/2));
            
        end
        
        for i_separator = length(separator):-1:1
            
            actions_IN{i_action} = sprintf('%s\n%s', ...
                actions_IN{i_action}(1:separator(i_separator)), ...
                actions_IN{i_action}(separator(i_separator)+1:end));
            
        end
        
    end
    
    % Add action number
    actions_IN{i_action} = sprintf('%g - %s', i_action, ...
        actions_IN{i_action});
    
    % Calculate number of line for action string
    size_OUT(i_action) = ...
        length(regexp(actions_IN{i_action}, '\n\w')) + 1; %#ok<AGROW>
    
end

% Assign action as output
actions_OUT = actions_IN;
%==========================================================================
