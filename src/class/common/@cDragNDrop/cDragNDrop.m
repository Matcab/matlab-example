classdef cDragNDrop
    %======================================================================
    %% VOLVO GTT 2014
    %======================================================================
    % MATLAB CLASS
    %======================================================================
    % FILENAME: cDragNDrop.m
    % PATH    : $TEMPLATE_HOME$\src\class\common\@cDragNDropTest
    %======================================================================
    % ABSTRACT: DragNDrop class constructor
    %======================================================================
    % REVISION HISTORY:
    %   AUTHOR                  COMPANY     DATE        COMMENT
    %	Mathieu CABANES         AROB@S      08/07/2014  Creation
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
     properties (Access = protected)
        
        drag_handles    = [];
        drop_handles    = [];
        drop_callback   = {};
        drop_valid_drag = {};
        
    end
    
    % Attributes
    % ----------
    properties (Access = private)
       
        figure_handle = [];
        
    end
    
    methods
        
        function obj_OUT = cDragNDrop(varargin)
            %==============================================================
            %% DESCRIPTION: Overloaded constructor method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   varargin    : pair of attribute & attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : cDragNDrop object
            %==============================================================
                        
            % Manage input argument
            % ---------------------
            if nargin>0
                
                for var_i=1:2:length(varargin)
                    
                    if isprop(obj_OUT, varargin{var_i})
                        
                        obj_OUT.(varargin{var_i}) = varargin{var_i+1};
                        
                    end
                    
                end
                                
            end
 
            % Manage no figure handle defined
            if isempty(obj_OUT.figure_handle); obj_OUT.figure_handle = ...
                    gcf; end;
            
            % Verify the figure handle structure
            assert(ishandle(obj_OUT.figure_handle) && strcmpi(get(...
                obj_OUT.figure_handle, 'Type'), 'figure'), ...
                'ClassDragNDrop:InvalidParentFigure', ['The object ', ...
                'must be related to a valide figure handle']);
            
        end
        %==================================================================
        
    end
    
end
%==========================================================================

