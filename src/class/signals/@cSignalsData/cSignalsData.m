classdef cSignalsData < cGenericData
    %======================================================================
    %% VOLVO GTT 2014
    %======================================================================
    % MATLAB CLASS
    %======================================================================
    % FILENAME: cSignalsData.m
    % PATH    : $TEMPLATE_HOME$\class\signals\@cSignalsData
    %======================================================================
    % ABSTRACT: constructor Signals collection
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
    %   varargin 	: command line arguments to cSignalsData (see VARARGIN)
    %======================================================================
    % OUTPUT:
    %   obj_OUT  	: cSignalsData object
    %======================================================================
    
    % Attributes
    % ----------
    properties (Access = protected)
        
    end
    
    % Methods
    % -------
    methods
        
        function obj_OUT = cSignalsData(varargin)
            %==============================================================
            %% DESCRIPTION: Overloaded constructor method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   varargin	: pair of attribute & attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : cConfigurationData object
            %==============================================================
            
            % Define the class
            % ---------------
            obj_OUT = obj_OUT.generateCollection('cSignals');
            
            if nargin>1
                
                % Update attributes
                for var_i=1:2:length(varargin)
                    
                    if isprop(obj_OUT, varargin{var_i}) && ...
                            ~strcmp(varargin{var_i}, 'displayedName')
                        
                        obj_OUT.(varargin{var_i}) = varargin{var_i+1};
                        
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
    end
    
end
%==========================================================================
