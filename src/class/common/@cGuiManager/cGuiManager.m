classdef cGuiManager
    %======================================================================
    %% VOLVO GTT 2013
    %======================================================================
    % MATLAB CLASS
    %======================================================================
    % FILENAME: cGuiManager.m
    % PATH    : common\@cGuiManager
    %======================================================================
    % ABSTRACT:
    %   Constructor of the specific object called GuiManager and managing
    %   interface building
    %======================================================================
    % REVISION HISTORY:
    %   AUTHOR      	COMPANY     DATE        COMMENT
    %   Laurent Vaylet 	AROB@S   	27/01/2006  Creation
    %   Olivier Dufour	AROB@S    	14/11/2007  Update - Creation of
    %                                           generic functions in order
    %                                           to manage all kind of
    %                                           in-house software
    %   Olivier Dufour	AROB@S      27/05/2009  Add skin management, modify
    %                                           parent-child and key event
    %                                           management. Implemented in
    %                                           bdtool-v2.0.
    %                                           Use read_config_file
    %                                           librairy function for skin
    %                                           definition
    %   Olivier Dufour	AROB@S      30/09/2009  Add colors and font
    %                                           management in skins.
    %                                           Integration of
    %                                           read_config_file in this
    %                                           file (LocalReadConfigFile)
    %                                           Clean code, update
    %                                           documentation used in TACNI
    %                                           6.0.
    %   Olivier Dufour	AROB@S      03/05/2010  Function is documented and
    %                                           functionnalities are tested
    %                                           and improved.
    %   Olivier Dufour	AROB@S      09/12/2010  Corrections in skin
    %                                           behaviour (problem with
    %                                           panel for MATLAB 7.5 and
    %                                           allow definition on
    %                                           multiline vectors)
    %   Mathieu CABANES AROB@S      09/12/2010  Corrections in
    %                                           LocalSetLanguage to take
    %                                           into account new object
    %                                           available in Matlab 7.11
    %                                           (table) 
    %   Mathieu CABANES AROB@S      18/11/2011  Update of Close function to
    %                                           take into account the
    %                                           possibility to delete
    %                                           several children interfaces
    %	Mathieu CABANES	AROB@S      23/09/2013  Class creation
    %
    %   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
    %======================================================================
    % ALGORITHM:
    %======================================================================
    % INPUT:
    %   varargin	: command line arguments to cGuiManager (see VARARGIN)
    %======================================================================
    % OUTPUT:
    %   obj_OUT     : GuiManager object
    %======================================================================
   
    % Standard Attributes
    % -------------------
    properties (Access = protected)
        
        % Define main attribute
        % ---------------------
        % Name of the figure
        figure_name           = '';

        % Handles of the figure and its parent
        current_figure_handle = [];
        parent_figure_handle  = 0;
        
        % Define the current messages
        messages              = [];

        % Define the selected skin
        skin                  = '';
        
    end
      
    % Dependent Attributes
    % --------------------
    properties (Dependent, Access = protected)
        
        % Define dependent attribute
        % --------------------------
        % Name of the file containing labels
        label_filename;
        
        % Name of the file containing messages
        message_filename;
        
        % Name of the file containing graphical object positions
        % corresponding to the screensize
        screensize_filename;
        
        % Name of the file containing skin definition
        skin_filename;

        % Name of the file defining skin picture
        skin_picture;
        
        % Selected language
        language;

        % Selected screensize
        screensize;
        
    end
    
    % Methods
    % -------
    methods
        
        function obj_OUT = cGuiManager(varargin)
            %==============================================================
            %% DESCRIPTION: Overloaded constructor method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   varargin    : pair of attribute & attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : cGuiManager object
            %==============================================================
            
            % Initialize local variable
            % -------------------------
            user_data = [];
            main_data = [];
            
            if nargin > 1
                
                for i_arg = 1:2:length(varargin)
                    
                    if isprop(obj_OUT, varargin{i_arg})
                        
                        obj_OUT.(varargin{i_arg}) = ...
                            varargin{i_arg+1};
                       
                    elseif ischar(varargin{i_arg}) && ...
                            strcmpi(varargin{i_arg}, 'main_data') && ...
                            isstruct(varargin{i_arg+1})
                        
                        main_data = varargin{i_arg+1};
                        
                    elseif ischar(varargin{i_arg}) && ...
                            strcmpi(varargin{i_arg}, 'user_data') && ...
                            isstruct(varargin{i_arg+1})
                        
                        user_data = varargin{i_arg+1};
                        
                    end
                    
                end
                
                if ~isempty(obj_OUT.current_figure_handle) && ...
                        ~isempty(obj_OUT.figure_name)
                    
                    if ~isempty(main_data) && ~isempty(user_data)
                        
                        obj_OUT = obj_OUT.initialize(main_data, user_data);
                        
                    elseif ~isempty(main_data)
                        
                        obj_OUT = obj_OUT.initialize(main_data);

                    else
                        
                        obj_OUT = obj_OUT.initialize;
                    
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
        function filename_OUT = get.label_filename(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the label filename file
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cGuiManager object
            %==============================================================
            % OUTPUT:
            %   filename_OUT	: Name of the file containing labels
            %==============================================================
            
            % Initialize the name of the file containing label
            % ------------------------------------------------
            filename_OUT = '';
            
            % Define the label filename using language and data directory
            % -----------------------------------------------------------
            if ~isempty(obj_IN.current_figure_handle) && ...
                    isappdata(obj_IN.current_figure_handle, 'MainData')
                
                % Define current MainData structure
                main_data = getappdata(obj_IN.current_figure_handle, ...
                    'MainData');
                
                if isfield(main_data, 'SOFT_DATA')
                    
                    % Define the name of the label file
                    filename_OUT = fullfile(main_data.SOFT_DATA, ...
                        obj_IN.language, lower([lower(deblank(...
                        obj_IN.figure_name)),'_label.txt']));
                    
                    % Verify the existence of the file
                    if ~exist(filename_OUT, 'file')
                        
                        filename_OUT = '';
                        
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
        function filename_OUT = get.message_filename(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the message filename file
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cGuiManager object
            %==============================================================
            % OUTPUT:
            %   filename_OUT	: Name of the file containing messages
            %==============================================================
            
            % Initialize the name of the file containing label
            % ------------------------------------------------
            filename_OUT = '';
            
            % Define the label filename using language and data directory
            % -----------------------------------------------------------
            if ~isempty(obj_IN.current_figure_handle) && ...
                    isappdata(obj_IN.current_figure_handle, 'MainData')
                
                % Define current MainData structure
                main_data = getappdata(obj_IN.current_figure_handle, ...
                    'MainData');
                
                if isfield(main_data, 'SOFT_DATA')
                    
                    % Define the name of the label file
                    filename_OUT = fullfile(main_data.SOFT_DATA, ...
                        obj_IN.language, lower([lower(deblank(...
                        obj_IN.figure_name)),'_mes.txt']));
                    
                    % Verify the existence of the file
                    if ~exist(filename_OUT, 'file')
                        
                        filename_OUT = '';
                        
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
        function filename_OUT = get.screensize_filename(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the label filename file
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cGuiManager object
            %==============================================================
            % OUTPUT:
            %   filename_OUT	: Name of the file containing screensize
            %==============================================================
            
            % Initialize the name of the file containing label
            % ------------------------------------------------
            filename_OUT = '';
            
            % Define the label filename using language and data directory
            % -----------------------------------------------------------
            if ~isempty(obj_IN.current_figure_handle) && ...
                    isappdata(obj_IN.current_figure_handle, 'MainData')
                
                % Define current MainData structure
                main_data = getappdata(obj_IN.current_figure_handle, ...
                    'MainData');
                
                if isfield(main_data, 'SOFT_DATA_SCREENSIZE')
                    
                    % Define the name of the label file
                    filename_OUT = fullfile(main_data.SOFT_DATA_SCREENSIZE, ...
                        obj_IN.screensize, lower([lower(deblank(...
                        obj_IN.figure_name)),'_gui.txt']));
                    
                    % Verify the existence of the file
                    if ~exist(filename_OUT, 'file')
                        
                        filename_OUT = '';
                        
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
        function filename_OUT = get.skin_filename(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the label filename file
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cGuiManager object
            %==============================================================
            % OUTPUT:
            %   filename_OUT	: Name of the file containing skin
            %==============================================================
            
            % Initialize the name of the file containing label
            % ------------------------------------------------
            filename_OUT = '';
            
            % Define the label filename using language and data directory
            % -----------------------------------------------------------
            if ~isempty(obj_IN.current_figure_handle) && ...
                    isappdata(obj_IN.current_figure_handle, 'MainData')
                
                % Define current MainData structure
                main_data = getappdata(obj_IN.current_figure_handle, ...
                    'MainData');
                
                if isfield(main_data, 'SOFT_DATA_SKINS')
                    
                    % Define the name of the label file
                    filename_OUT = fullfile(main_data.SOFT_DATA_SKINS, ...
                        [obj_IN.getSkin, '.ini']);
                    
                    % Verify the existence of the file
                    if ~exist(filename_OUT, 'file')
                        
                        filename_OUT = '';
                        
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
        function filename_OUT = get.skin_picture(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the label filename file
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cGuiManager object
            %==============================================================
            % OUTPUT:
            %   filename_OUT	: Name of the file containing pictures
            %==============================================================
            
            % Initialize the name of the file containing label
            % ------------------------------------------------
            filename_OUT = '';
            
            % Define the label filename using language and data directory
            % -----------------------------------------------------------
            if ~isempty(obj_IN.current_figure_handle) && ...
                    isappdata(obj_IN.current_figure_handle, 'MainData')
                
                % Define current MainData structure
                main_data = getappdata(obj_IN.current_figure_handle, ...
                    'MainData');
                
                if isfield(main_data, 'SOFT_DATA_SKINS')
                    
                    % Define the name of the label file
                    filename_OUT = fullfile(main_data.SOFT_DATA_SKINS, ...
                        [obj_IN.skin, '.png']);
                    
                    % Verify the existence of the file
                    if ~exist(filename_OUT, 'file')
                        
                        filename_OUT = '';
                        
                    end
                    
                end
                
            end
            
        end
        %==================================================================
        
        function language_OUT = get.language(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the label filename file
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cGuiManager object
            %==============================================================
            % OUTPUT:
            %   filename_OUT	: User selected language
            %==============================================================
            
            % Initialize the language with default value
            % ------------------------------------------
            language_OUT = 'en';
            
            % Define language from the user data structure
            % -----------------------------------------------------------
            if ~isempty(obj_IN.current_figure_handle) && ...
                    isappdata(obj_IN.current_figure_handle, 'UserData')
                
                % Define current MainData structure
                user_data = getappdata(obj_IN.current_figure_handle, ...
                    'UserData');
                
                if isfield(user_data, 'LANGUAGE')
                    
                    % Define the name of the label file
                    language_OUT = user_data.LANGUAGE;
                                        
                end
                
            end
            
        end
        %==================================================================

        function screensize_OUT = get.screensize(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the label filename file
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cGuiManager object
            %==============================================================
            % OUTPUT:
            %   filename_OUT	: User selected language
            %==============================================================
            
            % Initialize the language with default value
            % ------------------------------------------
            screensize_OUT = '800x600';
            
            % Define language from the user data structure
            % -----------------------------------------------------------
            if ~isempty(obj_IN.current_figure_handle) && ...
                    isappdata(obj_IN.current_figure_handle, 'UserData')
                
                % Define current MainData structure
                user_data = getappdata(obj_IN.current_figure_handle, ...
                    'UserData');
                
                if isfield(user_data, 'SCREEN_SIZE')
                    
                    % Define the name of the label file
                    screensize_OUT = user_data.SCREEN_SIZE;
                                        
                end
                
            end
            
        end
        %==================================================================
         
    end
    
end
%==========================================================================
