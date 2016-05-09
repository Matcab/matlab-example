function mt_make(varargin)
%==========================================================================
%% VOLVO 3P 2014
%==========================================================================
% TEMPLATE v 3.0
%==========================================================================
% FILENAME: mt_make.m
% PATH    : $TEMPLATE_HOME$\utl
%==========================================================================
% ABSTRACT: MATLAB TEMPLATE compilation file
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE     	COMMENT
%	Mathieu CABANES         Arob@s      23/06/2014	Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%==========================================================================
% OUTPUT:
%==========================================================================
try
    
    % Initialize local variable
    % -------------------------
    additional_files = {};
    added_files      = '';
    added_libraries  = '';
    
    % Manage input argument
    % ---------------------
    if nargin>0
        
        % Argument should be defined as pair Parameter/Value
        if rem(nargin,2) == 0
            
            nb_arg = length(varargin);
            
        else
            
            nb_arg = length(varargin)-1;
            
        end
        
        % Manage all arguments
        for i_arg = 1:nb_arg
            
            switch varargin{i_arg}
                
                case 'add_files'
                    
                    if iscell(varargin{i_arg+1})
                        
                        additional_files = varargin{i_arg+1};
                        
                    elseif ischar(varargin{i_arg+1})
                        
                        additional_files{1} = varargin{i_arg+1};
                        
                    end
                    
                otherwise
                    
                    continue;
            end
            
        end
        
    end
    
    % Verify if the MainData structure is available
    % ---------------------------------------------
    if ~isappdata(0, 'MainData'); return; end;
    
    % Load MainData structure
    main_data = getappdata(0, 'MainData');
    
    % Software Compiling Display
    %---------------------------
    disp(' ');
    disp(' -----------------------------');
    disp([' ', main_data.SOFT_NAME ' compiling started...']);
    disp(' -----------------------------');
    
    % Define the current architecture (according to the computer and the
    % current MATLAB version): If the computer is a 64 bytes but the
    % installed MATLAB is a 32 bytes the command will return "win32".
    % ------------------------------------------------------------------
    architecture = computer('arch');
    
    % Define path & standard file names
    %  --------------------------------
    % Directories
    output_directory  = fullfile(main_data.SOFT_HOME, 'bin', architecture);
    sources_directory = fullfile(main_data.SOFT_HOME, 'src', 'C');
    utl_directory     = fullfile(main_data.SOFT_HOME, 'utl');
    
    % Files
    main_file        = fullfile(main_data.SOFT_HOME, 'bin', ...
        [lower(main_data.SOFT_SHORT_NAME), '_startup.m']);
    exe_file         = [lower(main_data.SOFT_SHORT_NAME), ...
        strrep(main_data.SOFT_VERSION, '.', ''), '_win'];
    
    % Positioning
    cd(utl_directory);
    
    % Manage compiling options
    % ------------------------
    % Mex options
    cmd_mexfiles     = 'mex -v';
    outdir_mexfiles  = ['-outdir ', output_directory];
    
    % MFiles options
    cmd_matfiles     = 'mcc -mv';
    outdir_matfiles  = [' -d ', output_directory];
    execute_matfiles = [' -o ', exe_file];
    
    % Manage added folder
    % -------------------
    if ~isempty(additional_files)
        
        for i_directory = 1:length(additional_files)
            
            if exist(additional_files{i_directory}, 'dir')==7
                
                added_files = [' -a ', fullfile(additional_files{...
                    i_directory}, '*.m')];
            end
            
        end
        
    end
    
    % Manage libraries folder
    % -----------------------
    if exist(fullfile(main_data.SOFT_HOME, 'src', 'java'), 'dir')==7
        
        java_files = dir(fullfile(main_data.SOFT_HOME, 'src', 'java', ...
            '*.jar'));
        
        if ~isempty(java_files)
            
            added_libraries = [' -I ', fullfile(main_data.SOFT_HOME, ...
                'src', 'java')];
            
        end
        
    end
    
    % Mex File compiling
    % ------------------
    mex_files = dir(fullfile(sources_directory, '*.c'));
    
    if ~isempty(mex_files)
        
        disp(' ');
        disp(' *** MEX Library files compiling...');
        
        % Create output directory if it does not exist
        if exist(output_directory, 'dir')~=7
            
            [status, message, message_id] = mkdir(output_directory);
            assert(status, message_id, message);
            
        end
        
        % Check licence availability
        assert(license('Checkout', 'matlab_coder') == 1, ...
            [main_data.SOFT_SHORT_NAME, ':SoftwareCompilation:NoLicences'], ...
            'No Matlab Coder licence available.');
        
        % Compile MEX files
        for i_file = 1, length(mex_files)
            
            disp(' ');
            disp(['     => process the file ', mex_files(i_file).name, ':']);
            eval([cmd_mexfiles, ' ', outdir_mexfiles, ' ', ...
                fullfile(sources_directory, mex_files(i_file).name)]);
            
        end
        
    end
    
    % Matlab File compiling
    % ---------------------
    disp(' ');
    disp(' *** MATLAB files compiling...');
    
    % Create output directory if it does not exist
    if exist(output_directory, 'dir')~=7
        
        [status, message, message_id] = mkdir(output_directory);
        assert(status, message_id, message);
        
    end
    
    % Check licence availability
    assert(license('Checkout', 'matlab_coder')==1, ...
        [main_data.SOFT_SHORT_NAME, ':SoftwareCompilation:NoLicences'], ...
        'No Matlab Coder licence available.');
    
    % Compile the software
    eval([cmd_matfiles, outdir_matfiles, execute_matfiles, ' ', ...
        added_libraries, added_files, main_file]);
    
    % Clean
    % -----
    disp(' ');
    disp(' *** Clean the directory...');
    
    % positioning into the output directory
    cd (output_directory);
    
    % tempory file deletion
    delete('*.c');
    delete('*.h');
    delete('*.o');
    
    % Software Compiling Display
    %---------------------------
    disp(' ');
    disp(' ---------------------------------------');
    disp([' ', main_data.SOFT_NAME ' compiling ended successfully.']);
    disp(' ---------------------------------------');
    disp(' ');
    
    % Manage end of compilation
    %  ------------------------
    % Question about Matlab quit
    response = questdlg(['To free the Compiler licence, you must end ', ...
        'your MATLAB session. Do you want to quit MATLAB?'], ...
        [main_data.SOFT_NAME ' compilation process'], 'Yes', 'No', 'Yes');
    
    % Manage the session ending
    if strcmp(response, 'Yes'); exit; end;
    
catch exception
    
    % Software Compiling Display
    %---------------------------
    disp(' ');
    disp(' ---------------------------------------');
    disp([' ', main_data.SOFT_NAME ' compiling failed.']);
    disp(' ---------------------------------------');
    disp(' ');
    
    % Manage the error
    % ----------------
    if isappdata(0, 'ErrManager')
        
        err_manager = getappdata(0, 'ErrManager');
        err_manager = err_manager.display(exception);
        setappdata(0, 'ErrManager', err_manager);
        
    else
        
        disp(exception.getReport);
        
    end
    
end
%==========================================================================

