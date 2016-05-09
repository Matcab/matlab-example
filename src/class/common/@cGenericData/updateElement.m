function obj_OUT = updateElement(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: updateElement.m
% PATH    : ..\class\common\@cGenericData
%==========================================================================
% ABSTRACT: Update element from the cGenericData
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      08/04/2011  Creation
%   Marc BALME              AROB@S      01/06/2011  Add ID management
%   Marc BALME              AROB@S      25/07/2011  Standards update
%	Mathieu CABANES         AROB@S      22/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cGenericData to update
%   name_IN     : name of the vehicle to add
%   element_IN  : updated element
%==========================================================================
% OUTPUT:
%   obj_OUT     : modified cGenericData
%==========================================================================
% EXCEPTION:
%   ClassCastException
%==========================================================================

% Manage input argument
% ---------------------
if ~ischar(varargin{1}); throw(ClassCastException(...
        'String required as name element')); end;

% Check input
if strcmp(varargin{1}, 'ID') && isnumeric(varargin{2})
    
    ID_active  = true;
    ID_IN      = varargin{2};
    element_IN = varargin{3};
    
    
    if (~isInteger(ID_IN) || ~length(ID_IN)==1); throw(...
            ClassCastException('Integer required as ID')); end;
    
else
    
    ID_active  = false;
    name_IN    = varargin{1};
    element_IN = varargin{2};
    
end

% Check class of the element
if ~isa(element_IN, class(obj_IN.element)); throw(ClassCastException(...
        [class(obj_IN.element), ' required as element type'])); end;

% Initialize output
% -----------------
obj_OUT = obj_IN;

% Initialize output
% -----------------
update_DONE = false;
list_i      = 1;

% Get previous element list
element_list = obj_IN.element;

while ~update_DONE && list_i<=length(element_list)
    
    if ID_active
        
        %check the name
        if getID(element_list(list_i))==ID_IN;
            
            %update the element
            element_list(list_i) = element_IN;
            update_DONE          = true;
            
        end
        
    elseif strcmp(element_list(list_i).name,name_IN)
        
        %update the element
        element_list(list_i) = element_IN;
        update_DONE          = true;
        
    end
    
    list_i=list_i+1;
    
end

% Update element list
% -------------------
obj_OUT.element = element_list;

% Update Infos
% ------------
obj_OUT = obj_OUT.updateInfos();
%==========================================================================
