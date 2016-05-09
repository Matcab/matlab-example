function mt_startup
%==========================================================================
%% VOLVO 3P 2014
%==========================================================================
% TEMPLATE v 3.0
%==========================================================================
% FILENAME: tm_startup.m
% PATH    : $TEMPLATE_HOME$\bin
%==========================================================================
% ABSTRACT: MATLAB TEMPLATE initialisation file
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE     	COMMENT
%	Maxime CAZENAVE         ENSE3       22/06/2010	Creation
%	Mathieu CABANES         AROB@S      19/06/2014 	Migration into MATLAB
%                                                   2012b and integration
%                                                   of last standardized
%                                                   features
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%==========================================================================
% OUTPUT:
%==========================================================================
% NOTE:
%   In this file:
%   -> TEMPLATE had to be replaced by the complete name of the application
%   -> TM had to be replaced by the short name of the application
%==========================================================================

%% Initialization: Define the interface displaying initialization process
% -----------------------------------------------------------------------
% Initialize local variable
is_initialization_ready = true;

% Initialize MainData structure
main_data = LocalDefineMainData;

% Define step list
step_list = LocalDefineInitialisationStep;

% Define the initialisation window
user_information = cStartupGui('step', step_list);

%% Environment variable loading
%  ----------------------------
% update starting interface
% -------------------------
user_information = user_information.updateStep();

try
    
    % Define main software variables (Mandatory)
    %-------------------------------------------
    main_data.SOFT_VERSION    = getenv('TEMPLATE_VERSION');
    main_data.SOFT_HOME       = getenv('TEMPLATE_HOME');
    main_data.SOFT_NAME       = 'MATLAB TEMPLATE';
    main_data.SOFT_SHORT_NAME = 'MT';
    
    % Define main user variables (Mandatory)
    %---------------------------------------
    % Directory which contains user data
    DIR_USER_DATA = getenv('TEMPLATE_USER_DIRECTORY');
    
    % Databases directories
    DIR_LOCAL_DATA            = getenv('TEMPLATE_USER_DATABASE');
    DIR_COMMON_DATA           = getenv('TEMPLATE_COMMON_DATABASE');
    main_data.SOFT_COMMON_DIR = DIR_COMMON_DATA;
    
    % Define user and technical guides names (Mandatory)
    % --------------------------------------------------
    % User guide
    if ~isempty(getenv('TEMPLATE_USER_GUIDE'))
        
        main_data.SOFT_USER_GUIDE = fullfile(main_data.SOFT_HOME, ...
            'doc', getenv('TEMPLATE_USER_GUIDE'));
        
    end
    
    % Technical guide
    if ~isempty(getenv('TEMPLATE_TECHNICAL_GUIDE'))
        
        main_data.SOFT_TECHNICAL_GUIDE = fullfile(main_data.SOFT_HOME, ...
            'doc', getenv('TEMPLATE_TECHNICAL_GUIDE'));
        
    end
    
    % Standard and guidelines
    if ~isempty(getenv('TEMPLATE_SG_PART1'))
        
        main_data.SOFT_SG_PART1 = fullfile(main_data.SOFT_HOME, ...
            'doc', getenv('TEMPLATE_SG_PART1'));
        
    end
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep();
    
catch exception_1
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep('ERROR', exception_1);
    
    % Update status
    % -------------
    is_initialization_ready = false;
    
end

%% Directories definition and path update
%  --------------------------------------
% update starting interface
% -------------------------
user_information = user_information.updateStep();

try
    
    % Software directories (Mandatory)
    %---------------------------------
    % Data and documentation directories
    main_data.SOFT_DATA            = fullfile(main_data.SOFT_HOME, 'data');
    
    % Software parameterization directories
    main_data.SOFT_DATA_SCREENSIZE = ...
        fullfile(main_data.SOFT_HOME, 'data', 'screensize');
    main_data.SOFT_DATA_SKINS      = ...
        fullfile(main_data.SOFT_HOME, 'data', 'skins');
    main_data.SOFT_DATA_PICTURE    = ...
        fullfile(main_data.SOFT_HOME, 'data', 'picture');
    main_data.SOFT_DATA_LOG        = ...
        fullfile(main_data.SOFT_HOME, 'data', 'log');
    
    % Default software data
    main_data.SOFT_DATA_DEFAULT    = fullfile(main_data.SOFT_HOME, ...
        'data', 'default');
    
    % softwares sources and executables directory
    DIR_SOFT_BIN       = fullfile(main_data.SOFT_HOME, 'bin');
    DIR_SOFT_INC       = fullfile(main_data.SOFT_HOME, 'include');
    DIR_SOFT_LIB       = fullfile(main_data.SOFT_HOME, 'lib');
    DIR_SOFT_GUI       = fullfile(main_data.SOFT_HOME, 'src', 'gui');
    DIR_SOFT_MATLAB    = fullfile(main_data.SOFT_HOME, 'src', 'matlab');
    DIR_SOFT_CLASS     = fullfile(main_data.SOFT_HOME, 'src', 'class');
    DIR_SOFT_JAVA      = fullfile(main_data.SOFT_HOME, 'src', 'java');
    DIR_SOFT_C         = fullfile(main_data.SOFT_HOME, 'src', 'C');
    
    if exist(fullfile(DIR_SOFT_JAVA, 'GST.jar'), 'file')==2
        
        PATH_JAR       = fullfile(DIR_SOFT_JAVA, 'GST.jar');
        
    end
    
    % manage software test directory in development mode
    if ~isdeployed && exist(fullfile(main_data.SOFT_HOME, 'test'), 'dir') == 7
        
        DIR_SOFT_TEST  = fullfile(main_data.SOFT_HOME, 'test');
        
    end
    
    % Path modification (available only for development mode)
    %--------------------------------------------------------
    if ~isdeployed
        
        % software directories (Mandatory)
        addpath(DIR_SOFT_BIN);
        addpath(DIR_SOFT_GUI, genpath(DIR_SOFT_MATLAB), DIR_SOFT_C, DIR_SOFT_INC);
        addpath(genpath(DIR_SOFT_CLASS));
        addpath(genpath(DIR_SOFT_LIB));
        
        if exist(fullfile(main_data.SOFT_HOME, 'test'), 'dir') == 7
            
            addpath(DIR_SOFT_TEST);
            
        end
        
    end
    
    % Manage java library directory
    if exist(fullfile(DIR_SOFT_JAVA, 'GST.jar'), 'file')==2
        
        warning('off', 'all');
        javaaddpath(PATH_JAR);
        warning('on', 'all');
        
    end
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep();
    
catch exception_2
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep('ERROR', exception_2);
    
    % Update status
    % -------------
    is_initialization_ready = false;
    
end

%% User directory management (Mandatory)
%  -------------------------------------
% update starting interface
% -------------------------
user_information = user_information.updateStep();

try
    
    % Initialize local variable
    % -------------------------
    is_warning = false;
    
    % Define default user directories
    % -------------------------------
    [create_status, create_exceptions] = mt_manage_directories_pre(...
        main_data, 'all', DIR_USER_DATA, DIR_LOCAL_DATA);
    
    if ~create_status && isa(create_exceptions, 'MException')
        
        throw(create_exceptions)
        
    elseif ~create_status && iscell(create_exceptions)
        
        is_warning = true;
        throw(create_exceptions{1,1});
        
    end
    
    % Configuration file name definition
    %-----------------------------------
    main_data.SOFT_CFG_FILE = fullfile(DIR_USER_DATA, 'template.cfg');
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep();
    
catch exception_3
    
    % update starting interface
    % -------------------------
    if exist('is_warning', 'var') && is_warning
        
        user_information = user_information.endStep('WARNING', exception_3);
        
    else
        
        user_information = user_information.endStep('ERROR', exception_3);
        
        % Update status
        is_initialization_ready = false;
        
        
    end
    
end

%% Error management (Mandatory)
%  ----------------------------
% update starting interface
% -------------------------
user_information = user_information.updateStep();

try
    
    % Get error management parameterization
    % -------------------------------------
    % Filename definition for error tracking
    main_data.SOFT_LOGFILE = getenv('ERR_LOGFILE');
    
    % Define software developer email address (Mandatory)
    main_data.SOFT_DEVELOPER_MAIL = getenv('DEVELOPER_MAIL');
    
    % Define error storage directory name
    % -----------------------------------
    error_directory = fileparts(main_data.SOFT_LOGFILE);
    
    % Define directory
    % ----------------
    if ~exist(error_directory, 'dir')
        
        % Create the directory
        [create_status, error_msg, error_id] = mkdir(error_directory);
        
        % Manage error
        if ~create_status
            
            % Define the main exception
            create_exception = MException([obj_OUT.applicative_id, ...
                ':ManageDirectory:CreateErrorDirectory'], ...
                'Impossible to create the error directory %s.', ...
                error_directory);
            
            % Add the cause
            create_exception = create_exception.addCause(MException(...
                error_id, '%s', error_msg));
            
            % Update the exception list
            throw(create_exception);
            
        end
        
    end
    
    % Create and save the error manager object
    % ----------------------------------------
    err_manager = cErrorManager('figure_handle', 0);
    setappdata(0, 'ErrManager', err_manager);
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep();
    
catch exception_error_dir
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep('ERROR', ...
        exception_error_dir);
    
    % Update status
    % -------------
    is_initialization_ready = false;
    
end

%% Save main data structure (Mandatory)
%--------------------------------------
% update starting interface
% -------------------------
user_information = user_information.updateStep();

% Main structure saving (in the MATLAB main workspace)
% ----------------------------------------------------
main_data = LocalDefineAvailableLanguages(main_data);
setappdata(0, 'AvailableLanguages', main_data.SOFT_LANGUAGES);
setappdata(0, 'MainData', main_data);

% update starting interface
% -------------------------
user_information = user_information.endStep();

%% Configuration file checking
%  ---------------------------
% update starting interface
% -------------------------
user_information = user_information.updateStep();

try
    
    % Load default configuration structure
    % ------------------------------------
    user_data = tm_user_data;
    
    if exist(main_data.SOFT_CFG_FILE, 'file')
        
        % Configuration file loading
        user_data = upgrade(load(main_data.SOFT_CFG_FILE, '-mat'), ...
            user_data);
        
    end
    
    % Define default skin
    % -------------------
    if isempty(user_data.SKIN) || strcmpi(user_data.SKIN, 'default'); ...
            user_data.SKIN = 'initialisation'; end;
    
    % Save default work directory
    % ---------------------------
    if isempty(user_data.WORK_DIR); user_data.WORK_DIR = ...
            DIR_USER_DATA; end;
    
    % Save UserData structure
    % -----------------------
    setappdata(0, 'UserData', user_data);
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep();
    
catch exception_5
    
    % Save UserData structure
    % -----------------------
    if exist('user_data', 'var') && isstruct(user_data)
        
        setappdata(0, 'UserData', user_data);
        
    end
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep('ERROR', exception_5);
    
    % Update status
    % -------------
    is_initialization_ready = false;
    
end

%% Default Data management
% ------------------------
% update starting interface
% -------------------------
user_information = user_information.updateStep();

try
    
    % Test existence of default project
    % ---------------------------------
    [data_status, exceptions] = LocalDefineDefaultData(...
        main_data.SOFT_DATA_DEFAULT, user_data.WORK_DIR, ...
        main_data.SOFT_SHORT_NAME);
    
    if ~data_status && ~isempty(exceptions)
        
        current_exception = exceptions{1};
        throw(current_exception);
        
    end
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep();
    
catch exception_defautlt_data
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep('WARNING', ...
        exception_defautlt_data);
    
end

%% Software starting
%-------------------
% update starting interface
% -------------------------
user_information = updateStep(user_information);

if is_initialization_ready
    
    disp(' ');
    disp(' +-----------------------------------------------');
    disp([' | ', main_data.SOFT_NAME, ' v', main_data.SOFT_VERSION, ...
        ' is starting successfully...']);
    disp(' +-----------------------------------------------');
    disp(' ');
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep();
    
    % Collect error and warning and save them in LOG file
    % ---------------------------------------------------
    user_information.manageError(main_data.SOFT_LOGFILE);
    
    % Close starting interface
    % ------------------------
    pause(0.5);
    user_information.closeFigure();
    
    % Manage specific color warnings
    warning('off', 'MATLAB:hg:ColorSpec_None');
    
    % Launch main interface
    mt_main_gui;
    
else
    
    disp(' ');
    disp(' +-----------------------------------------------');
    disp(['| ', main_data.SOFT_NAME, ' v', main_data.SOFT_VERSION, ...
        ' will not start due to errors occuring during the initialization.']);
    disp(' +-----------------------------------------------');
    disp(' ');
    
    % update starting interface
    % -------------------------
    user_information = user_information.endStep();
    
    % Collect error and warning and save them in LOG file
    % ---------------------------------------------------
    user_information.manageError(main_data.SOFT_LOGFILE);
    
    % Close starting interface
    % ------------------------
    user_information.closeFigure();
    
end
%==========================================================================

function [status_OUT, exceptions_OUT] = LocalDefineDefaultData(...
    source_directory_IN, target_directory_IN, short_name_IN)
%==========================================================================
%% DESCRIPTION: Define Default data into the working directory
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   source_directory_IN     : source directory containing the default data
%   target_directory_IN     : targeted directory
%==========================================================================
% OUTPUT:
%==========================================================================
try
    % Initialize output variable
    % --------------------------
    status_OUT     = true;
    exceptions_OUT = {};
    
    % Define data status
    % ------------------
    % Manage no default data
    assert(exist(source_directory_IN, 'dir')==7, [short_name_IN, ...
        ':Startup:DefaultDataInitialization'], ['The default data ', ...
        'directory "%s" does not exist in the software sources.'], ...
        source_directory_IN);
    
    % Define the content of the default directory
    directory_content = dir(source_directory_IN);
    
    % Keep all directories except "." and ".."
    directory_content = directory_content([directory_content.isdir]);
    directory_content = ...
        directory_content(~ismember({directory_content.name}, {'.', '..'}));
    
    % Verify if the directory is not empty
    assert(~isempty(directory_content), [short_name_IN, ...
        ':Startup:DefaultDataInitialization'], ['The default data ', ...
        'directory "%s" is empty.'], source_directory_IN);
    
    % Detect if the project has been copied
    for i_dir=1:length(directory_content)
        
        if ~exist(fullfile(target_directory_IN, 'data', ...
                directory_content(i_dir).name), 'dir')
            
            copyfile(fullfile(source_directory_IN, ...
                directory_content(i_dir).name), ...
                fullfile(target_directory_IN, 'data', ...
                directory_content(i_dir).name));
            
        end
        
    end
    
catch exception
    
    status_OUT            = false;
    exceptions_OUT{end+1} = exception;
    
end
%==========================================================================

function main_data_OUT = LocalDefineAvailableLanguages(main_data_IN)
%==========================================================================
%% DESCRIPTION: Define default MainData structure
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   main_data_IN	: standard main data structure
%==========================================================================
% OUTPUT:
%   main_data_OUT   : Main data structure updated
%==========================================================================

% Initialize output
% -----------------
main_data_OUT = main_data_IN;

% Define constant data
% --------------------
DEFAULT_LANGUAGES = {'fr', 'en', 'us', 'sw', 'sp', 'por', 'jpn'};

% Define the languages available in the software
% -----------------------------------------------
if ~isempty(main_data_OUT.SOFT_DATA) && ...
        (~isfield(main_data_OUT, 'SOFT_LANGUAGES') || ...
        (isfield(main_data_OUT, 'SOFT_LANGUAGES') && ...
        isempty(main_data_OUT.SOFT_LANGUAGES)))
    
    % List available languages (correspond to directory found in the
    % screensize directory)
    languages_list = dir(main_data_OUT.SOFT_DATA);
    main_data_OUT.SOFT_LANGUAGES = {languages_list(...
        ismember({languages_list.name}, DEFAULT_LANGUAGES) & ...
        [languages_list.isdir]).name};
    
elseif ~isfield(main_data_OUT, 'SOFT_LANGUAGES') || ...
        isempty(main_data_OUT.SOFT_LANGUAGES)
    
    % By default, list of skins is empty
    main_data_OUT.SOFT_LANGUAGES = {''};
    
end
%==========================================================================

function step_list_OUT = LocalDefineInitialisationStep(varargin)
%==========================================================================
%% DESCRIPTION: Define the list of all step of the current startup phase
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin        : command line arguments to current subfunction
%                     LocalDefineInitialisationStep (see VARARGIN)
%==========================================================================
% OUTPUT:
%   step_list_OUT   : current interface handle
%==========================================================================
step_list_OUT = {...
    'Environment variable loading', ...
    'Directories definition and path update', ...
    'User directory management', ...
    'Error management initialization', ...
    'Main structure definition', ...
    'Configuration file checking', ...
    'Default data initialization', ...
    'Software starting'};
%==========================================================================

function main_data_OUT = LocalDefineMainData(varargin)
%==========================================================================
%% DESCRIPTION: Define default MainData structure
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin        : command line arguments to current subfunction
%                     LocalDefineMainData (see VARARGIN)
%==========================================================================
% OUTPUT:
%   main_data_OUT   : default main data structure
%==========================================================================
main_data_OUT = struct(...
    'SOFT_NAME',                    '', ...                     % Mandatory
    'SOFT_SHORT_NAME',              '', ...                     % Mandatory
    'SOFT_VERSION',                 '', ...                     % Mandatory
    'SOFT_HOME',                    '', ...                     % Mandatory
    'SOFT_LANGUAGES',               {''}, ...                   % Mandatory
    'SOFT_SCREENSIZES',             {''}, ...                  	% Mandatory
    'SOFT_COMMON_DIR',              '', ...                     % Mandatory
    'SOFT_CFG_FILE',                '', ...                     % Mandatory
    'SOFT_USER_GUIDE',              '', ...                     % Mandatory
    'SOFT_TECHNICAL_GUIDE',       	'', ...                     % Mandatory
    'SOFT_SG_PART1',                '', ...                     % Optional
    'SOFT_DEVELOPER_MAIL',          '', ...                     % Mandatory
    'SOFT_LOGFILE',                 '', ...                     % Mandatory
    'SOFT_DATA',                    '', ...                     % Mandatory
    'SOFT_DATA_DEFAULT',            '', ...                     % Optional
    'SOFT_DATA_SCREENSIZE',         '', ...                  	% Mandatory
    'SOFT_DATA_SKINS',              '', ...                  	% Mandatory
    'SOFT_DATA_PICTURE',            '', ...                  	% Mandatory
    'SOFT_DATA_LOG',                '', ...                     % Mandatory
    'SOFT_SKINS',                   '');                        % Mandatory
%==========================================================================
