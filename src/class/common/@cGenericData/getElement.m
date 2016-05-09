function value_OUT = getElement(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getElement.m
% PATH    : ..\class\common\@cGenericData
%==========================================================================
% ABSTRACT: Get element
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      21/07/2011  Creation
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
%   obj_IN      : cGenericData object
%   varargin  	: optional to define a particular element
%==========================================================================
% OUTPUT:
%   value_OUT  	: element list or single element
%==========================================================================
% EXCEPTION:
%   ClassCastException
%   cGenericData:UnkownElement
%==========================================================================

% Manage input
% ------------
if nargin >= 2 && ~ischar(varargin{1})
    
    throw(ClassCastException('String required as element name'));

end

% Treat collection according to input arguments
% ---------------------------------------------
if nargin == 1

    value_OUT = obj_IN.element;
    
elseif nargin >=2 
    
    % Initialize the output the right component
    % -----------------------------------------
    element_index = 0;
    element_found = false;
    
    % Define element and element list
    elements      = obj_IN.getElement();
    selected_name = varargin{1};
    
    while ~element_found && element_index<length(elements)
        
        element_index = element_index+1;
        element_found = strcmp(selected_name,elements(element_index).name);        
        
    end
    
    if ~element_found
        
        assert(element_found, 'cGenericData:UnkownElement', ...
            'Impossible to find the element %s in the selected collection.', ...
            varargin{1});
    else
        
        % Define the specific element
        value_OUT = elements(element_index);
    end

end
%==========================================================================
