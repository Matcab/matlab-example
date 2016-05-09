classdef cSignalsDataTest < TestCase
    %======================================================================
    %% VOLVO GTT 2014
    %======================================================================
    % MATLAB CLASS TEST
    %======================================================================
    % FILENAME: cSignalsDataTest.m
    % PATH    : $TEMPLATE_HOME$\test\@cSignalsDataTest
    %======================================================================
    % ABSTRACT: Class testing SignalsData class
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
        
        function obj_OUT = cSignalsDataTest(name)
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
            obj_IN.current_obj = cSignalsData;
            
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
            assertTrue(isa(tmp_obj, 'cSignalsData'));

        end
        %==================================================================
                
   end
    
end
%==========================================================================
