function test_suite = testMtAdvancedGui %#ok<STOUT>
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% GST 2.1
%==========================================================================
% FILENAME: testMtAdvancedGui.m
% PATH    : $SOFT_HOME$\test
%==========================================================================
% ABSTRACT:  Function used to test advanced interface creation
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES        	AROB@S      03/07/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%==========================================================================
% OUTPUT:
%==========================================================================

% Initialize the test suite
% -------------------------
initTestSuite;
%==========================================================================

function figure_handle = setup %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function initializing each test
%==========================================================================

% Get mandatory input for the interface
% -------------------------------------
parent_figure_handle = 0;

% Open the simulation module interface
% ------------------------------------
if ~isempty(findobj('Tag', 'FgAdvanced')); delete(findobj('Tag', ...
        'FgAdvanced')); end;
figure_handle = mt_advanced_gui('Visible', 'off', parent_figure_handle);
%==========================================================================

function teardown(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function initializing each test
%==========================================================================

% Delete the interface
% --------------------
if ~isempty(figure_handle) && ishandle(figure_handle)
    
    delete(figure_handle);
    
end
%==========================================================================

function testStTitle(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text testStTitle
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StTitle_T1') && ...
    strcmpi(get(handles.StTitle_T1, 'style'), 'text'));
%==========================================================================

function testPnSignals(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnSignal_T2
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnSignals_T2') && ...
    strcmpi(get(handles.PnSignals_T2, 'type'), 'uipanel'));
%==========================================================================

function testStSignalsSources(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text testStTitle
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StSignalsSources') && ...
    strcmpi(get(handles.StSignalsSources, 'style'), 'text'));
%==========================================================================

function testPmSignalsSources(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text testStTitle
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PmSignalsSources') && ...
    strcmpi(get(handles.PmSignalsSources, 'style'), 'popupmenu'));
%==========================================================================

function testLbSignals(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text testStTitle
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'LbSignals') && ...
    strcmpi(get(handles.LbSignals, 'style'), 'listbox'));
%==========================================================================

function testStSignalsFilter(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StSignalsFilter') && ...
    strcmpi(get(handles.StSignalsFilter, 'style'), 'text'));
%==========================================================================

function testEdSignalsFilter(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'EdSignalsFilter') && ...
    strcmpi(get(handles.EdSignalsFilter, 'style'), 'edit'));
%==========================================================================

function testPbSignalsFilter(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PbSignalsFilter') && ...
    strcmpi(get(handles.PbSignalsFilter, 'style'), 'pushbutton'));
%==========================================================================

function testPbAddSources(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAddSources
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PbAddSources') && ...
    strcmpi(get(handles.PbAddSources, 'style'), 'pushbutton'));
%==========================================================================

function testPnPlots(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnSignal_T2
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnPlots_T2') && ...
    strcmpi(get(handles.PnPlots_T2, 'type'), 'uipanel'));
%==========================================================================

function testPnPlotsDefinition(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnSignal_T2
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnPlotsDefinition_T2') && ...
    strcmpi(get(handles.PnPlotsDefinition_T2, 'type'), 'uipanel'));
%==========================================================================

function testStPlotsAbscissa(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StPlotsAbscissa') && ...
    strcmpi(get(handles.StPlotsAbscissa, 'style'), 'text'));
%==========================================================================

function testEdPlotsAbscissa(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'EdPlotsAbscissa') && ...
    strcmpi(get(handles.EdPlotsAbscissa, 'style'), 'edit'));
%==========================================================================

function testStPlotsOrdinate(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StPlotsOrdinate') && ...
    strcmpi(get(handles.StPlotsOrdinate, 'style'), 'text'));
%==========================================================================

function testEdPlotsOrdinate(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'EdPlotsOrdinate') && ...
    strcmpi(get(handles.EdPlotsOrdinate, 'style'), 'edit'));
%==========================================================================

function testPnPlotsExtraOrdinate(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnSignal_T2
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnPlotsExtraOrdinate') && ...
    strcmpi(get(handles.PnPlotsExtraOrdinate, 'type'), 'uipanel'));
%==========================================================================

function testStPlotsExtraOrdinate(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StPlotsExtraOrdinate') && ...
    strcmpi(get(handles.StPlotsExtraOrdinate, 'style'), 'text'));
%==========================================================================

function testEdPlotsExtraOrdinate(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'EdPlotsExtraOrdinate') && ...
    strcmpi(get(handles.EdPlotsExtraOrdinate, 'style'), 'edit'));
%==========================================================================

function testPbPlots(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PbPlots') && ...
    strcmpi(get(handles.PbPlots, 'style'), 'pushbutton'));
%==========================================================================

function testPbResetPlots(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PbResetPlots') && ...
    strcmpi(get(handles.PbResetPlots, 'style'), 'pushbutton'));
%==========================================================================

function testStPlotsInformation(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StPlotsInformation') && ...
    strcmpi(get(handles.StPlotsInformation, 'style'), 'text'));
%==========================================================================

function testAxPlots(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'AxPlots') && ...
    strcmpi(get(handles.AxPlots, 'type'), 'axes'));
%==========================================================================

function testTblSignals(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'TblSignals') && ...
    strcmpi(get(handles.TblSignals, 'type'), 'uitable'));
%==========================================================================

function testFgAdvanced_CloseRequestFcn(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertEqual('LocalClose', char(get(handles.FgAdvanced, 'CloseRequestFcn')));
%==========================================================================

function testFgAdvanced_InitializeObjects_panelCheckbox(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test graphical objects initialization
% -------------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'CbPlotsExtraOrdinateTitle_T2') && ...
    strcmpi(get(handles.CbPlotsExtraOrdinateTitle_T2, 'style'), 'checkbox'));
%==========================================================================

function testFgAdvanced_InitializeObjects_standardAddSources(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Define the standard mode
user_data = getappdata(handles.FgAdvanced, 'UserData');
user_data.MODE = 'standard';
setappdata(handles.FgAdvanced, 'UserData', user_data);

% Update interface
% ----------------
mt_advanced_gui('CbPlotsExtraOrdinateTitle_Callback', ...
    handles.CbPlotsExtraOrdinateTitle_T2, [], handles);

% Test graphical objects initialization
% -------------------------------------
assertEqual('off', get(handles.PbAddSources, 'Visible'));
%==========================================================================

function testFgAdvanced_InitializeObjects_advancedSignalsFilter(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Define the standard mode
user_data = getappdata(handles.FgAdvanced, 'UserData');
user_data.MODE = 'advanced';
setappdata(handles.FgAdvanced, 'UserData', user_data);

% Update interface
% ----------------
mt_advanced_gui('CbPlotsExtraOrdinateTitle_Callback', ...
    handles.CbPlotsExtraOrdinateTitle_T2, [], handles);

% Test graphical objects initialization
% -------------------------------------
assertEqual('off', get(handles.PbSignalsFilter, 'Visible'));
%==========================================================================

function testFgAdvanced_InitializeData_SignalsSources(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test graphical objects initialization
% -------------------------------------
assertEqual({'Test n°1', 'Test n°24', 'Test n°43'}', ...
    get(handles.PmSignalsSources, 'String'));
%==========================================================================

function testFgAdvanced_InitializeData_Signals(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Define the signals list
signals_data    = getappdata(handles.FgAdvanced, 'SignalsData');
current_signals = signals_data.getElement('Test n°1');
signals_list    = current_signals.getSignalsList;

% Test graphical objects initialization
% -------------------------------------
assertEqual(signals_list.name', get(handles.LbSignals, 'String'));
%==========================================================================

% function testFgAdvanced_UpdateData_Signals(figure_handle) %#ok<DEFNU>
% %==========================================================================
% %% DESCRIPTION: Function testing the creation of the text StSignalsFilter
% %==========================================================================
% 
% % Get the handle structure
% % ------------------------
% handles = guidata(figure_handle);
% 
% % Define the signals list
% signals_data    = getappdata(handles.FgAdvanced, 'SignalsData');
% current_signals = signals_data.getElement('Test n°24');
% signals_list    = current_signals.getSignalsList;
% 
% % Update popupmenu
% set(handles.PmSignalsSources, 'Value', 2);
% mt_advanced_gui('PmSignalsSources_Callback', handles.PmSignalsSources, ...
%     [], handles);
% 
% % Test graphical objects initialization
% % -------------------------------------
% assertEqual(signals_list.name', get(handles.LbSignals, 'String'));
% %==========================================================================

function testFgAdvanced_UpdateData_SignalsFilters(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Update filter
set(handles.EdSignalsFilter, 'String', 'tms_out*');
mt_advanced_gui('PbSignalsFilter_Callback', handles.PbSignalsFilter, ...
    [], handles);

% Test graphical objects initialization
% -------------------------------------
assertEqual({'tms_out.time', 'tms_out.currentGear_nu', ...
    'tms_out.selectedGear_nu'}', get(handles.LbSignals, 'String'));
%==========================================================================

function testFgAdvanced_UpdateData_Table(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Define the signals list
signals_data    = getappdata(handles.FgAdvanced, 'SignalsData');
current_signals = signals_data.getElement('Test n°1');
signals_list    = current_signals.getSignalsList;

% Test graphical objects initialization
% -------------------------------------
assertEqual(signals_list.value{1}, get(handles.TblSignals, 'Data'));
%==========================================================================

function testFgAdvanced_UpdateData_TableMultiSelection(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);
% Update filter
set(handles.LbSignals, 'Value', (1:2));
mt_advanced_gui('LbSignals_Callback', handles.LbSignals, ...
    [], handles);

% Define the signals list
signals_data    = getappdata(handles.FgAdvanced, 'SignalsData');
current_signals = signals_data.getElement('Test n°1');
signals_list    = current_signals.getSignalsList;

% Test graphical objects initialization
% -------------------------------------
assertEqual([signals_list.value{1}, signals_list.value{2}], ...
    get(handles.TblSignals, 'Data'));
%==========================================================================

function testFgAdvanced_UpdateData_TableMultiSelection_Filter(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Update table display
% --------------------
set(handles.LbSignals, 'Value', [1, 10, 11]);
mt_advanced_gui('LbSignals_Callback', handles.LbSignals, ...
    [], handles);

% Update filter
set(handles.EdSignalsFilter, 'String', 'tms_out*');
mt_advanced_gui('PbSignalsFilter_Callback', handles.PbSignalsFilter, ...
    [], handles);

% Define the signals list
signals_data    = getappdata(handles.FgAdvanced, 'SignalsData');
current_signals = signals_data.getElement('Test n°1');
signals_list    = current_signals.getSignalsList;

% Test graphical objects initialization
% -------------------------------------
assertEqual(signals_list.value{115}, get(handles.TblSignals, 'Data'));
%==========================================================================

function testFgAdvanced_InitializeDragNDrop_Drag(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Define the signals list
dragndrop = getappdata(handles.FgAdvanced, 'DragNDrop');

% Test graphical objects initialization
% -------------------------------------
assertEqual(handles.LbSignals, dragndrop.getDragHandles);
%==========================================================================

function testFgAdvanced_InitializeDragNDrop_Drop(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Define the signals list
dragndrop = getappdata(handles.FgAdvanced, 'DragNDrop');

% Test graphical objects initialization
% -------------------------------------
assertEqual([handles.EdPlotsAbscissa, handles.EdPlotsOrdinate, ...
    handles.EdPlotsExtraOrdinate], dragndrop.getDropHandles);
%==========================================================================

function testFgAdvanced_InitializeDragNDrop_Callback(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);
if isfield (handles, 'ImPlotsLogo'); tmp_handles = rmfield(handles, ...
        'ImPlotsLogo'); end; 

% Define the signals list
dragndrop = getappdata(handles.FgAdvanced, 'DragNDrop');

% Test graphical objects initialization
% -------------------------------------
assertEqual({{@mt_advanced_gui, 'EdPlots_Callback', handles.LbSignals, ...
    handles.EdPlotsAbscissa, tmp_handles}, {@mt_advanced_gui, ...
    'EdPlots_Callback', handles.LbSignals, handles.EdPlotsOrdinate, ...
    tmp_handles}, {@mt_advanced_gui, 'EdPlots_Callback', handles.LbSignals, ...
    handles.EdPlotsExtraOrdinate, tmp_handles}}, dragndrop.getDropCallback);
%==========================================================================

function testFgAdvanced_InitializePlots(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

assertTrue(isstruct(handles) && isfield(handles, 'ImPlotsLogo') && ...
    strcmpi(get(handles.ImPlotsLogo, 'Type'), 'image'));
%==========================================================================

function testFgAdvanced_InitializePlots_Update(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

assertEqual('off', get(handles.PbPlots, 'Enable'));
%==========================================================================

function testFgAdvanced_ManagePlots(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Define plots informations
% -------------------------
set(handles.EdPlotsAbscissa, 'String', 're_out.time');
set(handles.EdPlotsOrdinate, 'String', 're_out.actAltitude_m');
mt_advanced_gui('PbPlots_Callback', handles.PbPlots, [], handles);

% Get the updated handles
% -----------------------
handles = guidata(figure_handle);

% Get the signal data
% -------------------
signals_data    = getappdata(handles.FgAdvanced, 'SignalsData');
current_signals = signals_data.getElement('Test n°1');
signals_list    = current_signals.getSignalsList; 
current_data = [signals_list.value{strcmpi(signals_list.name, 're_out.time')}, ...
    signals_list.value{strcmpi(signals_list.name, 're_out.actAltitude_m')}];

% Check the existence of the curve
% --------------------------------
assertTrue(isstruct(handles) && isfield(handles, 'AxCurve'));

% Check the validity of data
% --------------------------
assertEqual(current_data , [get(handles.AxCurve, 'XData')', ...
    get(handles.AxCurve, 'YData')']);
%==========================================================================

function testFgAdvanced_ManagePlots_ExtraOrdinate(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Define plots informations
% -------------------------
set(handles.CbPlotsExtraOrdinateTitle_T2, 'Value', 1);
set(handles.EdPlotsAbscissa, 'String', 'drv_out.time');
set(handles.EdPlotsOrdinate, 'String', 'drv_out.currentGear_nu');
set(handles.EdPlotsExtraOrdinate, 'String', 'drv_out.selectedGear_nu');
mt_advanced_gui('PbPlots_Callback', handles.PbPlots, [], handles);

% Get the updated handles
% -----------------------
handles = guidata(figure_handle);

% Get the signal data
% -------------------
signals_data    = getappdata(handles.FgAdvanced, 'SignalsData');
current_signals = signals_data.getElement('Test n°1');
signals_list    = current_signals.getSignalsList; 
current_data = [signals_list.value{strcmpi(signals_list.name, 'drv_out.time')}, ...
    signals_list.value{strcmpi(signals_list.name, 'drv_out.currentGear_nu')}, ...
    signals_list.value{strcmpi(signals_list.name, 'drv_out.selectedGear_nu')}];

% Check the existence of the curve
% --------------------------------
assertTrue(isstruct(handles) && isfield(handles, 'AxCurve') && length(handles.AxCurve)==2);

% Check the validity of data
% --------------------------
assertEqual(current_data , [get(handles.AxCurve(1), 'XData')', ...
    cell2mat(get(handles.AxCurve, 'YData'))']);
%==========================================================================

function testFgAdvanced_ManagePlots_Reset(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StSignalsFilter
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Define plots informations
% -------------------------
set(handles.EdPlotsAbscissa, 'String', 're_out.time');
set(handles.EdPlotsOrdinate, 'String', 're_out.actAltitude_m');
mt_advanced_gui('PbPlots_Callback', handles.PbPlots, [], handles);

% Reset the graphic
% -----------------
mt_advanced_gui('PbResetPlots_Callback', handles.PbResetPlots, [], handles);

% Get the updated handles
% -----------------------
handles = guidata(figure_handle);

% Check the existence of the curve
% --------------------------------
assertTrue(isstruct(handles) && strcmpi('off', get(handles.PbPlots, 'Enable')));
%==========================================================================
% 
% function testFgAdvanced_UpdateData__AdvancedSignalsFilters(figure_handle) %#ok<DEFNU>
% %==========================================================================
% %% DESCRIPTION: Function testing the creation of the text StSignalsFilter
% %==========================================================================
% 
% % Get the handle structure
% % ------------------------
% handles = guidata(figure_handle);
% 
% % Get UserData
% % ------------
% user_data = getappdata(handles.FgAdvanced, 'UserData');
% user_data.MODE = 'advanced';
% setappdata(handles.FgAdvanced, 'UserData', user_data);
% 
% % Update interface
% mt_advanced_gui('CbPlotsExtraOrdinateTitle_Callback', ...
%     handles.CbPlotsExtraOrdinateTitle_T2, [], handles);
% 
% % Update filter
% set(handles.EdSignalsFilter, 'String', 'tms_out*');
% mt_advanced_gui('EdSignalsFilter_KeyPressFcn', handles.EdSignalsFilter, ...
%     [], handles);
% 
% % Test graphical objects initialization
% % -------------------------------------
% assertEqual({'tms_out.time', 'tms_out.currentGear_nu', ...
%     'tms_out.selectedGear_nu'}', get(handles.LbSignals, 'String'));
% %==========================================================================

