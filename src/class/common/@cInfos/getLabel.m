function value_OUT = getLabel(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getName.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Get name
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      21/07/2011  Creation
%	Mathieu CABANES         AROB@S      04/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN    	: cInfos object
%==========================================================================
% OUTPUT:
%   value_OUT  	: name
%==========================================================================

% Manage input argument
% ---------------------
if nargin>1 && ischar(varargin{1})
    
    selected_language = varargin{1};
   
else 
    
    selected_language = 'all';
    
end

% Define the current label languages and content
% ----------------------------------------------
current_label     = obj_IN.label;
current_languages = {};

for i_label = 1:length(current_label)
    
    current_languages{i_label} = ...
        current_label(i_label).getLanguage; %#ok<AGROW>
    current_contents{i_label}  = ...
        current_label(i_label).getContent; %#ok<AGROW>

end

% Define label
% ------------
if ~isempty(current_languages{1})
    
    if strcmpi(selected_language, 'all')
        
        for i_label = 1:length(current_languages)
            
            value_OUT.(current_languages{i_label}) = ...
                current_contents{i_label};
            
        end
        
        value_OUT = orderfields(value_OUT);
    
    else
        
        value_OUT.(current_languages{strcmpi(current_languages, ...
            selected_language)}) = current_contents{strcmpi(...
            current_languages, selected_language)};
        
    end
    
else
    
    value_OUT = struct();

end
%==========================================================================
