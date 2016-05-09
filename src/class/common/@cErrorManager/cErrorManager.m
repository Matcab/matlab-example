classdef cErrorManager
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
    %	Mathieu CABANES	AROB@S      23/10/2013  Class creation
    %
    %   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
    %======================================================================
    % ALGORITHM:
    %======================================================================
    % INPUT:
    %   varargin    : command line arguments to cErrorManager (see
    %                 VARARGIN)
    %======================================================================
    % OUTPUT:
    %   obj_OUT     : GuiManager object
    %======================================================================
    
    % Standard attributes
    % -------------------
    properties (Access = protected)
        
        % Define calling figure handle
        figure_handle = 0;
        
        % error information
        error          = struct(...
            'exception', [], ...
            'type',      '');
        
        % Warning management
        warning_enable = true;
        
        % Footer management
        footer_enable = true;
        
    end
    
    % Dependent attributes
    % --------------------
    properties (Access = protected, Dependent)
       
        % id for applicative error
        applicative_id;
        
        % Name of the error log file
        error_filename;

        % Define the bug report
        bug_report;
        
        % path of the icon
        data_picture;

    end
    
    methods
        
        function obj_OUT = cErrorManager(varargin)
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
            
            % Manage input arguments
            % ----------------------
            if nargin > 1
                
                for i_arg = 1:2:length(varargin)
                    
                    if isprop(obj_OUT, varargin{i_arg})
                        
                        obj_OUT.(varargin{i_arg}) = ...
                            varargin{i_arg+1};
                        
                    end
                    
                end
                
            end
            
        end
        %==================================================================

        function name_OUT = get.applicative_id(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the Applicative error identifier
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN      : cErrorManager object
            %==============================================================
            % OUTPUT:
            %   name_OUT  	: short name of the software
            %==============================================================
            
            % Initialize output variable
            % --------------------------
            name_OUT = '';
            
            % Define the filename
            % -------------------
            if isappdata(obj_IN.figure_handle, 'MainData') && ...
                    isfield(getappdata(obj_IN.figure_handle, 'MainData'), ...
                    'SOFT_SHORT_NAME')
                
                % Load the MainData structure
                main_data = getappdata(obj_IN.figure_handle, 'MainData');
                name_OUT = main_data.SOFT_SHORT_NAME;
                
            elseif isappdata(0, 'MainData') && ...
                    isfield(getappdata(0, 'MainData'), 'SOFT_SHORT_NAME')
                
                % Load the MainData structure
                main_data = getappdata(0, 'MainData');
                name_OUT = main_data.SOFT_SHORT_NAME;
                
            end
            
            
        end
        %==================================================================
            
        function filename_OUT = get.error_filename(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the error file name
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cErrorManager object
            %==============================================================
            % OUTPUT:
            %   filename_OUT	: error log filename
            %==============================================================
            
            % Initialize output variable
            % --------------------------
            filename_OUT = '';
            
            % Define the filename
            % -------------------
            if isappdata(obj_IN.figure_handle, 'MainData') && ...
                    isfield(getappdata(obj_IN.figure_handle, 'MainData'), ...
                    'SOFT_LOGFILE')
                
                % Load the MainData structure
                main_data = getappdata(obj_IN.figure_handle, 'MainData');
                filename_OUT = main_data.SOFT_LOGFILE;
                
            elseif isappdata(0, 'MainData') && ...
                    isfield(getappdata(0, 'MainData'), 'SOFT_LOGFILE')
                
                % Load the MainData structure
                main_data = getappdata(0, 'MainData');
                filename_OUT = main_data.SOFT_LOGFILE;
                
            end
            
            
        end
        %==================================================================
        
        function status_OUT = get.bug_report(obj_IN) %#ok<MANU>
            %==============================================================
            %% DESCRIPTION: Define the error file name
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cErrorManager object
            %==============================================================
            % OUTPUT:
            %   filename_OUT	: error log filename
            %==============================================================
                        
            % Define the existence of bug report
            % ----------------------------------
            try 
                
                cBugReport;
                status_OUT = true;

            catch %#ok<CTCH>
                
                status_OUT = false;
                
            end
            
            
        end
        %==================================================================
        
        function data_picture_OUT = get.data_picture(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define the error file name
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cErrorManager object
            %==============================================================
            % OUTPUT:
            %   path_OUT	: error log filename
            %==============================================================
            
            % Initialize output variable
            % --------------------------
            data_picture_OUT = '';
            
            % Define the filename
            % -------------------
            if isappdata(obj_IN.figure_handle, 'MainData') && ...
                    isfield(getappdata(obj_IN.figure_handle, 'MainData'), ...
                    'SOFT_DATA_PICTURE')
                
                % Load the MainData structure
                main_data = getappdata(obj_IN.figure_handle, 'MainData');
                data_picture_OUT = main_data.SOFT_DATA_PICTURE;
                
            elseif isappdata(0, 'MainData') && ...
                    isfield(getappdata(0, 'MainData'), 'SOFT_DATA_PICTURE')
                
                % Load the MainData structure
                main_data = getappdata(0, 'MainData');
                data_picture_OUT = main_data.SOFT_DATA_PICTURE;
                
            end
            
            
        end
        %==================================================================
        
    end
        
end
%==========================================================================
