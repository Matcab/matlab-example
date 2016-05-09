function obj_OUT = setIcon(obj_IN)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setIcon.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Set the right icon
%==========================================================================
% REVISION HISTORY:
%   AUTHOR      	COMPANY     DATE        COMMENT
%	Mathieu CABANES	AROB@S      23/09/2013  Class creation
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

% Initialize output variable
% --------------------------
obj_OUT = obj_IN;

% Define all the button handles
% -----------------------------
controls = findobj(obj_OUT.current_figure_handle, 'Style', ...
    'pushbutton', '-or', 'Style', 'togglebutton');

% Exit if no button
% -----------------
if isempty(controls); return; end;

% Icons setting according to button UserData structure
% ----------------------------------------------------
for i_control = 1:length(controls)
    
    % UserData selection
    current_data = get(controls(i_control), 'UserData');
    
    if ~isempty(current_data)
        
        % Properties index defining icon in the UserData
        icon_property_index = strcmpi(current_data(:,1), 'icon');
        image_name          = current_data{icon_property_index, 2};
        [~,~,image_ext]     = fileparts(image_name);
        
        % Complete name of the icon
        if exist(image_name, 'file') && ~isempty(image_name) && ...
                strcmpi(image_ext, '.png')
            
            icon_name = image_name;
            
        else
            
            % Load MainData structure
            main_data = getappdata(obj_OUT.current_figure_handle, ...
                'MainData');
            
            icon_name = fullfile(main_data.SOFT_DATA_PICTURE, ...
                [current_data{icon_property_index,2},'.png']);
            
        end
        
        if exist(icon_name, 'file')
            
            % colours of icons font according to Parent colour
            control_parent_hdl = get(controls(i_control), 'Parent');
            
            if strcmp(get(control_parent_hdl,'Type'), 'figure')
                
                back_color = get(control_parent_hdl, 'Color');
                
            else
                
                back_color = get(control_parent_hdl, 'BackgroundColor');
                
            end
            
            % Icon reading
            icon = LocalReadPicture(icon_name, 'BackgroundColor', back_color);
            
            % Icon setting on the button
            set(controls(i_control), 'CData', icon, 'String', '');
            
        end
        
    end
    
end
%==========================================================================

function map_OUT=LocalReadPicture(picture_path_IN,varargin)
% =========================================================================
% ABSTRACT:
% Read the picture and return it as RGB whatever the format is
% =========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%  toolbar_hdl_IN: toolbar handle
%==========================================================================
% OUTPUT:
%
%==========================================================================
map_OUT=imread(picture_path_IN,varargin{:});
if length(size(map_OUT))<3
    % indexed picture to manage differently
    % -------------------------------------
    [im_temp,map_temp]=imread(picture_path_IN,varargin{:});
    map_OUT=ind2rgb(im_temp,map_temp);
end

