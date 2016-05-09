function obj_OUT = replaceIdentifiable(obj_IN, struct_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: replaceIdentifiable.m
% PATH    : ..\common\@cGenericData
%==========================================================================
% ABSTRACT: Look inside each element to replace an ID if necessary
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      19/08/2011  Creation
%	Mathieu CABANES         AROB@S      09/12/2011  Standard update
%	Mathieu CABANES         AROB@S      22/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
% 	For each element:
%   	1. Look for suitable subelements
%       2. Modify it according the provided information
%==========================================================================
% INPUT:
%   obj_IN   	: cGenericData object
%   struct_IN  	: specific structure for replacement
%                 struct_IN = struct(...
%                       'type', char,...
%                      	'old_id', integer,...
%                     	'new_id', integer)
%                 old_id and new_id must have the same length
%==========================================================================
% OUTPUT:
%   obj_OUT 	: updated object
%==========================================================================
% EXCEPTION
%   ClassCastException
%==========================================================================
% EXAMPLE:
% struct_IN(1).type='cVehicle'
% struct_IN(1).old_id=[5 10 15 20];
% struct_IN(1).new_id=[6 19 20 30];
%
% struct_IN(2).type='cComponent'
% struct_IN(2).old_id=[1 2 3];
% struct_IN(2).new_id=[3 7 9];
%==========================================================================

% Manage input arguments
% ----------------------
if ~isstruct(struct_IN) || ~all(isfield(struct_IN, {'type','old_id', ...
        'new_id'}))
    
    throw(ClassCastException('Specifc structure required as element type'));

end

if ~ischar(struct_IN.type) || ~isInteger(struct_IN.old_id) || ...
        ~isInteger(struct_IN.new_id) || ...
        length(struct_IN.old_id)~=length(struct_IN.new_id)

    assert(false, 'cGenericData:IdManagement:IllegalStructureDefinition', ...
        'The input structure is not well defined!!');

end

% Initialize output object
% ------------------------
obj_OUT = obj_IN;

% Manage each element
% -------------------
for var_i=1:length(obj_OUT.element)

    obj_OUT.element(var_i) = LocalReplace(obj_OUT.element(var_i), ...
        struct_IN);

end
%==========================================================================

function obj_OUT = LocalReplace(obj_IN, struct_IN)
%==========================================================================
%% DESCRIPTION: Iterative function to look for the modification to apply
%==========================================================================
%% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN   	: cGenericData object
%   struct_IN  	: specific structure for replacement
%                 struct_IN = struct(...
%                       'type',char,...
%                    	'old_id',integer,...
%                    	'new_id',integer)
%                 old_id and new_id must have the same length
%==========================================================================
% OUTPUT:
%   obj_OUT 	: updated object
%==========================================================================

% Initialize output object
% ------------------------
obj_OUT = obj_IN;

% Check if the element ID must be changed
% ---------------------------------------
type_idx = arrayfun(@(x) isa(obj_OUT,x.type), struct_IN);

if any(type_idx)

    ID_idx = struct_IN(type_idx).old_id==getID(obj_OUT);
    
    if any(ID_idx)
    
        obj_OUT = obj_OUT.setID(struct_IN(type_idx).new_id(ID_idx));
    
    end

end

% Manage elements having potential subelements
% --------------------------------------------
switch (class(obj_OUT))

    case 'cVehicle'
    
        component_list = obj_OUT.getComponent();
        
        for var_i=1:length(component_list)
        
            component_list(var_i) = LocalReplace(component_list(var_i), ...
                struct_IN);
        
        end

        obj_OUT = obj_OUT.setComponent(component_list);
    
    case 'cScenario'
        
        component_list = obj_OUT.getComponent();
        
        for var_i=1:length(component_list)
        
            component_list(var_i) = LocalReplace(component_list(var_i), ...
                struct_IN);
        
        end

        obj_OUT = obj_OUT.setComponent(component_list);
    
    case 'cTest'
        
        obj_OUT = obj_OUT.setVehicle(LocalReplace(obj_OUT.getVehicle(), ...
            struct_IN));
        obj_OUT = obj_OUT.setScenario(LocalReplace(obj_OUT.getScenario(), ...
            struct_IN));

end
%==========================================================================
