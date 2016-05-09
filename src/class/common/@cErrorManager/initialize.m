function obj_OUT = initialize(obj_IN, varargin)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: initialize.m
% PATH: ..\common\@cErrorManager
%==========================================================================
% ABSTRACT: Initialize the error
%==========================================================================
% REVISION HISTORY:
%   AUTHOR      	COMPANY     DATE        COMMENT
%	Mathieu CABANES	AROB@S      29/10/2013  Class creation
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%   varargin    : command line arguments to initialize (see VARARGIN)
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cErrorManager object
%==========================================================================

% Define output variable
% ----------------------
obj_OUT = obj_IN;

% Reinitialize error list
% -----------------------
obj_OUT.error = struct(...
    'exception', [], ...
    'type',      '');
%==========================================================================
