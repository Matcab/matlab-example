function varargout = getError(obj_IN, varargin)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getError.m
% PATH: ..\common\@cErrorManager
%==========================================================================
% ABSTRACT: Get the error
%==========================================================================
% REVISION HISTORY:
%   AUTHOR              COMPANY     DATE        COMMENT
%	Mathieu CABANES     AROB@S      23/10/2013  Class creation
%
%   <NAME>              <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : GuiManager object
%   varargin    : command line arguments to cErrorManager (see VARARGIN)
%==========================================================================
% OUTPUT:
%   varargout   : cell array for returning output args (see VARARGOUT)
%==========================================================================

% Initialize local variable
% -------------------------
selection_mode = 'default';
selected_index = 1;

% Manage input arguments
% ----------------------
if nargin > 1 
   
    for i_arg = 1:length(varargin)
       
        if ischar(varargin{i_arg}) && ...
                ismember(varargin{i_arg}, [fieldnames(obj_IN.error)', 'all']);
           
            selection_mode = varargin{i_arg};

        elseif ischar(varargin{i_arg}) && strcmpi(varargin{i_arg}, 'last')
            
            selected_index = length(obj_IN.error);
       
        elseif ischar(varargin{i_arg}) && strcmpi(varargin{i_arg}, 'first')
            
            selected_index = 1;
            
        elseif isnumeric(varargin{i_arg})

            if varargin{i_arg} <= 0 
                
                selected_index = ...
                    max(1, length(obj_IN.error)+varargin{i_arg});
 
            elseif varargin{i_arg} > 0

                selected_index = ...
                    min(1+varargin{i_arg}, length(obj_IN.error));
            
            end
            
        end
        
    end
    
end
    
% Get the requested error information
% -----------------------------------
if strcmpi(selection_mode, 'default')
    
    varargout{1} = obj_IN.error(selected_index).exception;
    
    if nargout > 1; varargout{2} = obj_IN.error(selected_index).type; end;

elseif strcmpi(selection_mode, 'all')
   
    varargout{1} = obj_IN.error;
 
    
else
    
    varargout{1} = obj_IN.error(selected_index).(selection_mode);
    
end
%==========================================================================
