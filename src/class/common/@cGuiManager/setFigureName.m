function obj_OUT = setFigureName(obj_IN, value_IN)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getFigureName.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Set the figure name
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      23/09/2013  Class creation
%	Mathieu CABANES         AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cGuiManager object
%   value_IN    : name of the figure to set
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cGuiManager object
%==========================================================================

% Manage input
% ------------
if ~ischar(value_IN); throw(ClassCastException(...
        'String required as input')); end;

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Get the figure name
% -------------------
obj_OUT.figure_name = value_IN;
%==========================================================================
