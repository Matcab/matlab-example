function test_suite = testMtBasicGui %#ok<STOUT>
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% GST 2.1
%==========================================================================
% FILENAME: testMtBasicGui.m
% PATH    : $SOFT_HOME$\test
%==========================================================================
% ABSTRACT:  Function used to test basic interface creation
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES        	AROB@S      19/06/2014  Creation
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
figure_handle = mt_basic_gui('Visible', 'off', parent_figure_handle);
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
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StTitle_T1') && ...
                strcmpi(get(handles.StTitle_T1, 'style'), 'text'));
%==========================================================================

function testPnList(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnStandardFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnList_T2') && ...
                strcmpi(get(handles.PnList_T2, 'type'), 'uipanel'));
%==========================================================================

function testStDirectory(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StDirectory') && ...
                strcmpi(get(handles.StDirectory, 'style'), 'text'));
%==========================================================================

function testEdDirectory(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'EdDirectory') && ...
                strcmpi(get(handles.EdDirectory, 'style'), 'edit'));
%==========================================================================

function testPbDirectory(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PbDirectory') && ...
                strcmpi(get(handles.PbDirectory, 'style'), 'pushbutton'));
%==========================================================================

function testLbFiles(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'LbFiles') && ...
                strcmpi(get(handles.LbFiles, 'style'), 'listbox'));
%==========================================================================

function testStFiles(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StFiles') && ...
                strcmpi(get(handles.StFiles, 'style'), 'text'));
%==========================================================================

function testCbFormatList(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'CbFormatList') && ...
                strcmpi(get(handles.CbFormatList, 'style'), 'checkbox'));
%==========================================================================

function testPbEditFile(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PbEditFile') && ...
                strcmpi(get(handles.PbEditFile, 'style'), 'pushbutton'));
%==========================================================================

function testPnPlot(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnStandardFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnPlot_T2') && ...
                strcmpi(get(handles.PnPlot_T2, 'type'), 'uipanel'));
%==========================================================================

function testAxPlot(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnStandardFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'AxPlot') && ...
                strcmpi(get(handles.AxPlot, 'type'), 'axes'));
%==========================================================================

function testStCurveSelection(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StCurveSelection') && ...
                strcmpi(get(handles.StCurveSelection, 'style'), 'text'));
%==========================================================================

function testPmCurveSelection(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PmCurveSelection') && ...
                strcmpi(get(handles.PmCurveSelection, 'style'), 'popupmenu'));
%==========================================================================

function testPnOptions(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnStandardFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnOptions_T2') && ...
                strcmpi(get(handles.PnOptions_T2, 'type'), 'uipanel'));
%==========================================================================

function testRbLegend(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnStandardFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'RbLegend') && ...
                strcmpi(get(handles.RbLegend, 'style'), 'radiobutton'));
%==========================================================================

function testStColorSelection(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StColorSelection') && ...
                strcmpi(get(handles.StColorSelection, 'style'), 'text'));
%==========================================================================

function testPmColorSelection(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PmColorSelection') && ...
                strcmpi(get(handles.PmColorSelection, 'style'), 'popupmenu'));
%==========================================================================

function testPnValues(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnStandardFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnValues_T2') && ...
                strcmpi(get(handles.PnValues_T2, 'type'), 'uipanel'));
%==========================================================================

function testStValueX(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StValueX') && ...
                strcmpi(get(handles.StValueX, 'style'), 'text'));
%==========================================================================

function testEdValueX(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'EdValueX') && ...
                strcmpi(get(handles.EdValueX, 'style'), 'edit'));
%==========================================================================

function testStValueY(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StValueY') && ...
                strcmpi(get(handles.StValueY, 'style'), 'text'));
%==========================================================================

function testEdValueY(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'EdValueY') && ...
                strcmpi(get(handles.EdValueY, 'style'), 'edit'));
%==========================================================================

function testArguments(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isappdata(handles.FgBasic, 'ParentFigHdl'));
%==========================================================================

function testGuiManager(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'gui_fcn') && ...
                isa(handles.gui_fcn, 'cGuiManager'));
%==========================================================================

function testPbEditFile_icon(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertEqual({'icon','info'}, get(handles.PbEditFile, 'UserData'));
%==========================================================================

function testLanguage(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Verify the english initial language
% -----------------------------------
assertEqual('Browse', get(handles.PbDirectory, 'String'));
%==========================================================================

function testInitialization_list(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Verify the english initial language
% -----------------------------------
assertFalse(isempty(get(handles.EdDirectory, 'String')) && ...
    isempty(get(handles.LbFiles, 'String')));
%==========================================================================

function testInitialization_EdDirectoryState(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Verify the english initial language
% -----------------------------------
assertEqual('inactive', get(handles.EdDirectory, 'Enable'));
%==========================================================================

function testInitialization_LbFilesState(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Verify the english initial language
% -----------------------------------
assertEqual('on', get(handles.LbFiles, 'Enable'));
%==========================================================================

function testInitialization_LbFilesStateNoSelection(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Verify the english initial language
% -----------------------------------
assertFalse(isempty(get(handles.LbFiles, 'Value')));
%==========================================================================

function testInitialization_PbEditFileState(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Verify the english initial language
% -----------------------------------
assertEqual('on', get(handles.PbEditFile, 'Enable'));
%==========================================================================
