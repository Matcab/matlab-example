function obj_OUT = setLabel(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setLabel.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Set label
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      12/03/2013  Creation
%   Michel OLPHE-GALLIARD   AROB@S      17/04/2013  Modification
%                                                   Decomposition of setCo-
%                                                   ntent in multiple step)
%	Michel OLPHE GALLIARD 	AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cInfos object
%   value_IN  	: value to set
%==========================================================================
% OUTPUT:
%   obj_OUT    	: updated object
%==========================================================================

% Manage input argument
% ---------------------
if nargin>1 && ~isstruct(varargin{1}); throw(ClassCastException(...
        'Structure required as input')); end;

% Initialize output object
% ------------------------
obj_OUT = obj_IN;

% Define available languages
% --------------------------
available_languages = obj_OUT.available_languages;

% Define the input values
% -----------------------
if nargin > 1
    
    value = varargin{1};
    
else
    
    value = struct();
    
end

% Define current label
% --------------------
current_label     = obj_IN.label;
current_languages = {};
    
for i_label = 1:length(current_label)
    
    current_languages{i_label} = ...
        current_label(i_label).getLanguage; %#ok<AGROW>
    
end

% Define the labels
% -----------------
for i_language = 1:length(available_languages)
    
    if ~isempty(current_languages{1}) && ...
            ismember(available_languages{i_language}, current_languages)
        
        temp_label = current_label(strcmpi(current_languages, ...
            available_languages{i_language}));
        
        if isfield(value, available_languages{i_language}) && ...
                ~isempty(value.(available_languages{i_language}))
        
            temp_label = temp_label.setContent(value.(...
                available_languages{i_language}));
        
        else

            temp_label = temp_label.setContent('');           
            
        end
            
        current_label(strcmpi(current_languages, ...
            available_languages{i_language})) = temp_label;
        
    else
        
        if isfield(value, available_languages{i_language})
        
            new_label = cLabel('language', available_languages{i_language}, ...
                'content',  value.(available_languages{i_language}));
        
        else
            
            new_label = cLabel('language', available_languages{i_language}, ...
                'content',  '');

        end
        
        if isempty(current_label(end).getLanguage())
            
            current_label(end) = new_label;
            
        else
            
            current_label(end+1) = new_label; %#ok<AGROW>
            
        end
        
    end
    
end

% update label
% ------------
obj_OUT.label = current_label;

% Update element
% --------------
obj_OUT = updateInfos(obj_OUT);
%==========================================================================
