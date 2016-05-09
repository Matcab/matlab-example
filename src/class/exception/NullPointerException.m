function obj_OUT = NullPointerException(varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: NullPointerException.m
% PATH    : class\exception
%==========================================================================
% ABSTRACT: "Create a NullPointer" exception 
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      25/07/2011  Creation
%   Marc BALME              AROB@S      29/09/2011  Update to manage added
%                                                   exception
%	Mathieu CABANES         AROB@S      28/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM: 
%==========================================================================
% INPUT:
%   varargin    : possibility to customize the error message
%==========================================================================
% OUTPUT:
%   obj_OUT     : MException customized
%==========================================================================
% Initialize variable
% -------------------
added_cause = {};

% Create message
% --------------
% Default message text
message='The element is empty';

% User defined message
for var_i=1:length(varargin)

    if ischar(varargin{var_i})
    
        message = varargin{var_i};
    
    elseif isa(varargin{var_i}, 'MException')
    
        added_cause{end+1} = varargin{var_i}; %#ok<AGROW>
    
    end

end

% Define output exception object
% ------------------------------
obj_OUT = MException('MATLAB:NullPointerException', '%s', message);

% Add other exceptions if necessary
% ---------------------------------
for var_i=1:length(added_cause)

    obj_OUT = obj_OUT.addCause(added_cause{var_i}); 

end
%==========================================================================
