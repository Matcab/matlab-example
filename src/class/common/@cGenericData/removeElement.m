function obj_OUT = removeElement(obj_IN, name_IN, varargin)
%==========================================================================
%% VOLVO 3P 2011
%==========================================================================
% GSP 2.0
%==========================================================================
% FILENAME: removeElement.m
% PATH    : ..\class\common\@cGenericData
%==========================================================================
% ABSTRACT: Remove one element from the cGenericData
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      08/04/2011  Creation
%	Marc BALME              AROB@S      01/06/2011  ID management
%   Marc BALME              AROB@S      25/07/2011  Standards update
%   Marc BALME              AROB@S      30/08/2011  bug fixed when all
%                                                    elements were remove
%	Mathieu CABANES         AROB@S      22/01/2013  Migration to MATLAB
%                                                   2011b
%   Michel OLPHE-GALLIARD   AROB@S      17/07/2013  Bug correction when
%                                                   list empty
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cGenericData to update
%   name_IN     : name of the vehicle to add
%   varargin    ; not used for the moment
%==========================================================================
% OUTPUT: 
%   obj_OUT     : modified cGenericData
%==========================================================================
% EXCEPTION:
%   ClassCastException
%==========================================================================

% Manage input argument
% ---------------------
if ~ischar(name_IN); throw(ClassCastException(...
        'String required as name element')); end;

% Check varargin
% --------------
is_IDselection = false;

if ~isempty(varargin)

    if strcmp(name_IN, 'ID') && isnumeric(varargin{1})
    
        ID_IN = varargin{1};
        
        if (~isInteger(ID_IN) || ~length(ID_IN)==1); throw(...
                ClassCastException('Integer required as ID')); end;

        is_IDselection = true;
    
    end

end

% Initialize variable
% -------------------
% output variable
obj_OUT = obj_IN;

% local variable
parent_test = [];

% Get previous element list
% -------------------------
element_list = obj_IN.element;

% Initialize index to remove
% --------------------------
new_Hashmap = obj_OUT.Hashmap;

% Initialize the remove flag
is_removed = false;
var_i      = 1;

% Get name list
% -------------
while var_i<=length(element_list)

    if is_IDselection
    
        if getID(element_list(var_i))==ID_IN
        
            % remove the element from the list
            element_list(var_i)  = [];
            new_Hashmap(var_i,:) = [];
            is_removed           = true;
            var_i                = var_i-1;
            
        elseif is_removed
            
            new_Hashmap(var_i,2) = new_Hashmap(var_i,2)-1;
        
        end

    else

        % Check the name
        if strcmp(getName(element_list(var_i)), name_IN) 
            
            if exist('cTest','file') && isa(element_list(var_i), ...
                    class(cTest))
                
                parent_test = getParent(element_list(var_i));
                id_remove   = getID(element_list(var_i));
            
            end
            
            % remove the element from the list
            element_list(var_i)  = [];
            new_Hashmap(var_i,:) = [];
            is_removed           = true;
            var_i                = var_i-1;
            
        elseif is_removed
            
            new_Hashmap(var_i,2)=new_Hashmap(var_i,2)-1;
            
        end

    end
    
    var_i = var_i+1;

end

%remove the test from the parent children-list
if ~isempty(parent_test)
    
    % check all the test to find the parent
    for i_test=1:length(element_list)
        
        if getID(element_list(i_test))==parent_test.ID
        
            % get the parent and children list
            parent   = element_list(i_test);
            children = parent.getChildren();
            
            % remove the test from the children-list
            i_child = 1;
            
            while i_child<=length(children)
            
                if children(i_child).ID == id_remove
                
                    children(i_child)=[];
                
                else
                    
                    i_child = i_child+1;
                
                end
                
            end
            
            % update the parent
            parent               = parent.setChildren(children);
            element_list(i_test) = parent;
        
        end
        
    end
    
end
    
% Update element list
% -------------------
obj_OUT.element = element_list;

% Update Hashmap
% --------------
if ~isempty(new_Hashmap)

    obj_OUT.Hashmap = new_Hashmap;

else
    
    % Element constructor
    % -------------------
    constructor_element = str2func(class(obj_IN.element));
    
    % Initialize new list
    % -------------------
    new_element_list = constructor_element();
    
    obj_OUT.Hashmap = [new_element_list.getID() 1];
    obj_OUT.element = new_element_list;

end

% Update Infos
% ------------
obj_OUT = obj_OUT.updateInfos();
%==========================================================================
