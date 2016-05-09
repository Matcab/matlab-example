function obj_OUT = setFileName(obj_IN, name_IN)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: setName.m
% PATH    : $TEMPLATE_HOME$\src\class\signals\cSignals
%==========================================================================
% ABSTRACT: cSignals object method: define the signal name
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
%   obj_IN 	: cSignals object
%   name_IN	: name of the signals set
%==========================================================================
% OUTPUT:
%   obj_OUT	:  updated cSignals object
%==========================================================================

% Manage input arguments
% ----------------------
if ~ischar(name_IN); throw(ClassCastException(['String is required as ', ...
        'signals set file name'])); end;

if exist(name_IN, 'file')~=2; throw(FileNotFoundException(sprintf(...
        'The file %s does not exist', name_IN))); end;

% Define the filename extension
[~,~,file_ext] = fileparts(name_IN);

if ~strcmpi(file_ext, '.mat'); throw(IllegalArgumentException(sprintf(...
        'The file %s is not a MAT file', name_IN))); end;

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Define the name
% ---------------
obj_OUT.filename = name_IN;
%==========================================================================
