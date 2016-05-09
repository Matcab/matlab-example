classdef cIdentifiable
    %======================================================================
    %% VOLVO GTT 2013
    %======================================================================
    % MATLAB CLASS
    %======================================================================
    % FILENAME: cIdentifiable.m
    % PATH    : ..\class\common\@cIdentifiable
    %======================================================================
    % ABSTRACT: cIdentifiable constructor
    %======================================================================
    % REVISION HISTORY:
    %   AUTHOR                  COMPANY     DATE        COMMENT
    %	Marc BALME              AROB@S      27/07/2011  Creation
    %	Mathieu CABANES         AROB@S      04/01/2013  Migration to MATLAB
    %                                                   2011b
    %	Michel OLPHE GALLIARD	AROB@S      10/09/2013  Update to avoid
    %                                                   redundancy when
    %                                                   MAT file object is
    %                                                   loaded
    %
    %   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
    %======================================================================
    % ALGORITHM:
    %======================================================================
    % INPUT:
    %   varargin    : pair of attribute & attribute value
    %======================================================================
    % OUTPUT:
    %   obj_OUT 	: cIdentifiable object
    %======================================================================
    
    % Protected attributes
    % --------------------
    properties (Access = protected)
        
        ID = [];
        
    end

    % Methods
    % -------
    methods
    
        function obj_OUT = cIdentifiable(varargin)
            %==============================================================
            %% DESCRIPTION: Overloaded constructor method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   varargin    : pair of attribute & attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : cIdentifiable object
            %==============================================================
            
            % Manage ID according to input argument
            % -------------------------------------
            obj_OUT = manageID(obj_OUT, varargin{:});
            
        end
        %==================================================================
        
        function [obj_OUT, varargout] = manageID(obj_IN, varargin)
            %==============================================================
            %% DESCRIPTION: manage ID method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN      : cIdentifiable object
            %   varargin    : pair of attribute & attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : cIdentifiable object
            %   varargin    : output
           %==============================================================
            
            % Define ID map
            % -------------
            persistent hashmap;
            
            % Define output variable
            % ----------------------
            obj_OUT = obj_IN;
                      
            % Initialize output
            % -----------------
            varargout={};
            
            % Initialize map
            % --------------
            if isempty(hashmap)
                hashmap=struct(); 
            end

            if nargin>2
                
                % Manage parameters
                % -----------------
                for var_i=1:2:length(varargin)
                    
                    switch(varargin{var_i})
                        
                        case 'new'
                            
                            % Create a new ID
                            % ---------------
                            name = varargin{var_i+1};
                            
                            if ischar(name)
                                
                                if isfield(hashmap, name)
                                    
                                    new_ID = max(hashmap.(name))+1;
                                    hashmap.(name)(end+1) = new_ID;
                                    
                                else
                                    
                                    new_ID = 1;
                                    hashmap.(name) = new_ID;
                                    
                                end
                                
                                obj_OUT.ID = new_ID;
                                
                            end
                            
                        case 'remove'
                            
                            % Create a new ID
                            % ---------------
                            name = varargin{var_i+1};
                            
                            if ischar(name)
                                
                                if isfield(hashmap, name)
                                    
                                    existing_ID = hashmap.(name);
                                    
                                    if any(existing_ID==obj_OUT.ID)
                                    
                                        hashmap.(name)(existing_ID==...
                                            obj_OUT.ID) = [];
                                    
                                    end
                                    
                                    if isempty(hashmap.(name))
                                    
                                        hashmap=rmfield(hashmap,name);
                                    
                                    end
                                    
                                end
                                
                                obj_OUT.ID = 0;
                                
                            end
                            
                        case 'get'
                            
                            % get current ID
                            % --------------
                            name = varargin{var_i+1};
                            
                            if ischar(name) && isfield(hashmap, name)
                                
                                varargout{end+1} = ...
                                    hashmap.(name); %#ok<AGROW>
                                
                            elseif ischar(name)
                                
                                varargout{end+1} = []; %#ok<AGROW>
                                
                            end
                                                            
                        case 'reset'
                            
                            % Remove current ID
                            % -----------------
                            name = varargin{var_i+1};
                            
                            if ischar(name) && isfield(hashmap, name)
                                
                                hashmap.(name) = [];
                                
                            elseif ischar(name) && strcmp(name, 'all')
                                partial_save=hashmap;
                                
                                hashmap = struct();
                                
                                if isfield(partial_save,'cParameter')
                                    hashmap.cParameter=partial_save.cParameter;
                                end
                                if isfield(partial_save,'cComponent')
                                    hashmap.cComponent=partial_save.cComponent;
                                end
                                if isfield(partial_save,'cConcept')
                                    hashmap.cConcept=partial_save.cConcept;
                                end
                                if isfield(partial_save,'cAnalysis')
                                    hashmap.cAnalysis=partial_save.cAnalysis;
                                end
                                if isfield(partial_save,'cScript')
                                    hashmap.cScript=partial_save.cScript;
                                end
                                if isfield(partial_save,'cFormula')
                                    hashmap.cFormula=partial_save.cFormula;
                                end
                                
                            end
                            
                        case 'set'
                            
                            % Define the ID
                            parameter = varargin{var_i+1};
                            
                            if iscell(parameter) && length(parameter)==2
                                
                                % Get type
                                name  = parameter{1};
                                
                                % Get ID list
                                value = parameter{2};
                                
                                if ischar(name) && isInteger(value)
                                    
                                    for idx=1:length(value)
                                        
                                        if isfield(hashmap,name)
                                            
                                            hashmap.(name)(end+1) = ...
                                                value(idx);
                                            
                                        else
                                            
                                            hashmap.(name) = value(idx);
                                            
                                        end
                                        
                                    end
                                    
                                    % sort the list
                                    hashmap.(name) = ...
                                        unique(hashmap.(name));
                                    
                                end
                                
                            end
                            
                        otherwise
                            
                            if isprop(obj_OUT, varargin{var_i})
                            
                                obj_OUT.(varargin{var_i}) = ...
                                    varargin{var_i+1};
                            
                            end
                            
                    end
                    
                end
                
            end            
            
        end
        %==================================================================
        
    end
    
end
%==========================================================================
