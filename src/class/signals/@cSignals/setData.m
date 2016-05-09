function obj_OUT = setData(obj_IN, value_IN)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: setData.m
% PATH    : $TEMPLATE_HOME$\src\class\signals\cSignals
%==========================================================================
% ABSTRACT: cSignals object method: define the signal data
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES       	AROB@S      07/07/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cSignals object
%   value_IN	: data
%==========================================================================
% OUTPUT:
%   obj_OUT	:  updated cSignals object
%==========================================================================

% Manage input arguments
% ----------------------
if ~isstruct(value_IN); throw(ClassCastException(['Structure is required as ', ...
        'signals data'])); end;

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Define the name
% ---------------
obj_OUT.data = value_IN;
%==========================================================================
