function handle_OUT = getParentFigureHandle(obj_IN)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getParentFigureHandle.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Get the parent figure handle
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
%   obj_IN      : GuiManager object
%==========================================================================
% OUTPUT:
%   handle_OUT 	: Handle of the parent figure
%==========================================================================

% Get the figure name
% -------------------
handle_OUT = obj_IN.parent_figure_handle;
%==========================================================================
