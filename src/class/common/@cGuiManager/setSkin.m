function obj_OUT = setSkin(obj_IN, varargin)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setSkin.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Set the right skin
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      23/09/2013  Class creation
%	Michel OLPHE GALLIARD 	AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cGuiManager object
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cGuiManager object
%==========================================================================

% Manage input arguments
% ----------------------
if nargin>1 && ~ischar(varargin{1}); throw(ClassCastException(...
        'String required as input')); end;

if nargin>2 && ~iscell(varargin{2}); throw(ClassCastException(...
        'Cell required as input')); end;

% Initialize variable
% -------------------
% output
obj_OUT = obj_IN;

% local
selected_skin    = '';
specific_options = [];

% Manage input arguments
% ----------------------
if nargin > 1; selected_skin = varargin{1}; end;
if nargin > 2; specific_options = varargin{2}; end;

% Manage skin saving and initialisation
% -------------------------------------
if ~isempty(selected_skin) && ~isempty(specific_options) && ...
        any(strcmpi(specific_options, 'save_skin'))
            
    % Load mandatory data
    user_data = getappdata(obj_OUT.current_figure_handle, 'UserData');

    % Update user data with the new language
    user_data.SKIN = selected_skin;

    % Save user data structure
    setappdata(obj_OUT.current_figure_handle, 'UserData', user_data);
    
elseif isempty(selected_skin)

    % Initialize the skin with a default value
    selected_skin = 'default';
            
    % Define skin from the user data structure
    if ~isempty(obj_IN.current_figure_handle) && ...
            isappdata(obj_IN.current_figure_handle, 'UserData')
        
        % Define current MainData structure
        user_data = getappdata(obj_IN.current_figure_handle, ...
            'UserData');
        
        if isfield(user_data, 'SKIN')
            
            % Define the name of the label file
            selected_skin = user_data.SKIN;
            
        end
        
    end
    
end

% Set the skin in the cGuiManager object
% --------------------------------------
obj_OUT.skin = selected_skin;

% Verify if the filename is valid
% -------------------------------
if isempty(obj_OUT.skin_filename); return; end;

% Read the corresponding message filename
% ---------------------------------------
% open the file
fid = fopen(obj_OUT.skin_filename, 'r');

% Manage error in file opening
if (fid <0); return; end;

% Read file content
file_content  = textscan(fid, '%s%s', 'CommentStyle', '%');

% Close file
fclose(fid);

% Define properties characteristics
% ---------------------------------
object_characteristics = LocalDefineObjectProperties(file_content);

% Manage no definition
if isempty(object_characteristics); return; end;    

% Update object properties
% ------------------------
% Define selected object groups
object_groups = fieldnames(object_characteristics);

for i_object = 1:length(object_groups)
    
    % Inilialize local variable
    tag_list = {};
    
    % Get object handles
    % ------------------
    % Select object which type or style corresponding to group
    selected_object = findobj(obj_OUT.current_figure_handle, ...
        'Type', object_groups{i_object}, '-or', 'Style', ...
        object_groups{i_object});

    % When change skin do not take into account log listbox
    tmp_list = get(selected_object, 'Tag');
    
    if iscell(tmp_list)
        
        tag_list = tmp_list;
        
    elseif ischar(tmp_list)
        
        tag_list{1} = tmp_list;
        
    else
        
        tag_list = {};
        
    end
    
    if ~isempty(tag_list)
        
        selected_object = selected_object(~cell2mat(cellfun(@(x)(...
            strncmp(x,'Log',3)), tag_list, 'UniformOutput', false)));
        
    end
    
    % Manage specific object for titles
    if isempty(selected_object) && isfield(object_characteristics.(...
            object_groups{i_object}), 'suffix')
        
        % Title properties: select object which tag contains suffix
        selected_object = findobj(obj_OUT.current_figure_handle, ...
            '-regexp','Tag',['[A-z]+', object_characteristics.(...
            object_groups{i_object}).suffix, '$']);
        
    end
    
    % Apply properties
    % ----------------
    % List defined properties
    properties_list = fieldnames(object_characteristics.(object_groups{...
        i_object}));
    
    % Loop on properties
    for i_property = 1:length(properties_list)
        
        if ~isempty(selected_object)
            
            % Get handle of objects to apply property
            object_handle = findobj(selected_object, '-property', ...
                properties_list{i_property});
            
            % Remove children object
            object_handle(~ismember(object_handle, selected_object)) = [];
            
            % Set object property
            if ~isempty(str2num(object_characteristics.(object_groups{...
                    i_object}).(properties_list{i_property}))) && ...
                    ~isnan(all(all(str2num(object_characteristics.(...
                    object_groups{i_object}).(properties_list{...
                    i_property})))))%#ok<ST2NM>
                
                set(object_handle, properties_list{i_property}, str2num(...
                    object_characteristics.(object_groups{i_object}).(...
                    properties_list{i_property}))); %#ok<ST2NM>
                
            else
                
                set(object_handle, properties_list{i_property}, ...
                    object_characteristics.(object_groups{i_object}).(...
                    properties_list{i_property}));
                
            end
            
        end
        
    end
    
end

% Get figure handles
% ------------------
handles = guihandles(obj_OUT.current_figure_handle);

% Manage figure background image
% ------------------------------
% Delete image objects
delete(findobj(obj_OUT.current_figure_handle, 'UserData', 'img'));
delete(findobj(obj_OUT.current_figure_handle, 'Tag', 'AxBackground'));

% Verify image existence
if ~isempty(obj_OUT.skin_picture) && ...
        ~any(strcmpi(specific_options, 'no_background'))
    
    % Load image
    current_image = imread(obj_OUT.skin_picture);
    
    % No background axe exist in figure
    if isempty(findobj(obj_OUT.current_figure_handle, 'Tag', 'AxBackground'))
        
        % Create axe and define properties
        handles.AxBackground = axes(...
            'Parent',       obj_OUT.current_figure_handle, ...
            'Units',        'normalized', ...
            'Position',     [0 0 1 1], ...
            'Tag',          'AxBackground', ...
            'XTick',        [], ...
            'XTickLabel',   '', ...
            'YTick',        [], ...
            'YTickLabel',   '', ...
            'Color',        get(obj_OUT.current_figure_handle, 'Color'));
        
        % Put axe at the bottom of figure
        uistack(handles.AxBackground, 'bottom');
        
        % Set visibility to 'on'
        visibility = {'on'};
        
    else
        
        % Get current image Visible property
        visibility = cellstr(get(findobj(obj_OUT.current_figure_handle, ...
            'Parent', handles.AxBackground), 'Visible'));
        
    end
    
    % Display image in background axe
    if (ismember(visibility{1}, {'on', 'off'}) && nargin == 1)
        
        image(current_image, 'Parent', handles.AxBackground, 'Visible', ...
            visibility{1}, 'UserData', 'img');
    
    else
        
        image(current_image, 'Parent', handles.AxBackground, 'UserData', ...
            'img');
    
    end
    
    % Set background unvisible
    set(handles.AxBackground, 'Visible', 'off');
    
end

% Redraw icons if requested
% -------------------------
if any(strcmpi(specific_options, 'icon')); obj_OUT = obj_OUT.setIcon; end;
%==========================================================================

function struct_OUT = LocalDefineObjectProperties(file_content_IN)
% =========================================================================
%% DESCRIPTION: Create window and graphical objects
% =========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   color_IN    : interface background color
%   varargin	: command line arguments to startup_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%   handles     : current interface handle
%==========================================================================

% Initialize output
% -----------------
struct_OUT = [];

% Define properties characteristics
% ---------------------------------
index_group = find(strncmpi(file_content_IN{1}, '#', 1)==1);

% Manage no definition
if isempty(index_group); return; end;

% Define characteristics for each group
for i_group = 1:length(index_group)

    current_group = lower(strrep(file_content_IN{1}{index_group(...
        i_group)}, '#', ''));
    
    % Define starting index
    starting_index = index_group(i_group)+1;
    
    % Define ending index
    if i_group<length(index_group)
       
        ending_index = index_group(i_group+1)-1;
        
    else
        
        ending_index = length(file_content_IN{1});
        
    end
       
    % Define properties for each group
    for i_property = starting_index:ending_index
       
        struct_OUT.(current_group).(file_content_IN{1}{i_property}) = ...
            file_content_IN{2}{i_property};
        
    end
    
end
%==========================================================================
