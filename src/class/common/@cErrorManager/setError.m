function obj_OUT = setError(obj_IN, varargin)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setError.m
% PATH: ..\common\@cErrorManager
%==========================================================================
% ABSTRACT: Set the error
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      23/10/2013  Class creation
%	Michel OLPHE GALLIARD 	AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%   varargin    : command line arguments to setError (see VARARGIN)
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cErrorManager object
%==========================================================================

% Manage input arguments
% ----------------------
if nargin>1 && ~isa(varargin{1}, 'MException') && ~iscell(varargin{1}) && ...
         ~ischar(varargin{1})
     
    throw(ClassCastException('MException or string required as input'));

end

if nargin>2 && ~ischar(varargin{2})

    throw(ClassCastException('String required as input'));

end

if nargin >1 && iscell(varargin{1})
    
    all_exception = varargin{1};
    
else
    
    all_exception{1} = varargin;
    
end

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Define the index of the new error
% ---------------------------------
for i_exception = 1:length(all_exception)
    
    % Define index of the next exception
    if isempty(obj_OUT.error(1).exception)
        
        error_index = 1;
        
    else
        
        error_index = length(obj_OUT.error)+1;
        
    end
    
    if ~isempty(all_exception{1,i_exception}) && ...
            (isa(all_exception{1,i_exception}, 'MException') || ...
            (iscell(all_exception{1,i_exception}) && ...
            isa(all_exception{1,i_exception}{1,1}, 'MException')))
        
        % Get the current exception
        if iscell(all_exception{1,i_exception})
            
            current_exception = all_exception{1,i_exception}{1,1};
            
        else
            
            current_exception = all_exception{1,i_exception};
            
        end
        
        % Set the exception
        obj_OUT.error(error_index).exception = current_exception;
        
        % Define exception type
        current_identifier = regexp(current_exception.identifier, ':', ...
            'split');
        
        % Set the corresponding type
        if iscell(all_exception{1,i_exception}) && ...
                length(all_exception{1,i_exception}) > 1 && ...
                ischar(all_exception{1,i_exception}{1,2}) && ...
                strcmpi(all_exception{1,i_exception}{1,2}, 'warning')
            
            obj_OUT.error(error_index).type      = 'warning';
            
        elseif strcmpi(current_identifier{1,1}, obj_OUT.applicative_id)
            
            obj_OUT.error(error_index).type      = 'applicative_error';
            
        else
            
            obj_OUT.error(error_index).type      = 'system_error';
            
        end
        
    elseif ~isempty(all_exception{1,i_exception}) && ...
            (ischar(all_exception{1,i_exception}) || ...
            (iscell(all_exception{1,i_exception}) && ...
            ischar(all_exception{1,i_exception}{1,1})))
        
        % Define the message
        if iscell(all_exception{1,i_exception})
            
            error_message = all_exception{1,i_exception}{1,1};
            
        else
            
            error_message = all_exception{1,i_exception};
            
        end
        
        % Differentiate warning from errors
        if iscell(all_exception{1,i_exception}) && ...
                length(all_exception{1,i_exception}) > 1 && ...
                ischar(all_exception{1,i_exception}{1,2}) && ...
                strcmpi(all_exception{1,i_exception}{1,2}, 'warning')
            
            message_id   = [upper(obj_OUT.applicative_id), ':Warning'];
            current_type = 'warning';
            
        else
            
            message_id   = [upper(obj_OUT.applicative_id), ...
                ':ApplicativeError'];
            current_type = 'applicative_error';
            
        end
        
        % Define the corresponding exception
        current_exception = MException(message_id, error_message);
        
        % Set the exception
        obj_OUT.error(error_index).exception = current_exception;
        
        % Set the corresponding type
        obj_OUT.error(error_index).type      = current_type;
        
    end
    
end
%==========================================================================
