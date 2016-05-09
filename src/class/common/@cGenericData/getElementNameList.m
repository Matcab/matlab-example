function struct_OUT = getElementNameList(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getElementNameList.m
% PATH    : ..\class\@cGenericData
%==========================================================================
% ABSTRACT: function to get the name and ID of the different elements
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      08/04/2011  Creation
%   Marc BALME              AROB@S      25/07/2011  Standards update
%	Mathieu CABANES         AROB@S      22/01/2013  Migration to MATLAB
%                                                   2011b
%   Michel OLPHE-GALLIARD   AROB@S      31/05/2013  Speed optimization
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cGenericData object
%   varargin    : not used for the moment    
%==========================================================================
% OUTPUT: 
%   struct_OUT  : structure of the element names and IDs
%==========================================================================

% Get elements
% ------------
element_obj_list = obj_IN.element;

% create the variable
% -------------------
dimension = length(element_obj_list);
temp_name = cell(1,dimension);

% Get element names
% -----------------
for list_i = 1:dimension

    temp_name{list_i} = getName(element_obj_list(list_i));

end

struct_OUT.name = temp_name;
struct_OUT.ID   = getID(element_obj_list);
%==========================================================================
