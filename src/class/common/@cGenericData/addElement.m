function obj_OUT = addElement(obj_IN, name_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: addElement.m
% PATH    : ..\class\common\@cGenericData
%==========================================================================
% ABSTRACT: Add element in the cGenericData object
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      04/04/2011  Creation
%   Marc BALME              AROB@S      25/07/2011  Standards update
%	Mathieu CABANES         AROB@S      22/01/2013  Migration to MATLAB
%                                                   2011b
%   Michel OLPHE-GALLIARD   AROBAS      10/06/2013  Speed optimization   
%	Mathieu CABANES         AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN          : cGenericData object to update
%   name_IN         : name of the element to add
%   varargin        : element_object to add (optional)
%==========================================================================
% OUTPUT: 
%   obj_OUT         : modified cGenericData
%==========================================================================
% EXCEPTION:
%   ClassCastException
%   cGenericData:IllegalInsertion
%==========================================================================

% Manage input argument
% ---------------------
if ~ischar(name_IN) || isempty(name_IN)

    throw(ClassCastException('Non empty string required as element name'));

end

if nargin == 3 && ~isa(varargin{1}, class(obj_IN.element))
    
    throw(ClassCastException([class(obj_IN.element), ...
        ' required as element type']));

end

% Initialize output
% -----------------
obj_OUT = obj_IN;

% Element constructor
% -------------------
constructor_element = str2func(class(obj_IN.element));

% Define current name
% -------------------
name = name_IN;

% An element is provided
% ----------------------
if nargin==3 && isa(varargin{1}, class(obj_IN.element))
    
    % Get new element
    new_element = varargin{1};
    
    % reinitialize the ID of the loaded element
    % -----------------------------------------
    new_element = new_element.manageID('remove', class(obj_IN.element),...
        'new', class(obj_IN.element));
    
    % update name
    new_element = setName(new_element, name);
    
else
    
    % Get the element list
    % --------------------
    element_struct = obj_IN.getElementNameList();
    element_name   = element_struct.name;
    
    % Check that the name is unique
    % -----------------------------
    while ismember(name, element_name); name = [name, '_2']; end; %#ok<AGROW>
    
    % No element is provided : create a new element
    % ---------------------------------------------
    new_element = constructor_element('name', name);
    
    
end

% Check ID unicity
% ----------------
if ismember(new_element.getID(), obj_OUT.Hashmap(:,1));
    
    throw(MException('cGenericData:IllegalInsertion',['ID : ', ...
        num2str(new_element.getID()), ' already present']));
    
end

% Get previous element list
% -------------------------
element_list = obj_IN.element;

if length(element_list)==1 && isempty(element_list(1).getName)
    
    element_list(1) = new_element;

else
    
    element_list(end+1) = new_element;

end

% Update
% ------
% Element list
obj_OUT.element = element_list;

% Hashmap
obj_OUT.Hashmap(length(element_list),:) = ...
    [new_element.getID() length(element_list)];

% Update cInfos
% -------------
obj_OUT = obj_OUT.updateInfos();
%==========================================================================
