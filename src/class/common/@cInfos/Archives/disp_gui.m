function obj_OUT=disp_gui(obj_IN,varargin)
%==========================================================================
%% VOLVO 3P 2011
%==========================================================================
% GSP-SIMULATION 2.0
%==========================================================================
% FILENAME: disp_gui.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: display a gui for modifying the object
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      10/05/2011  Creation
%	Marc BALME              AROB@S      24/08/2011  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN          : cInfos object to update
%   varargin        : pair parameter name/value
%==========================================================================
% OUTPUT:
%   obj_OUT         : cInfos object modified
%==========================================================================
read_only=false;
for var_i=1:2:length(varargin)
    switch (varargin{var_i})
        case 'read_only'
            if ischar(varargin{var_i+1}) && strcmp(varargin{var_i+1},'on')
                read_only=true;
            end
    end
end

struct_data=cInfos_data;
list_fields=fields(struct_data);

%create figure
h_fig=figure('units','pixels',...
    'position',[250 250 ,310 ,50+length(list_fields)*25],...
    'numbertitle','off',...
    'name',['Data of ',obj_IN.name],...
    'Toolbar','none',...
    'color',[0.925 0.914 0.847],...
    'WindowStyle','modal');
setappdata(h_fig,'Data',obj_IN);

idx=0;
for var_i=length(list_fields):-1:1
    uicontrol('style','text',...
        'units','pixels',...
        'position',[5 50+idx*25 100 20],...
        'string',list_fields{var_i});
    handles.(list_fields{var_i})=uicontrol('style','edit',...
        'units','pixels',...
        'position',[105 50+idx*25 200 20],...
        'string',obj_IN.(list_fields{var_i}));
    idx=idx+1;
end
setappdata(h_fig,'handles',handles);

if read_only
    h_ok=uicontrol('style','pushbutton',...
        'units','pixels',...
        'position',[140 5 50 30],...
        'string','Ok',...
        'callback',@Close);
else
    h_ok=uicontrol('style','pushbutton',...
        'units','pixels',...
        'position',[100 5 50 30],...
        'string','Ok',...
        'callback',@Update);
    h_cancel=uicontrol('style','pushbutton',...
        'units','pixels',...
        'position',[160 5 50 30],...
        'string','Cancel',...
        'callback',@Close);
end
%wait for validation
uiwait(gcf);
pause(0.5);

%initialize output
obj_OUT=getappdata(h_fig,'Data');

%close windows
close(h_fig);


function Close(varargin)
%==========================================================================
%% DESCRIPTION: Close the window
%==========================================================================
%% ALGORITHM:
%==========================================================================
%% INPUT:
%   varargin :  not used for the moment
%==========================================================================
%% OUTPUT:
%==========================================================================
uiresume(gcf);

function Update(varargin)
%==========================================================================
%% DESCRIPTION: Update the data
%==========================================================================
%% ALGORITHM:
%==========================================================================
%% INPUT:
%   varargin :  not used for the moment
%==========================================================================
%% OUTPUT:
%==========================================================================

%get current handle
h_fig=gcf;

%get data
obj=getappdata(h_fig,'Data');

%get handles
handles=getappdata(h_fig,'handles');

%get list of field
field_list=fields(handles);

%update field
for var_i=1:length(field_list)
    %get current value
    current_value=get(handles.(field_list{var_i}),'String');
    %verification of the field
    switch field_list{var_i}
        case 'creation' %check if it is well a date
            try
                datenum(current_value)
            catch
                continue;
            end
        case 'modification' %check if it is well a date
            try
                datenum(current_value)
            catch
                continue;
            end
        case 'version' %check if it is well a number
            if isempty(str2num(current_value))
                continue;
            end
    end
    obj.(field_list{var_i})=current_value;
end
%check that creation is at least equal to the last modification
if datenum(obj.creation)>datenum(obj.modification)
    %update field
    obj.creation=obj.modification;
end

%save changes
setappdata(h_fig,'Data',obj);

%close the application
uiresume(h_fig);