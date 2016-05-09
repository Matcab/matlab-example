function struct_OUT = getElementNameList(obj_IN)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getElementNameList.m
% PATH    : $TEMPLATE_HOME$\class\signals\@cSignalsData
%==========================================================================
% ABSTRACT: function to get the name, file and ID of the different element
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      07/07/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cSignalsData object
%   varargin    : element name and corresponding value (optional used to
%                 filter list)
%==========================================================================
% OUTPUT:
%   struct_OUT  : structure of the element names and IDs
%==========================================================================
% EXCEPTION:
%   NoSuchFieldException
%==========================================================================

% Initialize output
% -----------------
struct_OUT = [];

% Initialize local variables
% --------------------------
idx           = 1;

% Define the list of elements
% ---------------------------
element_obj_list = obj_IN.getElement();

% initialize temp variable
% ------------------------
dimension     = length(element_obj_list);
temp_name     = cell(1,dimension);
temp_file     = cell(1,dimension);
temp_ID       = zeros(1,dimension);

% Get Element names
% -----------------
for list_i = 1:dimension
    
    % Define current element
    % ----------------------
    current_element = element_obj_list(list_i);
                
    % Get element selected informations
    % ---------------------------------
    temp_name{idx}     = current_element.getName();
    temp_ID(idx)       = current_element.getID();
    temp_file{idx}     = current_element.getFileName();
    
    % increment number of element in the structure fields
    idx = idx + 1;
    
end

% Update output
% -------------
struct_OUT.name     = temp_name;
struct_OUT.ID       = temp_ID;
struct_OUT.file     = temp_file;
%==========================================================================
