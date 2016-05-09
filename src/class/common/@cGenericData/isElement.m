function status_OUT = isElement(obj_IN, element_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: isElement.m
% PATH    : ..\class\common\@cGenericData
%==========================================================================
% ABSTRACT: equivalent ismember for cGenericData and its element but group
% is in second argument (due to function calling problem)
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      19/05/2011  Creation
%   Marc BALME              AROB@S      25/07/2011  Standards update
%	Mathieu CABANES         AROB@S      22/01/2013  Migration to MATLAB
%                                                   2011b
%   Michel OLPHE-GALLIARD   AROB@S      10/06/2013  Speed optimization
%   Michel OLPHE-GALLIARD   AROB@S      24/01/2014  Speed Optimization
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN     	: cGenericData object
%   element_IN 	: cElement object
%==========================================================================
% OUTPUT:
%   boolean_OUT : value of the element(0=not present, 1 = ID existing)
%==========================================================================
% EXCEPTION:
%   ClassCastException
%==========================================================================

% Manage input argument
% ---------------------
if ~isa(element_IN, class(obj_IN.element)) && ~ischar(element_IN);
    
    throw(ClassCastException([class(obj_IN.element) ' or string' ...
        ' required as element name']));

end

% Initialise output
% -----------------
status_OUT = false;

% Initialize local variable
% -------------------------
position_i = 1;

% Get list of element
% -------------------
element_obj_list = obj_IN.getElement();

while ~status_OUT && position_i<=length(element_obj_list)
    
    % check element value
    % -------------------
    if ischar(element_IN) && strcmp(element_IN, ...
            getName(element_obj_list(position_i)))
        
        status_OUT = true;
    
    elseif ~ischar(element_IN) && getID(element_obj_list(...
            position_i))==element_IN.getID()
        
        status_OUT = true;
    
    end
    
    position_i = position_i+1;

end
%==========================================================================
