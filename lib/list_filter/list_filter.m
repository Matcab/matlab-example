function varargout = list_filter(varargin)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: list_filter.m
% PATH    : $TEMPLATE_HOME$\src\lib\list_filter
%==========================================================================
% ABSTRACT: Matlab standard list filter
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES       	AROB@S      08/07/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   list_IN             : cell containing the initial list
%   filter_pattern_IN   : string pattern used to filter the list
%==========================================================================
% OUTPUT:
%   list_OUT            :  cell containing the filterd list
%==========================================================================

% Check input arguments
% ---------------------
if (nargin == 0) || (nargin~=2)
    
    disp('=================================================');
    disp('LIST FILTER: Filter a list with a string pattern.');
    disp('=================================================');
    disp(' -> usage: list_OUT = list_filter(list_IN, filter_pattern_IN)');
    disp(' -> with:');
    disp('    ** list_IN is a cell array');
    disp('    ** filter_pattern_IN is a string');
    disp('    ** list_OUT is a cell array');
    disp('=================================================');
    return;
    
else
    
    % Define input arguments
    list           = varargin{1};
    filter_pattern = varargin{2};
    
    % Check input arguments
    assert(iscell(list), 'ListFilter:CheckInputArguments', ['The first ', ...
        'argument should be the targeted list to filter and is a cell array ', ...
        'of strings']);
    
    assert(ischar(filter_pattern), 'ListFilter:CheckInputArguments', ...
        'The second argument should be the filter pattern and is a string');
    
end

% Define filter option
% --------------------
regexp_opt = 'matchcase';

% Define the output
% -----------------
selected_index = cell2mat(cellfun(@(x) (~isempty(x)), ...
    regexp(list, ['^', strrep(filter_pattern, '*', '.*')], ...
    regexp_opt), 'UniformOutput', false));

if nargout>0; varargout{1} = list(selected_index); end;
if nargout>1; varargout{2} = find(selected_index==1); end;
%==========================================================================
