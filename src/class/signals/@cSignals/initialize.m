function obj_OUT = initialize(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: initialize.m
% PATH    : $TEMPLATE_HOME$\src\class\signals\cSignals
%==========================================================================
% ABSTRACT: cSignals object method: load data into the data attribute
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
%==========================================================================
% OUTPUT:
%   obj_OUT	:  updated cSignals object
%==========================================================================

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Manage input arguments
% ----------------------
if nargin>1 && ischar(varargin{1}) && exist(varargin{1}, 'file')==2; ...
        obj_OUT = obj_OUT.setFileName(varargin{1}); end;

% Manage no files
% ---------------
if isempty(obj_OUT.getFileName); return; end;

% Load the data
% -------------
try
    
    % Get the data
    current_data = load(obj_OUT.getFileName, '-mat');
    
    % Save the data
    obj_OUT = obj_OUT.setData(current_data);
    
    % Define the name of the set
    [~, file_name, ~] = fileparts(obj_OUT.getFileName);
    
    signals_name = strrep(file_name, '_comp', '');
    signals_name = strrep(signals_name, '_unc', '');
    signals_name = strrep(signals_name, '_init', '');
    signals_name = strrep(signals_name, '_', ' ');

    obj_OUT = obj_OUT.setName(signals_name);

catch exception
    
    throw(IOException(sprintf('impossible to load the file "%s"', ...
        obj_OUT.getFileName)));
    
end
%==========================================================================

