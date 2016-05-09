classdef cBugReport < handle
    %======================================================================
    %% VOLVO GTT 2013
    %======================================================================
    % MATLAB CLASS
    %======================================================================
    % FILENAME: cBugReport.m
    % PATH    : common\@cBugReport
    %======================================================================
    % ABSTRACT:
    %   Constructor of the specific object called cBugReport, managing
    %   system error report to developers
    %======================================================================
    % REVISION HISTORY:
    %   AUTHOR      	COMPANY     DATE        COMMENT
    %	Mathieu CABANES	AROB@S      30/10/2013  Class creation
    %
    %   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
    %======================================================================
    % ALGORITHM:
    %======================================================================
    % INPUT:
    %   varargin    : command line arguments to cBugReport (see VARARGIN)
    %======================================================================
    % OUTPUT:
    %   obj_OUT     : cBugReport object
    %======================================================================
    
    % Define attributes
    % -----------------
    % Attributes depending from the user actions
    properties (Access = protected)
        
        % Priority level of the report
        figure_handle  = 0;
        
        % Priority level of the report
        priority_level = 3;
        
        % Author of the report
        author         = '';
        
        % Report message
        message        = '';
        
    end
    
    % Attributes for interface parameterization
    properties (Access = protected)
        
        % Interface language
        language       = 'en';
        
    end
    
    % Attribute used to define the interface
    properties (Access = private)
        
        FgBugReport   = [];
        StTitle       = [];
        PnMessage     = [];
        StPriority    = [];
        PmPriority    = [];
        StAuthor      = [];
        EdAuthor      = [];
        StMessage     = [];
        EdMessage     = [];
        StUserRequest = [];
        PbOk          = [];
        PbCancel      = [];
        
    end
  
    % Dependent attributes
    properties (Dependent, Access = protected)
        
        % Mail used to send the report
        developer_mail;
        
        % filename of the file to attach to the mail
        error_filename;
        
        % Name of the current software
        software_name;

    end
    
    % Constant attributes
    properties (Constant)
        
        % Smtp server used to send the report
        smtp_server = 'mailgot.it.volvo.net';
        
        % Define interface labels
        labels = struct(...
            'en', struct(...
            'FgBugReport', 'Report management', ...
            'StTitle', 'BUG REPORT',  ...
            'PnMessage', 'Description', ...
            'StPriority', 'Priority level', ...
            'PmPriority', {{'High priority'; 'Medium priority'; 'Low priority'}}, ...
            'StAuthor', 'Author', ...
            'StMessage', 'Error message', ...
            'StUserRequest', 'Would you like to send the report to the developer?', ...
            'PbOk', 'YES', 'PbCancel', 'NO', 'ReportSuccess', ...
            'Report send to developer with success.', ...
            'ReportFailed', 'Report failed to be sent due to: '), ...
            'fr', struct(...
            'FgBugReport', 'Gestion de rapport', ...
            'StTitle', 'RAPPORT D''ERREUR',  ...
            'PnMessage', 'Description', ...
            'StPriority', 'Niveau de priorite', ...
            'PmPriority', {{'Priorite haute'; 'Priorite moyenne'; 'Priorite basse'}}, ...
            'StAuthor', 'Auteur', ...
            'StMessage', 'Message d''erreur', ...
            'StUserRequest', 'Voulez vous envoyer ce rapport au developpeur?', ...
            'PbOk', 'OUI', 'PbCancel', 'NON', 'ReportSuccess', ...
            'Rapport envoye au developpeur.', ...
            'ReportFailed', 'Le rapport n''a pas pu etre envoye a cause de : '), ...
            'us', struct(...
            'FgBugReport', 'Report management', ...
            'StTitle', 'BUG REPORT',  ...
            'PnMessage', 'Description', ...
            'StPriority', 'Priority level', ...
            'PmPriority', {{'High priority'; 'Medium priority'; 'Low priority'}}, ...
            'StAuthor', 'Author', ...
            'StMessage', 'Error message', ...
            'StUserRequest', 'Would you like to send the report to the developer?', ...
            'PbOk', 'YES', 'PbCancel', 'NO', 'ReportSuccess', ...
            'Report send to developer with success.', ...
            'ReportFailed', 'Report failed to be sent due to: '));

    end
    
    methods
        
        function obj_OUT = cBugReport(varargin)
            %==============================================================
            %% DESCRIPTION: Overloaded constructor method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   varargin	: command line arguments to cBugReport (see
            %                 VARARGIN)
            %                 Pair or Attribute/Attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : updated cBugReport object
            %==============================================================
            
            if nargin > 1
                
                % Manage input arguments
                % ----------------------
                for i_arg = 1:2:length(varargin)
                    
                    if isprop(obj_OUT, varargin{i_arg})
                        
                        obj_OUT.(varargin{i_arg}) = ...
                            varargin{i_arg+1};
                        
                    end
                    
                end
                
                % Create the interface
                % --------------------
                obj_OUT = obj_OUT.createFigure;
                
            end
            
        end
        %==================================================================
        
        function mail_OUT = get.developer_mail(obj_IN)
            %==============================================================
            %% DESCRIPTION: Create the bug report interface
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN      : cBugReport object
            %==============================================================
            % OUTPUT:
            %   mail_OUT     : mail addresse of the developers
            %==============================================================
            
            % Initialize output variable
            % --------------------------
            mail_OUT = '';
            
            % Define the developer mail
            % -------------------------
            if isappdata(obj_IN.figure_handle, 'MainData') && ...
                    isfield(getappdata(obj_IN.figure_handle, 'MainData'), ...
                    'SOFT_DEVELOPER_MAIL')
                
                % Load the MainData structure
                main_data = getappdata(obj_IN.figure_handle, 'MainData');
                mail_OUT = main_data.SOFT_DEVELOPER_MAIL;
                
            elseif isappdata(0, 'MainData') && ...
                    isfield(getappdata(0, 'MainData'), 'SOFT_DEVELOPER_MAIL')
                
                % Load the MainData structure
                main_data = getappdata(0, 'MainData');
                mail_OUT = main_data.SOFT_DEVELOPER_MAIL;
                
            elseif ~isempty(getenv('DEVELOPER_MAIL'))
                
                % Use the environment variable
                mail_OUT = getenv('DEVELOPER_MAIL');
                
            end
            
        end
        %==================================================================
        
        function filename_OUT = get.error_filename(obj_IN)
            %==============================================================
            %% DESCRIPTION: Create the bug report interface
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cBugReport object
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

        function name_OUT = get.software_name(obj_IN)
            %==============================================================
            %% DESCRIPTION: Create the bug report interface
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN      : cBugReport object
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

    end
    
    methods (Access = protected)
             
        function obj_OUT = createFigure(obj_IN, varargin)
            %==============================================================
            %% DESCRIPTION: Create the bug report interface
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN      : cBugReport object
            %   varargin	: command line arguments to createFigure (see
            %                 VARARGIN)
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : updated cBugReport object
            %==============================================================
            
            % Initialize output variable
            % --------------------------
            obj_OUT = obj_IN;
                            
            % Define the display language
            % ---------------------------
            if ~isempty(obj_OUT.language) && ...
                    ismember(obj_OUT.language, fieldnames(obj_OUT.labels))
                
                selected_language = obj_OUT.language;
                
            else
                
                selected_language = 'en';
                
            end
            
            % Create the different graphical objects
            % --------------------------------------
            obj_OUT.FgBugReport = figure('Tag', 'FgBugReport', ...
                'MenuBar', 'none', 'Toolbar', 'none', ...
                'NumberTitle', 'off', 'DockControl', 'off', ...
                'Name', obj_OUT.labels.(selected_language).FgBugReport, ...
                'Units', 'pixels', 'Position', [200 200 350 370], ...
                'Resize', 'off', 'Visible', 'off', 'Color', ...
                [0.941,0.941,0.941]);
            
            obj_OUT.StTitle = uicontrol('Tag', 'StTitle', ...
                'Style', 'text', 'Parent', obj_OUT.FgBugReport, ...
                'String', obj_OUT.labels.(selected_language).StTitle, ...
                'Units', 'pixels', 'Position', [10 330 350 30], ...
                'FontName', 'Calibri', 'FontSize', 18, ...
                'FontUnit', 'pixels', 'FontWeight', 'bold', ...
                'HorizontalAlignment', 'center');
            
            obj_OUT.PnMessage = uipanel('Tag', 'PnMessage', ...
                'Parent', obj_OUT.FgBugReport, ...
                'Title', obj_OUT.labels.(selected_language).PnMessage, ...
                'Units', 'pixels', 'Position', [10 60 330 250], ...
                'FontName', 'Calibri', 'FontSize', 10, ...
                'FontUnit', 'pixels', 'FontWeight', 'bold', ...
                'Visible', 'on');
            
            obj_OUT.StPriority = uicontrol('Tag', 'StPriority', ...
                'Style', 'text', 'Parent', obj_OUT.PnMessage, ...
                'String', obj_OUT.labels.(selected_language).StPriority, ...
                'Units', 'pixels', 'Position', [10 215 100 15], ...
                'FontName', 'Calibri', 'FontSize', 10, ...
                'FontUnit', 'pixels', 'FontWeight', 'normal', ...
                'HorizontalAlignment', 'left');
            obj_OUT.PmPriority = uicontrol('Tag', 'PmPriority', ...
                'Style', 'popupmenu', 'Parent', obj_OUT.PnMessage, ...
                'String', obj_OUT.labels.(selected_language).PmPriority, ...
                'Value', obj_IN.priority_level, 'Units', 'pixels', ...
                'BackgroundColor', [1 1 1], 'Position', [120 215 200 20], ...
                'FontName', 'Calibri', 'FontSize', 10, ...
                'FontUnit', 'pixels', 'FontWeight', 'normal', ...
                'HorizontalAlignment', 'left');
            
            obj_OUT.StAuthor = uicontrol('Tag', 'StAuthor', ...
                'Style', 'text', 'Parent', obj_OUT.PnMessage, ...
                'String', obj_OUT.labels.(selected_language).StAuthor, ...
                'Units', 'pixels', 'Position', [10 185 100 15], ...
                'FontName', 'Calibri', 'FontSize', 10, ...
                'FontUnit', 'pixels', 'FontWeight', 'normal', ...
                'HorizontalAlignment', 'left');
            obj_OUT.EdAuthor = uicontrol('Tag', 'EdAuthor', ...
                'Style', 'edit', 'Parent', obj_OUT.PnMessage, ...
                'String', obj_IN.author, 'Units', 'pixels', ...
                'BackgroundColor', [1 1 1], 'Position', [120 185 200 20], ...
                'FontName', 'Calibri', 'FontSize', 10, ...
                'FontUnit', 'pixels', 'FontWeight', 'normal', ...
                'HorizontalAlignment', 'left', 'UserData', getenv('USERNAME'));
            
            obj_OUT.StMessage = uicontrol('Tag', 'StMessage', ...
                'Style', 'text', 'Parent', obj_OUT.PnMessage, ...
                'String', obj_OUT.labels.(selected_language).StMessage, ...
                'Units', 'pixels', 'Position', [10 160 310 15], ...
                'FontName', 'Calibri', 'FontSize', 10, ...
                'FontUnit', 'pixels', 'FontWeight', 'normal', ...
                'HorizontalAlignment', 'left');
            obj_OUT.EdMessage = uicontrol('Tag', 'EdMessage', ...
                'Style', 'edit', 'Parent', obj_OUT.PnMessage, ...
                'String', obj_IN.message, 'Units', 'pixels', ...
                'BackgroundColor', [1 1 1], 'Position', [10 10 310 150], ...
                'FontName', 'Calibri', 'FontSize', 10, ...
                'FontUnit', 'pixels', 'FontWeight', 'normal', ...
                'HorizontalAlignment', 'left', 'Min', 1, 'Max', 7);
            
            obj_OUT.StUserRequest = uicontrol('Tag', 'StUserRequest', ...
                'Style', 'text', 'Parent', obj_OUT.FgBugReport, 'String', ...
                obj_OUT.labels.(selected_language).StUserRequest,  ...
                'Units', 'pixels', 'Position', [10 10 230 30], ...
                'FontName', 'Calibri',  'FontSize', 10, ...
                'FontUnit', 'pixels', 'FontWeight', 'normal', ...
                'HorizontalAlignment', 'left');
            
            obj_OUT.PbOk = uicontrol('Tag', 'PbOk', ...
                'Style', 'pushbutton', 'Parent', obj_OUT.FgBugReport, ...
                'String', obj_OUT.labels.(selected_language).PbOk, ...
                'Units', 'pixels', 'Position', [250 10 40 40], ...
                'Enable', 'on');
            obj_OUT.PbCancel = uicontrol('Tag', 'PbCancel', ...
                'Style', 'pushbutton', 'Parent', obj_OUT.FgBugReport, ...
                'String', obj_OUT.labels.(selected_language).PbCancel, ...
                'Units', 'pixels', 'Position', [300 10 40 40], ...
                'Enable', 'on');
            
            % Define the report callback
            % --------------------------
            set(obj_OUT.PbOk, 'Callback', @(src, event)sendReport(...
                obj_IN, src, event));
            set(obj_OUT.PbCancel, 'Callback', @(src, event)closeReport(...
                obj_IN, src, event));
           
            % Display the interface
            % ---------------------
            movegui(obj_OUT.FgBugReport, 'center');
            set(obj_OUT.FgBugReport, 'Visible', 'on');
            
        end
        %==================================================================
        
        function sendReport(obj_IN, hObject, evendata)
            %==============================================================
            %% DESCRIPTION: Create the bug report interface
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN      : cBugReport object
            %   hObject     : handle to figure
            %   eventdata   : reserved - to be defined in a future version
            %                 of MATLAB
            %==============================================================
            % OUTPUT:
            %==============================================================
            
            % Define the display language
            % ---------------------------
            if ~isempty(obj_IN.language) && ...
                    ismember(obj_IN.language, fieldnames(obj_IN.labels))
                
                selected_language = obj_IN.language;
                
            else
                
                selected_language = 'en';
                
            end
            
            % Get the different mandatory informations
            % ----------------------------------------
            reports       = get(obj_IN.PmPriority, 'String');
            report_type   = reports{get(obj_IN.PmPriority, 'Value')};
            sender.name   = get(obj_IN.EdAuthor, 'String');
            sender.id     = get(obj_IN.EdAuthor, 'UserData');
            error_message = get(obj_IN.EdMessage, 'String');

            % Define mail adresse
            % -------------------
            mail_adresse = [sender.id, '@', obj_IN.software_name, '.com'];
            
            % Set mail properties
            setpref('Internet', 'E_mail', mail_adresse);
            
            % Define mail subject
            % -------------------
            if ~isempty(sender.name)
                
                mail_subject = [report_type , ' from ', sender.name, ...
                    ' (', sender.id, ')'];
                
            else
                
                mail_subject = [report_type , ' from ', sender.id];
                
            end
            
            % Define mail content
            % -------------------
            if ~isempty(error_message)

                mail_content = error_message(1,:);
                
                for i = 2:size(error_message, 1)
                
                    mail_content = sprintf('%s\n', mail_content, error_message(i,:));
                
                end
                
            else
                
                mail_content = ' ';
            
            end
                                                
            % Define mail attachement
            % -----------------------
            if ~isempty(obj_IN.error_filename)

                mail_attachment = obj_IN.error_filename;
            
            else
                
                mail_attachment = [];
            
            end
            
            % Send mail
            % ---------
            try
                
                % Set mail server
                setpref('Internet', 'SMTP_Server', obj_IN.smtp_server);
                
                % Send mail
                if (exist(mail_attachment, 'file'))
                    
                    sendmail(obj_IN.developer_mail,  mail_subject, ...
                       mail_content, mail_attachment);
                    
                else
                    
                    sendmail(obj_IN.developer_mail, mail_subject, ...
                        mail_content);
                    
                end

                % Inform the user
                set(obj_IN.StUserRequest, 'String', ...
                    obj_IN.labels.(selected_language).ReportSuccess);
                pause(1.0);
    
            catch exception
                
                % Inform the user
                set(obj_IN.StUserRequest, 'String', ...
                    [obj_IN.labels.(selected_language).ReportFailed, ...
                    ' ', exception.message]);
                pause(2.0);

            end
            
            % Close window
            obj_IN.closeReport(hObject, evendata);
            
        end
        %==================================================================
        
        function closeReport(obj_IN, ~, ~)
            %==============================================================
            %% DESCRIPTION: Create the bug report interface
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN      : cBugReport object
            %   hObject     : handle to figure
            %   eventdata   : reserved - to be defined in a future version
            %                 of MATLAB
            %==============================================================
            % OUTPUT:
            %==============================================================
            
            % Delete the figure
            % -----------------
            delete(obj_IN.FgBugReport);
            
        end
        %==================================================================
        
    end
    
end
%==========================================================================
