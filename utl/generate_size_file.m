function generate_size_file(varargin)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% MATLAB TEMPLATE
%==========================================================================
% FILENAME: generate_size_file.m
% PATH: £SOFT_HOME£\utl
%==========================================================================
% ABSTRACT: Define the resize text files
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%   Laurent VAYLET          AROB@S      27/01/2006  Creation
%   Maxime CAZENAVE         ENSE3       23/06/2010  update to facilitate
%                                                   its use
%   Mathieu CABANES         AROB@S      25/08/2011  Update for GST
%   Mathieu CABANES       	AROB@S      19/06/2014  Insert into the
%                                                   template
%
%   <NAME>         <COMPANY>    <DATE>       <COMMENT>
%==========================================================================

% Manage input argument
% ---------------------
if nargin == 1 && isnumeric(varargin{1})

    factor = varargin{1};

else

    factor = 1;

end

% Define default directories
% --------------------------
if isappdata(0, 'MainData')

    % load MainData structure
    main_data = getappdata(0,'MainData');

    % Define default path
    figure_path = fullfile(main_data.SOFT_HOME, 'src', 'gui');

    % define text files path
    if isappdata(0, 'UserData')

        % Get UserData structure
        user_data = getappdata(0, 'UserData');
        
        % Define path
        text_path = fullfile(main_data.SOFT_HOME, 'data', 'screensize', ...
            user_data.SCREEN_SIZE);

    else
       
        % Define path
        text_path = fullfile(main_data.SOFT_HOME, 'data', 'screensize', ...
            '1280x800');        
        
    end
        
else

    default_path = 'C:\';

    % Select the figure directory
    figure_path = uigetdir(default_path, ...
        'Select the directory containg the figure files:');

    % Manage cancel button
    if isnumeric(figure_path); return; end;

    % Select the figure directory
    text_path = uigetdir(default_path, ...
        'Select the directory containg the text files:');

    % Manage cancel button
    if isnumeric(text_path); return; end;
    
end

% Select figure files
% -------------------
[file_name, path_name, filter] = uigetfile({'*.fig', ...
    'Select FIG Files (*.fig)'}, 'Select figure files:', ...
    figure_path, 'MultiSelect', 'on'); %#ok<NASGU>

% Manage cancel button
if isnumeric(file_name); return; end;

% Manage only one file selected
if ~iscell(file_name); 
    
    filenames{1} = file_name;
    
else
    
    filenames = file_name;
    
end

for i_file = length(filenames)

    % Define file names
    fig_filename  = fullfile(path_name, filenames{i_file});
    text_filename = fullfile(text_path, strrep(filenames{i_file}, ...
        '.fig', '.txt'));

    % Load FIG file
    % -------------
    fig = open(fig_filename);
    set(fig, 'Visible', 'off');

    % Set all objects in pixels
    % -------------------------
    set(findall(fig, '-property', 'Units'), 'Units', 'pixels');

    % Find all objects which have a Position property
    % -----------------------------------------------
    pos_obj = findobj(fig, '-property', 'Position');

    % Get objects properties
    % ----------------------
    obj_prop = [get(pos_obj, 'Tag'), get(pos_obj, 'Position')];

    % Remove unwanted lines
    % ---------------------
    obj_prop(strcmpi(obj_prop(:,1), ''),:) = [];
    obj_prop(cell2mat(cellfun(@(x) (length(x)~=4), obj_prop(:,2), ...
        'UniformOutput', false)), :) = [];

    % Convert data
    % ------------
    obj_prop(:,2) = cellfun(@(x) ((x).*factor), obj_prop(:,2), ...
        'UniformOutput', false);

    % Close figure
    % ------------
    delete(fig);

    % Create file content
    % -------------------
    txt_content = [];
    
    for i_line = 1:size(obj_prop, 1)
    
        txt_content = sprintf('%s\n%s\t\t\t\t[%g %g %g %g]', ...
            txt_content, obj_prop{i_line, 1}, obj_prop{i_line, 2});
    
    end

    % Write file
    % ----------
    fid = fopen(text_filename, 'wt');
    fprintf(fid, '%s', txt_content);
    fclose(fid);
    
end

display('FIGSize2Txt ends sucessfully');
%==========================================================================
