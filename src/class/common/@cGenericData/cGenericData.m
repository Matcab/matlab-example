classdef (InferiorClasses = {?cInfos}) cGenericData < cInfos
    %======================================================================
    %% VOLVO GTT 2013
    %======================================================================
    % MATLAB CLASS
    %======================================================================
    % FILENAME: cGenericData.m
    % PATH    : ..\class\common\@cGenericData
    %======================================================================
    % ABSTRACT: constructor of cGenericData
    %======================================================================
    % REVISION HISTORY:
    %   AUTHOR                  COMPANY     DATE        COMMENT
    %	Marc BALME              AROB@S      04/04/2011  Creation
    %	Mathieu CABANES         AROB@S      03/01/2013  Migration to MATLAB
    %                                                   2011b
    %
    %   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
    %======================================================================
    % ALGORITHM:
    %   Create an object cGenericData and set the provided class as type
    %   for element. If nothing is provided, test the structure with
    %   cVehicle.
    %======================================================================
    % INPUT:
    %   varargin 	: class name of the type of the element (first element)
    %======================================================================
    % OUTPUT:
    %   obj_OUT 	: cGenericData object
    %======================================================================
    
    % Attributes
    % ----------
    properties (Access = protected)
        
        element;
        Hashmap;
        
    end
    
    % Methods
    % -------
    methods
        
        function obj_OUT = cGenericData(varargin)
            %==============================================================
            %% DESCRIPTION: Overloaded constructor method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   varargin    : pair of attribute & attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : cInfos object
            %==============================================================
            if nargin==0
                
                % Generate default element
                % ------------------------
                obj_OUT = obj_OUT.generateCollection('test');
                
            elseif nargin==1 && ischar(varargin{1})
                
                obj_OUT = obj_OUT.generateCollection(varargin{1});
                
            else
                
                for var_i=1:2:length(varargin)
                    
                    if isprop(varargin{var_i})
                        
                        obj_OUT.(varargin{var_i}) = varargin{var_i+1};
                        
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
        function obj_OUT = generateCollection(obj_IN, varargin)
            %==============================================================
            %% DESCRIPTION: Overloaded constructor method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   varargin    : pair of attribute & attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : cInfos object
            %==============================================================                
            
            % Initialize output variable
            % --------------------------
            obj_OUT = obj_IN;
            
            % Get element or default value for test
            % -------------------------------------
            if strcmp(varargin{1}, 'test')
                
                % tmp_constructor = @cConfiguration;
                % tmp_constructor = @cParameter;
                tmp_constructor = @cSignals;
            
            else
                
                tmp_constructor = str2func(varargin{1});
                
            end
            
            % Create attributes
            % -----------------
            obj_OUT.element = tmp_constructor();
            obj_OUT.Hashmap = [getID(obj_OUT.element) 1];
            
        end
        %==================================================================
        
    end
    
end
%==========================================================================
