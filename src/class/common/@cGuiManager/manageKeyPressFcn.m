function obj_OUT = manageKeyPressFcn(obj_IN)
%==========================================================================
% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setScreensize.m
% PATH: ..\common\@cGuiManager
%==========================================================================
% ABSTRACT: Set the right screensize
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

% Manage different case of hidden command
% ---------------------------------------
switch get(obj_OUT.current_figure_handle, 'CurrentCharacter')
    
    case 19 
        
        % CASE Ctrl+S: Manage skins
        % -------------------------
        % Load the MainData structure
        main_data = getappdata(obj_OUT.current_figure_handle, 'MainData');
        
        % Abord treatment if no skin is found
        if ~isfield(main_data, 'SOFT_SKINS') || ...
                isempty(main_data.SOFT_SKINS) || all(cellfun(@isempty, ...
                main_data.SOFT_SKINS))
            
            return;
            
        elseif any(strcmpi(main_data.SOFT_SKINS, obj_OUT.skin))
            
            idx =  find(strcmpi(main_data.SOFT_SKINS, obj_OUT.skin));
            
        else
            
            idx = 1;
            
        end
        
        % Display available skins to user selection
        % ------------------------------------------
        selected_idx = listdlg( ...
            'Name',             'Skin selection', ...
            'PromptString',     'Select a skin', ...
            'InitialValue',     idx, ...
            'ListString',       main_data.SOFT_SKINS, ...
            'SelectionMode',    'single');
        
        if (isempty(selected_idx)); return; end;
        
        % Pause to refrsh display
        pause(0.1);
        
        % Update display
        % --------------
        obj_OUT = obj_OUT.setSkin(main_data.SOFT_SKINS{selected_idx}, ...
            {'save_skin'});
        
    case 8
        
        % CASE Ctrl+H: Hide objects on interface
        % --------------------------------------
        set(findobj(obj_OUT.current_figure_handle, 'Type', 'uicontrol', ...
            '-or', 'Type', 'uipanel'), 'Visible', 'off');
        
    case 21
        
        % CASE Ctrl+U: Manage unhiding objects on interface
        % -------------------------------------------------
        set(findobj(obj_OUT.current_figure_handle, 'Type', 'uicontrol', ...
            '-or', 'Type', 'uipanel'), 'Visible', 'on');
                        
end
%==========================================================================
