function test_suite = testMtMainGui %#ok<STOUT>
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% GST 2.1
%==========================================================================
% FILENAME: testSimulationGui.m
% PATH    : $SOFT_HOME$\test
%==========================================================================
% ABSTRACT:  Function used to test simulation interface creation
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES        	AROB@S      06/06/2014  Creation
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
figure_handle = mt_main_gui('Visible', 'off', parent_figure_handle);
%==========================================================================

function teardown(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function initializing each test
%==========================================================================

% Delete the interface
% --------------------
if ~isempty(figure_handle) && ishandle(figure_handle)
    
    % Define handles structure
    handles = guidata(figure_handle);
    
    % Reinitialize 
    mt_main_gui('ChangeMode',handles.MbStandard,[], handles);
    mt_main_gui('ChangeLanguage',handles.MbEn,[], handles);
   
    mt_main_gui('LocalClose');

end
%==========================================================================

function testPnStandardFigure(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnStandardFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnStandardFigure_T2') && ...
                strcmpi(get(handles.PnStandardFigure_T2, 'type'), 'uipanel'));
%==========================================================================

function testStBasicFigure(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StBasicFigure') && ...
                strcmpi(get(handles.StBasicFigure, 'style'), 'text'));
%==========================================================================

function testPbBasicFigure(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PbBasicFigure') && ...
                strcmpi(get(handles.PbBasicFigure, 'style'), 'pushbutton'));
%==========================================================================

function testStAdvancedFigure(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StAdvancedFigure') && ...
                strcmpi(get(handles.StAdvancedFigure, 'style'), 'text'));
%==========================================================================

function testPbAdvancedFigure(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PbAdvancedFigure') && ...
                strcmpi(get(handles.PbAdvancedFigure, 'style'), 'pushbutton'));
%==========================================================================

function testPnJavaFigure(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnJavaFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnJavaFigure_T2') && ...
                strcmpi(get(handles.PnJavaFigure_T2, 'type'), 'uipanel'));
%==========================================================================

function testStJavaFigure(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StJavaFigure') && ...
                strcmpi(get(handles.StJavaFigure, 'style'), 'text'));
%==========================================================================

function testPbJavaFigure(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PbJavaFigure') && ...
                strcmpi(get(handles.PbJavaFigure, 'style'), 'pushbutton'));
%==========================================================================

function testPnLibraryExample(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the Panel PnJavaFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PnLibraryExample_T2') && ...
                strcmpi(get(handles.PnLibraryExample_T2, 'type'), 'uipanel'));
%==========================================================================

function testStLibraryExample(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the text StBasicFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'StLibraryExample') && ...
                strcmpi(get(handles.StLibraryExample, 'style'), 'text'));
%==========================================================================

function testPbLibraryExample(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'PbLibraryExample') && ...
                strcmpi(get(handles.PbLibraryExample, 'style'), 'pushbutton'));
%==========================================================================

function testMbFile(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbFile') && ...
                strcmpi(get(handles.MbFile, 'type'), 'uimenu'));
%==========================================================================

function testMbClose(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbClose') && ...
                strcmpi(get(handles.MbClose, 'type'), 'uimenu'));
%==========================================================================

function testMbOptions(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbOptions') && ...
                strcmpi(get(handles.MbOptions, 'type'), 'uimenu'));
%==========================================================================

function testMbLanguages(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbLanguages') && ...
                strcmpi(get(handles.MbLanguages, 'type'), 'uimenu'));
%==========================================================================

function testMbScreensizes(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbScreensizes') && ...
                strcmpi(get(handles.MbScreensizes, 'type'), 'uimenu'));
%==========================================================================

function testMbMode(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbMode') && ...
                strcmpi(get(handles.MbMode, 'type'), 'uimenu'));
%==========================================================================

function testMbStandard(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbStandard') && ...
                strcmpi(get(handles.MbStandard, 'type'), 'uimenu'));
%==========================================================================

function testMbStandardCallback(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertEqual(['@(hObject,eventdata)mt_main_gui(''ChangeMode'',', ...
    'hObject,eventdata,guidata(hObject))'], char(get(...
    handles.MbStandard, 'Callback')));
%==========================================================================

function testMbAdvanced(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbAdvanced') && ...
                strcmpi(get(handles.MbAdvanced, 'type'), 'uimenu'));
%==========================================================================

function testMbAdvancedCallback(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertEqual(['@(hObject,eventdata)mt_main_gui(''ChangeMode'',', ...
    'hObject,eventdata,guidata(hObject))'], char(get(...
    handles.MbAdvanced, 'Callback')));
%==========================================================================

function testMbHelp(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbHelp') && ...
                strcmpi(get(handles.MbHelp, 'type'), 'uimenu'));
%==========================================================================

function testMbUserGuide(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbUserGuide') && ...
                strcmpi(get(handles.MbUserGuide, 'type'), 'uimenu'));
%==========================================================================

function testMbGuidelines(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbGuidelines') && ...
                strcmpi(get(handles.MbGuidelines, 'type'), 'uimenu'));
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

function testChangeLanguage(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Verify the english initial language
% -----------------------------------
assertEqual('File', get(handles.MbFile, 'Label'));

% Execute the French button callback
% ----------------------------------
mt_main_gui('ChangeLanguage',handles.MbFr,[],handles);

% Verify the english initial language
% -----------------------------------
assertEqual('Fichier', get(handles.MbFile, 'Label'));
%==========================================================================

function testChangeScreensize(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Verify the english initial language
% -----------------------------------
mt_main_gui('ChangeScreensize',handles.Mb1280x800,[],handles);
figure_position = get(handles.FgMain, 'Position');
assertEqual([500 500], figure_position(3:4));

% Execute the French button callback
% ----------------------------------
mt_main_gui('ChangeScreensize',handles.Mb800x600,[],handles);

% Verify the english initial language
% -----------------------------------
figure_position = get(handles.FgMain, 'Position');
assertEqual([500 480], figure_position(3:4));
%==========================================================================

function testCloseFigure(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Verify the english initial language
% -----------------------------------
assertEqual('LocalClose', char(get(figure_handle, 'CloseRequestFcn')));
%==========================================================================

function testKeyPressFunction(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Verify the english initial language
% -----------------------------------
tmp_callback = get(figure_handle, 'KeyPressFcn');
assertEqual('KeyPressFcn_callback', char(tmp_callback{1}));
%==========================================================================

function testChangeMode(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Verify the english initial language
% -----------------------------------
assertEqual('on', get(handles.MbStandard, 'Checked'));

% Execute the French button callback
% ----------------------------------
mt_main_gui('ChangeMode',handles.MbAdvanced,[], handles);

% Verify the english initial language
% -----------------------------------
assertEqual('on', get(handles.MbAdvanced, 'Checked'));
%==========================================================================

function testOpenBasicInterface(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Execute the French button callback
% ----------------------------------
mt_main_gui('PbBasicFigure_Callback',handles.PbBasicFigure,[], handles);

% Verify the english initial language
% -----------------------------------
assertTrue(ishandle(findobj('Tag', 'FgBasic')));
%==========================================================================

function testMbGuidelines_Part1(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Test creation of StConfigurations
% ---------------------------------
assertTrue(isstruct(handles)  && isfield(handles, 'MbGuidelinesPart1') && ...
                strcmpi(get(handles.MbGuidelinesPart1, 'type'), 'uimenu'));
%==========================================================================

function testOpenAdvancedInterface(figure_handle) %#ok<DEFNU>
%==========================================================================
%% DESCRIPTION: Function testing the creation of the button PbAdvancedFigure
%==========================================================================

% Get the handle structure
% ------------------------
handles = guidata(figure_handle);

% Execute the French button callback
% ----------------------------------
mt_main_gui('PbAdvancedFigure_Callback',handles.PbAdvancedFigure,[], handles);

% Verify the english initial language
% -----------------------------------
assertTrue(ishandle(findobj('Tag', 'FgAdvanced')));
%==========================================================================
