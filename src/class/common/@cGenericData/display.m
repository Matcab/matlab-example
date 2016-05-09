function display(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: display.m
% PATH    : ..\common\@cCheckboxTree
%==========================================================================
% ABSTRACT: Display function of cCheckboxTree
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      29/06/2011  Creation
%	Mathieu CABANES      	AROB@S      17/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cCheckboxTree object
%   varargin    : display type
%==========================================================================
% OUTPUT: 
%==========================================================================

% Define corresponding meta class
% -------------------------------
class_informations = meta.class.fromName(class(obj_IN));

% Display information to the user
% -------------------------------
disp('----------------------------------------');
disp(['*** Object (class ', class(obj_IN), ') attributes:']);

% List class property
% -------------------
for i_prop = 1:length(class_informations.PropertyList)

    property_name = class_informations.PropertyList(i_prop, 1).Name;
    
    if ishandle(obj_IN.(property_name))
        
        disp(['    - ', property_name, ': handle object ']);      

    elseif isobject(obj_IN.(property_name))
        
        disp(['    - ', property_name, ': object (class ', ...
            class(obj_IN.(property_name)), ')']);
        
    elseif ischar(obj_IN.(property_name))
        
        disp(['    - ', property_name, ': ''', ...
            obj_IN.(property_name), '''']);
        
    elseif isstruct(obj_IN.(property_name))
        
        disp(['    - ', property_name, ': structure (', ...
            num2str(length(fieldnames(obj_IN.(property_name)))), ...
            ' fields)']);        

    elseif iscell(obj_IN.(property_name))
        
        disp(['    - ', property_name, ': cell array (size ', ...
            num2str(size(obj_IN.(property_name))), ')']);        
    
    elseif islogical(obj_IN.(property_name))
        
        property_value = 'false';
        if obj_IN.(property_name); property_value = 'true'; end;
        
        disp(['    - ', property_name, ': ', property_value]);
        
    elseif isscalar(obj_IN.(property_name))
        
         disp(['    - ', property_name, ': ', ...
             num2str(obj_IN.(property_name))]);
       
    elseif isvector(obj_IN.(property_name))
        
        disp(['    - ', property_name, ': vector (size ', ...
            num2str(size(obj_IN.(property_name))), ')']); 

    elseif isnumeric(obj_IN.(property_name))
        
        disp(['    - ', property_name, ': matrix (size ', ...
            num2str(size(obj_IN.(property_name))), ')']);
           
    end
    
end

if nargin==1
    
    disp('');
    disp('----------------------------------------');
    disp(obj_IN);

elseif nargin>1 && ischar(varargin{1}) && strcmpi(varargin{1}, 'long')
    
    % Display information to the user
    % -------------------------------
    disp('');
    disp('----------------------------------------');
    disp(['*** Object (class ', class(obj_IN), ') methods:']);
    
    % List class property
    % -------------------
    for i_prop = 1:length(class_informations.MethodList)
        
        disp(['    - ', class_informations.MethodList(i_prop, 1).Name]);
        
    end
    
end

disp('----------------------------------------');
%==========================================================================
