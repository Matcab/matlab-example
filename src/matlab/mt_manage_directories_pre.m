function [status_OUT, exceptions_OUT] = tm_manage_directories_pre(...
    main_data_IN, creation_mode_IN, varargin)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% TEMPLATE MATLAB
%==========================================================================
% FILENAME: tm_manage_directories_pre.m
% PATH    : $TEMPLATE_HOME$\src\matlab
%==========================================================================
% ABSTRACT: Create work directory folders and subfolders
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         Arob@s      19/06/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   main_data_IN        : main data structure
%   creation_mode_IN    : selected creation mode
%   varargin            : command line arguments to
%                         tm_manage_directories_pre (see VARARGIN)
%==========================================================================
% OUTPUT:
%   status_OUT          : Status indicating if the creation process is well
%                         manage
%   exceptions_OUT      : exceptions catched during the process
%==========================================================================
try

    % Initialize output arguments
    % ---------------------------
    status_OUT     = true;
    exceptions_OUT = [];
 
    % Define input arguments
    % ----------------------
    if nargin>=3 && ischar(varargin{1})
        
        if strcmp(creation_mode_IN, 'all') || ...
                strcmp(creation_mode_IN, 'work_dir')
            
            work_directory = varargin{1};
            
            if nargin>=4 && ischar(varargin{2}) && ...
                    strcmp(creation_mode_IN, 'all')
                
                local_database_directory = varargin{2};
                
            end
            
        elseif strcmp(creation_mode_IN, 'database')
            
            work_directory           = '';
            local_database_directory = varargin{1};
            
        else
            
            work_directory           = '';
            local_database_directory = '';
            
        end
        
    else
        
        work_directory           = '';
        local_database_directory = '';
        
    end
    
    % Check input arguments
    assert(~(isempty(work_directory) && isempty(local_database_directory)), ...
        [main_data_IN.SOFT_SHORT_NAME ':SoftwareStartup:WorkDirectory'], ...
        'Impossible to create folders without main directory defintion.');
    
    % Create directories
    % ------------------
    if strcmp(creation_mode_IN, 'all') || ...
            strcmp(creation_mode_IN, 'work_dir')
        
        % CASE 1: Manage work directory
        % -----------------------------
        
        % Define names of mandatory subdirectories
        % ----------------------------------------
        % Directory which contains data
        data_directory  = fullfile(work_directory, 'data');
                
        % Check the existence of the main directory
        % -----------------------------------------
        if ~exist(work_directory, 'dir')
            
            % Create work directory
            [create_status, error_msg, error_id] = mkdir(work_directory);
  
            % Manage error
            if ~create_status
            
                % Define the main exception
                create_exception = MException([main_data_IN.SOFT_SHORT_NAME, ...
                    ':ManageDirectory:CreateWorkDirectory'], ...
                    'Impossible to create the work directory %s.', ...
                    work_directory);

                % Add the cause
                create_exception = create_exception.addCause(MException(...
                    error_id, '%s', error_msg));

                % Abort process
                throw(create_exception);
        
            end
            
        end
        
        % Check the existence of the project directory
        % ---------------------------------------------
        if ~exist(data_directory, 'dir')
            
            % Directories creation
            [create_status, error_msg, error_id] = mkdir(data_directory);
            
            % Manage error
            if ~create_status
            
                % Define the main exception
                create_exception = MException([main_data_IN.SOFT_SHORT_NAME, ...
                    ':ManageDirectory:CreateDataDirectory'], ...
                    'Impossible to create the data directory %s.', ...
                    data_directory);

                % Add the cause
                create_exception = create_exception.addCause(MException(...
                    error_id, '%s', error_msg));

                % Abort process
                throw(create_exception);
        
            end
                        
        end       
        
    end
        
catch exception
    
    % Update status
    % -------------
    status_OUT = false;
    
    % Manage errors
    % -------------
    exceptions_OUT = exception;
    
end
%==========================================================================
