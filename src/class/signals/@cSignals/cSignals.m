classdef cSignals < cInfos & cIdentifiable
    %======================================================================
    %% VOLVO GTT 2014
    %======================================================================
    % MATLAB CLASS
    %======================================================================
    % FILENAME: cSignals.m
    % PATH    : $TEMPLATE_HOME$\test\@cSignalsTest
    %======================================================================
    % ABSTRACT: Signals class
    %======================================================================
    % REVISION HISTORY:
    %   AUTHOR                  COMPANY     DATE        COMMENT
    %	Mathieu CABANES         AROB@S      07/07/2014  Creation
    %
    %   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
    %======================================================================
    % ALGORITHM:
    %======================================================================
    % INPUT:
    %======================================================================
    % OUTPUT:
    %======================================================================
    
    % Attributes
    % ----------
    properties
        
        filename = '';
        data     = [];
        
    end
    
    properties (Dependent = true)
        
        signals_list;
        
    end
    
    % Methods
    % -------
    methods
        
        function obj_OUT = cSignals(varargin)
            %==============================================================
            %% DESCRIPTION: Overloaded constructor method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   varargin    : pair of attribute & attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : cSignals object
            %==============================================================
            
            % Define a new ID for the object
            % ------------------------------
            obj_OUT = obj_OUT.manageID('new', 'cSignals');
            
            % Manage input argument
            % ---------------------
            if nargin>0
                
                for var_i=1:2:length(varargin)
                    
                    if isprop(obj_OUT, varargin{var_i}) && ...
                            strcmp(varargin{var_i}, 'label')
                        
                        obj_OUT = obj_OUT.setLabel(varargin{var_i+1});
                    
                    elseif isprop(obj_OUT, varargin{var_i})
                        
                        obj_OUT.(varargin{var_i}) = varargin{var_i+1};
                        
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
        function list_OUT = get.signals_list(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the Applicative error identifier
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN      : cConfiguration object
            %==============================================================
            % OUTPUT:
            %   name_OUT  	: short name of the software
            %==============================================================
            
            % Get the data structure
            % ----------------------
            current_data = obj_IN.getData;
            
            list_OUT = LocalDefineSignalsList(current_data);
            
            function list_OUT = LocalDefineSignalsList(struct_IN, varargin)
                
                % Initialize variables
                list_OUT  = struct('name',{{}}, ...
                        'unit', {{}}, 'value', {{}});
                root_name = '';
                
                % Manage input arguments
                if nargin>1 && ischar(varargin{1}); root_name = varargin{1}; end;
                if nargin>2 && isstruct(varargin{2}); list_OUT = varargin{2}; end;
                
                % Manage empty structure
                if isempty(struct_IN);  return; end;
                
                % Define fieldnames
                current_fields = fieldnames(struct_IN);
                
                for i_field = 1:length(current_fields)
                    
                    % Define the current root name
                    if ~isempty(root_name)
                        
                        tmp_name = [root_name, '.', current_fields{i_field}];
                        
                    elseif strfind(current_fields{i_field}, '_out')
                        
                        tmp_name = current_fields{i_field};
                        
                    else
                        
                        continue;
                        
                    end
                    
                    % Define the list
                    if isstruct(struct_IN.(current_fields{i_field}))
                        
                        list_OUT = LocalDefineSignalsList(struct_IN.(...
                            current_fields{i_field}), tmp_name, list_OUT);
                        
                    elseif isnumeric(struct_IN.(current_fields{i_field})) && ...
                            length(struct_IN.(current_fields{i_field}))>1
                        
                        % Define the name
                        list_OUT.name{end+1} = tmp_name;
                        
                        % Define the unit
                        tmp_unit = regexp(current_fields{i_field}, '_', 'split');
                        
                        if ~isempty(tmp_unit) && length(tmp_unit)>1
                            
                            list_OUT.unit{end+1} = tmp_unit{end};
                            
                        else
                            
                            list_OUT.unit{end+1} = '';
                            
                        end
                        
                        % Define the value
                        list_OUT.value{end+1} = ...
                            struct_IN.(current_fields{i_field});
                        
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
    end
    
end
%==========================================================================
