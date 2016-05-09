function [children_hdl_OUT, parent_hdl_list_OUT] = getOpenChildrenFigure(parent_hdl_IN)
%==========================================================================
%% VOLVO 3P 2011
%==========================================================================
% GSP-SIMULATION 2.0
%==========================================================================
% FILENAME: getOpenChildrenFigure.m
% PATH    : ..\src\matlab\
%==========================================================================
% ABSTRACT:  Function defining all children figures
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	M. CABANES              AROB@S      17/11/2011  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
% parent_figure_hdl_IN      : handle of the parent figure
% varargin               	: command line input of getOpenChildrenFigure
%                            (see VARARGIN)
%==========================================================================
% OUTPUT:
% children_figure_hdl_OUT  	: handle of the children figure
%==========================================================================
% Define current open figure
% --------------------------    
hdl_list = findobj('Type', 'Figure');

% Define first Children Level
% ---------------------------    
children_hdl_OUT = LocalGetChildren(parent_hdl_IN, hdl_list);

% Define parent of figure in the list
% -----------------------------------
parent_hdl_list_OUT = LocalGetParent(parent_hdl_IN, hdl_list);

for i_hdl = 1:length(parent_hdl_list_OUT)

    if ~isempty(find(children_hdl_OUT == parent_hdl_list_OUT(i_hdl),1))
    
        children_hdl_OUT = unique([children_hdl_OUT, ...
            LocalGetChildren(parent_hdl_list_OUT(i_hdl), hdl_list)]); %#ok<AGROW>
    
    end

end
% =========================================================================

function children_hdl_OUT = LocalGetChildren(parent_hdl_IN, hdl_list_IN)
% =========================================================================
%% DESCRIPTION: Initialize main interface of GST
% =========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
% hObject   : handle to figure
% eventdata : reserved - to be defined in a future version of MATLAB
% handles   : structure with handles and user data (see GUIDATA)
% varargin  : command line arguments to gst_main_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================
% Initialize output 
% -----------------
children_hdl_OUT = [];

% Define children in figure list
% ------------------------------
for i_handle = 1:length(hdl_list_IN)

    if isappdata(hdl_list_IN(i_handle), 'ParentFigHdl') && ...
            getappdata(hdl_list_IN(i_handle), 'ParentFigHdl') == ...
            parent_hdl_IN

        children_hdl_OUT = [children_hdl_OUT, hdl_list_IN(i_handle)]; %#ok<AGROW>

    end
    
end
%==========================================================================

function parent_hdl_OUT = LocalGetParent(parent_hdl_IN, hdl_list_IN)
% =========================================================================
%% DESCRIPTION: Initialize main interface of GST
% =========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
% hObject   : handle to figure
% eventdata : reserved - to be defined in a future version of MATLAB
% handles   : structure with handles and user data (see GUIDATA)
% varargin  : command line arguments to gst_main_gui (see VARARGIN)
%==========================================================================
% OUTPUT:
%==========================================================================
% Initialize output 
% -----------------
parent_hdl_OUT = [];

% Define parent figure of each open figures
% -----------------------------------------
for i_hdl = 1:length(hdl_list_IN)

    if isappdata(hdl_list_IN(i_hdl), 'ParentFigHdl') && ...
             getappdata(hdl_list_IN(i_hdl), 'ParentFigHdl') ~= parent_hdl_IN
       
        parent_hdl_OUT = [parent_hdl_OUT, getappdata(hdl_list_IN(i_hdl), ...
            'ParentFigHdl')]; %#ok<AGROW>
        
    end

end
%==========================================================================
