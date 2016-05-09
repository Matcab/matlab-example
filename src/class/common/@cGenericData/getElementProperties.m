function element_OUT = getElementProperties(obj_IN, name_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getElementProperties.m
% PATH    : ..\class\common\@cGenericdata
%==========================================================================
% ABSTRACT: get the element associated with the name or the ID
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      08/04/2011  Creation
%   Marc BALME              AROB@S      11/05/2011  Management of the ID
%   Marc BALME              AROB@S      25/07/2011  Standards update
%	Mathieu CABANES         AROB@S      22/01/2013  Migration to MATLAB
%                                                   2011b
%   Michel OLPHE-GALLIARD   AROB@S      10/06/2013  Speed optimization
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : generic_data object
%   name_IN     : name of the element
%   varargin    : allows set an ID instead of a name
%==========================================================================
% OUTPUT: 
%   element_OUT : element object
%==========================================================================
% EXCEPTION:
%   ClassCastException
%==========================================================================

% Manage input arguments
% ----------------------
if ~ischar(name_IN)
    
    throw(ClassCastException('String required as name element'));

end

% Initialize output
% -----------------
element_OUT = [];

% Initialize filter variables
% ---------------------------
search_name = true;
ID_number   = 0;

if nargin==3

    if isnumeric(varargin{1}) && strcmp(name_IN, 'ID')
    
        % Update data
       search_name = false;
       ID_number   = varargin{1};

       if (~isInteger(varargin{1}) || ~length(varargin{1})==1); ...
               throw(ClassCastException('Integer required as ID')); end;

    end

end

% Get element
% -----------
element_obj_list = obj_IN.element;

if search_name
    
    list_i = 1;
    idx    = 0;

    % find the correct element
    while ~idx && list_i<=length(element_obj_list)
       
        
        if strcmp(name_IN,element_obj_list(list_i).name)
            
            % Get name
            idx = list_i;
            
        end
        
        % Set output element
        list_i = list_i+1;
    end
    
    if idx; element_OUT = element_obj_list(idx); end;

else
    
    list_i = 1;
    idx    = 0;

    % find the correct element
    while ~idx && list_i<=length(element_obj_list)
       
        
        if ID_number==getID(element_obj_list(list_i))
            
            % Get name
            idx=list_i;
            
        end
        
        % Set output element
        list_i = list_i+1;
    end
    
    if idx; element_OUT = element_obj_list(idx); end;

end
%==========================================================================
