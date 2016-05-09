classdef cStartupGui < handle
    %======================================================================
    %% VOLVO GTT 2013
    %======================================================================
    % MATLAB CLASS
    %======================================================================
    % FILENAME: cStartupGui.m
    % PATH    : bin\@cStartupGui
    %======================================================================
    % ABSTRACT:
    %   Constructor of the startup interface object managing interface and
    %   user message during application initialization
    %======================================================================
    % REVISION HISTORY:
    %   AUTHOR                  COMPANY     DATE        COMMENT
    %	Mathieu CABANES         Arob@s      16/05/2011  Creation
    %	Mathieu CABANES         AROB@S      15/02/2013  Migration to MATLAB
    %                                                   2011b
    %	Mathieu CABANES         AROB@S      07/11/2013  Update to manage 
    %                                                   handle inheritence
    %
    %   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
    %======================================================================
    % ALGORITHM:
    %======================================================================
    % INPUT:
    %   varargin	: command line arguments to cStartupGui (see VARARGIN)
    %======================================================================
    % OUTPUT:
    %   obj_OUT     : cStartupGui object
    %======================================================================
    
    % Protected attributes
    % --------------------
    properties (Access = protected)
        
        current_step  = 0;
        step_list     = [];
        error_list    = {};
        
    end
    
    % Private attributes
    % ------------------
    properties (Access = private)
        
        FgStartupGui  = [];
        StProgressBar = [];
        JProgressBar  = [];
        PnLog         = [];
        LbLog         = [];
        StStep        = [];
        
    end
    
    % Methods
    % -------
    methods
        
        function obj_OUT = cStartupGui(varargin)
            %==============================================================
            %% DESCRIPTION: Overloaded constructor method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   varargin    : pair of attribute & attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : cStartupGui object
            %==============================================================
            if nargin > 1
                
                for i_arg = 1:2:length(varargin)
                    
                    switch(varargin{i_arg})
                        
                        case 'step'
                            
                            % Update object
                            obj_OUT.step_list = varargin{i_arg+1};
                            
                            % Initialize interface
                            obj_OUT = obj_OUT.initialize();
                            
                        otherwise
                            
                            if isprop(obj_OUT, varargin{i_arg})
                                
                                obj_OUT.(varargin{i_arg}) = ...
                                    varargin{i_arg+1};
                                
                            end
                            
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
        function closeFigure(obj_IN, varargin)
            %==============================================================
            %% DESCRIPTION: Close interface
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN      : cStartupGui object
            %   varargin    : command line argument of closeFigure (see
            %   VARARGIN) 
            %==============================================================
            % OUTPUT:
            %==============================================================

            % Manage the different case for closing windows
            % ---------------------------------------------
            if ishandle(obj_IN.FgStartupGui)
                
                if isempty(obj_IN.error_list) || (nargin == 4 && ...
                        ischar(varargin{3}) && strcmpi(varargin{3}, 'force'))
                    
                    % Delete window if it exist
                    delete(obj_IN.FgStartupGui);
                    
                else
                    
                    % In case of errors, allow the user to close the window
                    %  with red cross
                    set(obj_IN.FgStartupGui, 'CloseRequestFcn', ...
                        @(src, event)closeFigure(obj_IN, src, event, 'force'));
                    
                end
                
            end
        
        end
        %==================================================================

    end
    
    methods (Access = private)
        
        function obj_OUT = createFigure(obj_IN, actions_IN, ...
                action_sizes_IN, line_length_IN)
            %==============================================================
            %% DESCRIPTION: Create window and graphical objects
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN      : cStartupGui object
            %   varargin	: command line arguments to createFigure (see
            %                 VARARGIN)
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : updated cStartupGui object
            %==============================================================
            
            % Initialize output variable
            % --------------------------
            obj_OUT = obj_IN;
            
            % Define default interface position
            % ---------------------------------
            figure_position = [0 0 2*line_length_IN+20 ...
                20*sum(action_sizes_IN) + length(actions_IN)*10 + 200];
                        
            % Create interface
            % ----------------
            % figure
            obj_OUT.FgStartupGui = figure('Tag', 'FgStartupGui', ...
                'DockControl', 'off', 'NumberTitle', 'off', 'Toolbar', ...
                'none', 'Menubar', 'none', 'Name', ...
                'Application starting ...', 'Color', ...
                [0.941,0.941,0.941], 'Units', 'pixels', 'Position', ...
                figure_position, 'Resize', 'off', 'CloseRequestFcn', [], ...
                'Visible', 'off');
            
            % Static text define to anchor the waitbar
            obj_OUT.StProgressBar = uicontrol('Style', 'text', 'Tag', ...
                'StProgressBar', 'Parent', obj_OUT.FgStartupGui, ...
                'Units', 'pixels', 'FontName', 'Calibri', 'FontSize', ...
                11, 'FontWeight', 'normal', 'FontUnit', 'pixels', ...
                'HorizontalAlignment', 'center', 'Position', ...
                [10 170 figure_position(3)-20 25], 'String', '');
            
            % Log Panel
            obj_OUT.PnLog = uipanel('Tag', 'PnLog', 'Parent', ...
                obj_OUT.FgStartupGui, 'Title', ...
                'Initialisation log messages:', 'BorderWidth', 1, ...
                'SelectionHighlight', 'off', 'Units', 'pixels', ...
                'FontName', 'Calibri', 'FontSize', 11, 'FontWeight', ...
                'bold', 'FontUnit', 'pixels', 'Position', ...
                [10 10 figure_position(3)-20 150]);
            
            % Log list
            obj_OUT.LbLog = uicontrol('Style', 'listbox', 'Tag', ...
                'LbLog', 'Parent', obj_OUT.PnLog, 'String', '', ...
                'BackgroundColor', [1.0 1.0 1.0], 'Units', 'pixels', ...
                'HorizontalAlignment', 'center', 'FontName', 'Calibri', ...
                'FontSize', 11, 'FontWeight', 'normal', 'FontUnit', ...
                'pixels', 'Position', [5 5 figure_position(3)-30 125], ...
                'CreateFcn', [], 'Callback', []);
                                    
            % Define Progress bar based on Java components
            javaBar = javax.swing.JProgressBar;
            
            % Define default characteristics
            javaBar.setStringPainted(true);
            javaBar.setBorderPainted(true);
            javaBar.setIndeterminate(false);
            javaBar.setValue(0);
                        
            % Create Progressbar
            static_position = get(obj_OUT.StProgressBar, 'Position');
            obj_OUT.JProgressBar = javacomponent(javaBar, ...
                static_position, obj_OUT.FgStartupGui);
            
            % Create text UICONTROL to display information
            y_pos = 200;
            
            for i_action = length(actions_IN):-1:1
                
                % Calculate object height
                obj_height = 20 * action_sizes_IN(i_action);
                obj_OUT.StStep(i_action) = uicontrol('Style', 'text', ...
                    'Parent', obj_OUT.FgStartupGui, 'BackgroundColor', ...
                    [0.941,0.941,0.941], 'Units', 'pixels', ...
                    'HorizontalAlignment', 'left', 'FontName', ...
                    'Calibri', 'FontSize', 11, 'FontWeight', 'normal', ...
                    'FontUnit', 'pixels', 'Position', ...
                    [10 y_pos static_position(3)-70 obj_height], ...
                    'String', actions_IN{i_action});
                
                % Calculate next object position
                y_pos = y_pos + obj_height + 10;
                
            end
            
            % Display interface
            % -----------------
            movegui(obj_OUT.FgStartupGui, 'center');
            set(obj_OUT.FgStartupGui, 'Visible', 'on');
            
        end
        %==================================================================
                    
    end
    
end
%==========================================================================
