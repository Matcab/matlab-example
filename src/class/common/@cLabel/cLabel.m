classdef cLabel
    %======================================================================
    %% VOLVO GTT 2013
    %======================================================================
    % MATLAB CLASS
    %======================================================================
    % FILENAME: cLabel.m
    % PATH    : ..\common\@cLabel
    %======================================================================
    % ABSTRACT: cLabel constructor
    %======================================================================
    % REVISION HISTORY:
    %   AUTHOR                  COMPANY     DATE        COMMENT
    %	Mathieu CABANES         AROB@S      12/03/2013  Creation
    %
    %   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
    %======================================================================
    % ALGORITHM:
    %======================================================================
    % INPUT:
    %   varargin    : pair of attribute & attribute value
    %======================================================================
    % OUTPUT:
    %   obj_OUT     : cLabel object
    %======================================================================
    
    
    % Protected attributes
    % --------------------
    properties (Access = protected)
        
        language      = '';
        content       = '';

    end
        
    % Methods
    % -------
    methods
        
        function obj_OUT = cLabel(varargin)
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
            
            % Manage several argument
            % -----------------------
            if nargin>1
                
                % Manage input parameters
                for var_i=1:2:length(varargin)
                    
                    if isprop(obj_OUT, varargin{var_i})
                        
                        obj_OUT.(varargin{var_i}) = varargin{var_i+1};
                        
                    end
                    
                end
                                
            end
            
        end
        %==================================================================

    end
    
end
%==========================================================================
