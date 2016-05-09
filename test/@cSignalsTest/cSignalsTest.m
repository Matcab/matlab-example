classdef cSignalsTest < TestCase
    %======================================================================
    %% VOLVO GTT 2014
    %======================================================================
    % MATLAB CLASS TEST
    %======================================================================
    % FILENAME: cSignalsTest.m
    % PATH    : $TEMPLATE_HOME$\test\@cSignalsTest
    %======================================================================
    % ABSTRACT: Class testing Sginals class
    %======================================================================
    % REVISION HISTORY:
    %   AUTHOR                  COMPANY     DATE        COMMENT
    %	Mathieu CABANES         AROB@S      04/07/2014  Creation
    %
    %   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
    %======================================================================
    % ALGORITHM:
    %======================================================================
    % INPUT:
    %======================================================================
    % OUTPUT:
    %======================================================================
    
    % Attributes
    % ----------
    properties
        
        current_obj;
        example_directory;
        
    end
    
    % Methods
    % -------
    methods(Access = public)
        
        function obj_OUT = cSignalsTest(name)
            %==============================================================
            %% DESCRIPTION: Method used to manage the test case (Mandatory)
            %==============================================================
            
            obj_OUT = obj_OUT@TestCase(name);
            
        end
        %==================================================================
        
        function setUp(obj_IN)
            %==============================================================
            %% DESCRIPTION: Standard initialization used by all tests (optional)
            %==============================================================
            
            % Initialize the object
            obj_IN.current_obj = cSignals;
            
            % Define testing directory
            current_filename         = mfilename('fullpath');
            obj_IN.example_directory = fullfile(fileparts(fileparts(...
                fileparts(current_filename))), 'data','default');
            
        end
        %==================================================================
        
        function tearDown(obj_IN)
            %==============================================================
            %% DESCRIPTION: Clear object created for the test
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj; %#ok<NASGU>
            
            % Delete object
            clear tmp_obj;
            
        end
        %==================================================================
        
        function testCreateObject(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object creation
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Verify the object creation
            assertTrue(isa(tmp_obj, 'cSignals'));
            
        end
        %==================================================================
        
        function testCreateObject_ID(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object creation
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Verify the object creation
            assertTrue(~isempty(tmp_obj.getID));
            
        end
        %==================================================================
        
        function testManageName(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object name management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Verify the object creation
            assertEqual('', tmp_obj.getName);
            
            % Define the signal name
            tmp_obj = tmp_obj.setName('Test signal');
            
            % Verify the object creation
            assertEqual('Test signal', tmp_obj.getName);
            
        end
        %==================================================================
        
        function testManageName_withErrors(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object name management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Verify the object creation
            assertEqual('', tmp_obj.getName);
            
            % Verify the object creation
            assertExceptionThrown(@() tmp_obj.setName(12), ...
                'MATLAB:ClassCastException');
            
        end
        %==================================================================
        
        function testCreateObject_withName(obj_IN) %#ok<MANU>
            %==============================================================
            %% DESCRIPTION: test object name management
            %==============================================================
            
            % Initialize the object
            tmp_obj = cSignals('name', 'Test name');
            
            % Verify the object creation
            assertEqual('Test name', tmp_obj.getName);
            
        end
        %==================================================================
        
        function testManageFile(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object file management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            default_directory = obj_IN.example_directory;
            
            % Verify the object creation
            assertEqual('', tmp_obj.getFileName);
            
            % Define the signal name
            tmp_obj = tmp_obj.setFileName(fullfile(default_directory, ...
                'test_folder', 'Test_n°1_comp.mat'));
            
            % Verify the object creation
            assertEqual(fullfile(default_directory, 'test_folder', ...
                'Test_n°1_comp.mat'), tmp_obj.getFileName);
            
        end
        %==================================================================
        
        function testManageFile_withErrors(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object name management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Verify the object creation
            assertEqual('', tmp_obj.getFileName);
            
            % Verify the object creation
            assertExceptionThrown(@() tmp_obj.setFileName(12), ...
                'MATLAB:ClassCastException');
            
        end
        %==================================================================
        
        function testManageFile_notExistingFile(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object name management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Verify the object creation
            assertEqual('', tmp_obj.getFileName);
            
            % Verify the object creation
            assertExceptionThrown(@() tmp_obj.setFileName('default.m'), ...
                'MATLAB:FileNotFoundException');
            
        end
        %==================================================================
        
        function testManageFile_notMATFile(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object name management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            default_directory = obj_IN.example_directory;
            
            % Verify the object creation
            assertEqual('', tmp_obj.getFileName);
            
            % Verify the object creation
            assertExceptionThrown(@() tmp_obj.setFileName(fullfile(default_directory, ...
                'files_folder', 'batonode.m')), ...
                'MATLAB:IllegalArgumentException');
            
        end
        %==================================================================
        
        function testCreateObject_withFile(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object file management
            %==============================================================
            
            % Define the default directory
            default_directory = obj_IN.example_directory;
            
            % Initialize the object
            tmp_obj = cSignals('filename', fullfile(default_directory, ...
                'test_folder', 'Test_n°1_comp.mat'));
            
            % Verify the object creation
            assertEqual(fullfile(default_directory, ...
                'test_folder', 'Test_n°1_comp.mat'), tmp_obj.getFileName);
            
        end
        %==================================================================
        
        function testManageData(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object file management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Verify the object creation
            assertTrue(isempty(tmp_obj.getData));
            
            % Define a default structure
            data.re.dist.pos = 1:1:10;
            data.re.alt      = 1:100:1000;
            
            % Define the signal name
            tmp_obj = tmp_obj.setData(data);
            
            % Verify the object creation
            assertEqual(data, tmp_obj.getData);
            
        end
        %==================================================================
        
        function testManageData_withErrors(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object name management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Verify the object creation
            assertTrue(isempty(tmp_obj.getData));
            
            % Verify the object creation
            assertExceptionThrown(@() tmp_obj.setData(12), ...
                'MATLAB:ClassCastException');
            
        end
        %==================================================================
        
        function testManageData_initialization(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object name management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            default_directory = obj_IN.example_directory;
            
            % Verify the object creation
            assertTrue(isempty(tmp_obj.getData));
            
            % Define the file
            tmp_obj = tmp_obj.setFileName(fullfile(default_directory, ...
                'test_folder', 'Test_n°1_comp.mat'));
            
            % Initialize the data
            tmp_obj = tmp_obj.initialize;
            
            % Define the current data
            current_data = load(fullfile(default_directory, ...
                'test_folder', 'Test_n°1_comp.mat'), '-mat');
            
            % Verify the object creation
            assertEqual(current_data, tmp_obj.getData);
            
        end
        %==================================================================
        
        function testManageData_initialization_withFile(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object name management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            default_directory = obj_IN.example_directory;
            
            % Verify the object creation
            assertTrue(isempty(tmp_obj.getData));
            
            % Initialize the data
            tmp_obj = tmp_obj.initialize(fullfile(default_directory, ...
                'test_folder', 'Test_n°1_comp.mat'));
            
            % Define the current data
            current_data = load(fullfile(default_directory, ...
                'test_folder', 'Test_n°1_comp.mat'), '-mat');
            
            % Verify the object creation
            assertEqual(current_data, tmp_obj.getData);
            
        end
        %==================================================================
        
        function testManageData_initialization_name(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object name management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            default_directory = obj_IN.example_directory;
            
            % Verify the object creation
            assertTrue(isempty(tmp_obj.getData));
            
            % Initialize the data
            tmp_obj = tmp_obj.initialize(fullfile(default_directory, ...
                'test_folder', 'Test_n°1_comp.mat'));
            
            % Verify the object creation
            assertEqual('Test n°1', tmp_obj.getName);
            
        end
        %==================================================================
        
        function testManageSignalsList(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object file management
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Define a default structure
            data.re_out.position   = 1:1:10;
            data.re_out.altitude_m = 1:100:1000;
            
            % Define the signal name
            tmp_obj = tmp_obj.setData(data);
            
            % Define the signal name
            signals_list.name{1}  = 're_out.position';
            signals_list.unit{1}  = '';
            signals_list.value{1} = 1:1:10;
            signals_list.name{2}  = 're_out.altitude_m';
            signals_list.unit{2}  = 'm';
            signals_list.value{2} = 1:100:1000;
            
            
            % Verify the object creation
            assertEqual(signals_list, tmp_obj.getSignalsList);
            
        end
        %==================================================================
        
    end
    
end
%==========================================================================
