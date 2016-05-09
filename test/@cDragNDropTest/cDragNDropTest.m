classdef cDragNDropTest < TestCase
    %======================================================================
    %% VOLVO GTT 2014
    %======================================================================
    % MATLAB CLASS TEST
    %======================================================================
    % FILENAME: cDragNDropTest.m
    % PATH    : $TEMPLATE_HOME$\test\@cDragNDropTest
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
        handles;
        
    end
    
    % Methods
    % -------
    methods(Access = public)
        
        function obj_OUT = cDragNDropTest(name)
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
            
            % Define a figure
            tmp_handles.FgTest = figure('Tag', 'FgTest', 'Units', ...
                'pixels', 'Position', [200 200 500 400], 'Visible', 'off');
            tmp_handles.PnTest = uipanel('Tag', 'PnTest', 'Parent', ...
                tmp_handles.FgTest, 'Units', 'pixels', 'Position', ...
                [10 10 480 380]);
            tmp_handles.LbSources = uicontrol('Style', 'listbox', 'Tag', ...
                'LbSources', 'Parent', tmp_handles.PnTest, 'Units', ...
                'pixels', 'Position', [10 10 200 360], 'String', ...
                {'Test n°1','Test n°2', 'Test n°3'}, 'Value', 1);
            tmp_handles.EdTarget = uicontrol('Style', 'edit', 'Tag', ...
                'EdTarget', 'Parent', tmp_handles.PnTest, 'Units', ...
                'pixels', 'Position', [220 10 200 20], 'String', '');
            
            obj_IN.handles = tmp_handles;
            
            % Initialize the object
            obj_IN.current_obj = cDragNDrop;
            
        end
        %==================================================================
        
        function tearDown(obj_IN)
            %==============================================================
            %% DESCRIPTION: Clear object created for the test
            %==============================================================
            
            % Define the attributes
            tmp_obj     = obj_IN.current_obj; %#ok<NASGU>
            tmp_handles = obj_IN.handles;
            
            % Delete the figure
            delete(tmp_handles.FgTest);
            
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
            assertTrue(isa(tmp_obj, 'cDragNDrop'));
            
        end
        %==================================================================
        
        function testCreateObject_withError(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object creation
            %==============================================================
            
            % Define the figure handles
            tmp_handles = obj_IN.handles;
            
            % Verify the object creation
            assertExceptionThrown(@() cDragNDrop('figure_handle', ...
                tmp_handles.PnTest), 'ClassDragNDrop:InvalidParentFigure');
            
        end
        %==================================================================
        
        function testManageDragHandles(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object creation
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Initialize the figure handle
            tmp_handles = obj_IN.handles;
            
            % Verify if the attribute is empty by default
            assertTrue(isempty(tmp_obj.getDragHandles));
            
            % Define the drag handles
            tmp_obj = tmp_obj.setDragHandles(tmp_handles.LbSources);
            
            % Define a hanlde
            assertEqual(tmp_handles.LbSources, tmp_obj.getDragHandles);
        end
        %==================================================================
        
        function testManageDragHandles_ButtonDownFcn(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object creation
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Initialize the figure handle
            tmp_handles = obj_IN.handles;
            
            % Verify if the attribute is empty by default
            assertTrue(isempty(tmp_obj.getDragHandles));
            
            % Define the drag handles
            tmp_obj = tmp_obj.setDragHandles(tmp_handles.LbSources);
            
            % Initialize drag & drop
            tmp_obj = tmp_obj.initialize; %#ok<NASGU>
            
            % Define a hanlde
            assertEqual('@(src,event)processDragNDrop(obj_OUT,src,event)', ...
                char(get(tmp_handles.LbSources, 'ButtonDownFcn')));
        end
        %==================================================================
        
        function testManageDropHandles(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object creation
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Initialize the figure handle
            tmp_handles = obj_IN.handles;
            
            % Verify if the attribute is empty by default
            assertTrue(isempty(tmp_obj.getDropHandles));
            
            % Define the drag handles
            tmp_obj = tmp_obj.setDropHandles(tmp_handles.EdTarget);
            
            % Define a hanlde
            assertEqual(tmp_handles.EdTarget, tmp_obj.getDropHandles);
        end
        %==================================================================
        
        function testManageDropCallback(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object creation
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Verify if the attribute is empty by default
            assertTrue(isempty(tmp_obj.getDropCallback));
            
            % Define the drag handles
            tmp_obj = tmp_obj.setDropCallback({@DefineCallback, @DefineCallback});
            
            % Define a hanlde
            assertEqual({@DefineCallback, @DefineCallback}, tmp_obj.getDropCallback);
        end
        %==================================================================
        
        function testManageDropValidDrag(obj_IN)
            %==============================================================
            %% DESCRIPTION: test object creation
            %==============================================================
            
            % Initialize the object
            tmp_obj = obj_IN.current_obj;
            
            % Initialize the figure handle
            tmp_handles = obj_IN.handles;
            
            % Verify if the attribute is empty by default
            assertTrue(isempty(tmp_obj.getDropValidDrag));
            
            % Define the drag handles
            tmp_obj = tmp_obj.setDragHandles(tmp_handles.LbSources);

            % Define the drop handles
            tmp_obj = tmp_obj.setDropHandles(tmp_handles.EdTarget);

            % Define the drag handles
            tmp_obj = tmp_obj.setDropValidDrag({tmp_handles.EdTarget});
            
            % Define a hanlde
            assertEqual({{tmp_handles.EdTarget}}, tmp_obj.getDropValidDrag);
        end
        %==================================================================
        
    end
    
end
%==========================================================================
