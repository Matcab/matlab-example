function obj_OUT = updateStep(obj_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: updateStep.m
% PATH    : bin\@cStartupGui
%==========================================================================
% ABSTRACT: Increment step on initialisation interface
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      17/05/2011  Creation
%	Mathieu CABANES         AROB@S      15/02/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cStartupGui object
%==========================================================================
% OUTPUT:
%   obj_OUT   	: updated object
%==========================================================================

% Initialize object
% -----------------
obj_OUT = obj_IN;

% Increment step value
% --------------------
obj_OUT.current_step = obj_IN.current_step+1;

% Update interface
% ----------------
if obj_OUT.current_step <= length(obj_OUT.step_list)
    
    % Change text component properties
    set(obj_OUT.StStep(obj_OUT.current_step), 'FontWeight', 'bold');
    
    % Update Progress bar
    obj_OUT.JProgressBar.setValue(100*(obj_OUT.current_step/...
        length(obj_OUT.step_list)));
    
    pause(0.1);
    
else
    
    obj_IN.close();
    
end
%==========================================================================