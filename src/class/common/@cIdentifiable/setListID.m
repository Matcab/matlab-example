function setListID(obj_IN, name_IN, value_IN, varargin)
%==========================================================================
%% VOLVO 3P 2011
%==========================================================================
% GSP 2.0
%==========================================================================
% FILENAME: setListID.m
% PATH    : ..\class\common\@cIdentifiable
%==========================================================================
% ABSTRACT: set a list of IDs
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      25/08/2011  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN  	: cIdentifiable object (unused)
%   name_IN     : type name
%   value_IN    : list of IDs to set
%   varargin    : pair parameter name/value
%==========================================================================
% OUTPUT:
%==========================================================================
% EXCEPTION:
%   ClassCastException
%==========================================================================

% Manage input arguments
% ----------------------
if ~isInteger(value_IN); throw(ClassCastException(...
        'Integer required as input')); end;

% Initialize default parameter
% ----------------------------
reset_action = false;

% Manage input arguments
% ----------------------
for var_i=1:2:length(varargin)

    switch(varargin{var_i})
    
        case 'reset'
        
            if ischar(varargin{var_i+1}) && strcmp(varargin{var_i+1},'on')
                
               reset_action = true;
            
            end

    end

end

% Reset element
% -------------
if (reset_action); obj_IN.manageID('reset', name_IN); end;

% Set new_list
% ------------
obj_IN.manageID('set', {name_IN, value_IN});
%==========================================================================
