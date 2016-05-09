function  [status_OUT, error_message_OUT] = class_test(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: class_test.m
% PATH    : ..\common\@cStartupGui\test
%==========================================================================
% ABSTRACT: Test the different methods of the object cStartupGui
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      15/07/2011  Creation
%	Mathieu CABANES         AROB@S      07/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM: launch for each method a test
%   - Constructor
%   - Display
%   - set methods
%   - get methods
%==========================================================================
% INPUT:
%   obj_IN              : cStartupGui object
%==========================================================================
% OUTPUT:
%   status_OUT          : Status about test success
%   error_message_OUT   : Error message
%==========================================================================
if ~isa(obj_IN, 'cStartupGui'); return; end;

% Manage input argument: test the input object
% --------------------------------------------
if nargin>1 && ischar(varargin{1})
    
    test_status = varargin{1};
    
else
    
    test_status = 'all';
    
end

% Initialize variables
% --------------------
% output variable
status_OUT        = true;
error_message_OUT = {''};

% Display informations to the user
% --------------------------------
disp('=================================');
disp('***  Test class cStartupGui   ***');
disp('=================================');
disp(' ');

% Test the constructor (if several prototypes, test all of them)
% --------------------------------------------------------------
disp('-> cStartupGui object constructor:');

% Basic constructor
try
    
    % Create default object
    new_obj = cStartupGui;
    
catch exception_1
    
    % Define output
    status_OUT        = false;
    error_message_OUT = LocalDefineError(error_message_OUT, ...
        exception_1);
    
end

% Standard constructor
if ismember(test_status, {'all',  'constructor', ...
        'standard_constructor', 'set_methods', 'get_methods'})
    
    try
        
        % Create standard object
        new_obj = cStartupGui('step', ...
            {'step 1 : today', 'step 2', 'step 3', 'step 4 : test on id'});
        
    catch exception_2
        
        % Define output
        status_OUT        = false;
        error_message_OUT = LocalDefineError(error_message_OUT, ...
            exception_2);
        
    end
    
end

% Display informations
LocalDisplayInformation(error_message_OUT);

% Manage error
assert(status_OUT, 'ClassStartupGui:ClassTest:Constructor', ...
    'Error in cStartupGui constructor.');

% Test the class display
% ----------------------
if ismember(test_status, {'all', 'constructor', 'display'})
    
    disp('-> cStartupGui object display:');
    
    try
        
        % display object
        display(new_obj, 'long');
        
        if ~strcmp(questdlg('Is the object well displayed ?', 'Display test'), ...
                'Yes'); status_OUT = false; new_obj.closeFigure(); end;
        
    catch exception_3
        
        % Define output
        status_OUT        = false;
        error_message_OUT = LocalDefineError(error_message_OUT, ...
            exception_3);
        
    end
    
    % Display informations
    LocalDisplayInformation(error_message_OUT);
    
    % Manage error
    assert(status_OUT, 'ClassStartupGui:ClassTest:Display', ...
        'Error in cStartupGui display.');
    
end

% Test the class set method
% -------------------------
if ismember(test_status, {'all', 'standard_constructor', 'set_methods', ...
        'get_methods'})
    
    % Display information to the user
    disp('-> cStartupGui object set methods:');
    
    try
        
        for i_step = 1:length(new_obj.step_list)

            % Update step status
            new_obj = updateStep(new_obj);
            
            exception = MException('ClassStartupGui:ClassTest:SetMethods', ...
                'Error/Warning message');

            % Manage specific steps            
            if i_step == 2; new_obj = new_obj.endStep('ERROR', exception);
            elseif i_step == 4; new_obj = new_obj.endStep('WARNING', exception);
            else new_obj = new_obj.endStep();
            end

        end
        
    catch exception_4
                
        % Define output
        status_OUT        = false;
        error_message_OUT = LocalDefineError(error_message_OUT, ...
            exception_4);
        
    end
    
    % Display informations
    LocalDisplayInformation(error_message_OUT);
    
    % Manage error
    assert(status_OUT, 'ClassStartupGui:ClassTest:SetMethods', ...
        'Error in cStartupGui set methods.');
    
end

% Test the class set method
% -------------------------
if ismember(test_status, {'all', 'standard_constructor', 'get_methods'})
    
    % Display information to the user
    disp('-> cStartupGui object get methods:');
    
    try
        
        new_obj.manageError();

        if strcmp(questdlg('Is the object well displayed ?', 'Display test'), ...
                'Yes'); new_obj.closeFigure(); end;

    catch exception_5
        
        % Delete figure
        if ~isempty(new_obj.FgStartupGui)
            
            delete(new_obj.FgStartupGui);
            
        end
        
        % Define output
        status_OUT        = false;
        error_message_OUT = LocalDefineError(error_message_OUT, ...
            exception_5);
        
    end
    
    % Display informations
    LocalDisplayInformation(error_message_OUT);
    
    % Manage error
    assert(status_OUT, 'ClassStartupGui:ClassTest:GetMethods', ...
        'Error in cStartupGui get methods.');
    
end

% Display informations to the user
% --------------------------------
disp('=================================');
disp('*** class tested successfully ***');
disp('=================================');
%==========================================================================

function error_message_OUT = LocalDefineError(error_message_IN, ...
    exception_IN)
% =========================================================================
%% DESCRIPTION: Update error message
% =========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   error_message_IN    : current error messages
%   exception_IN        : current error detected
%==========================================================================
% OUTPUT:
%   error_message_OUT   : update error messages
%==========================================================================
% Define output variable
% ----------------------
error_message_OUT = error_message_IN;

% Update error message
% --------------------
if isempty(error_message_OUT{1})
    
    error_message_OUT{1} = ...
        [exception_IN.identifier, ' - ', exception_IN.message];
    
else
    
    error_message_OUT{end+1} = ...
        [exception_IN.identifier, ' - ', exception_IN.message];
    
end
%==========================================================================

function LocalDisplayInformation(error_message_IN)
% =========================================================================
%% DESCRIPTION: Update error message
% =========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   error_message_IN    : current error messages
%   exception_IN        : current error detected
%==========================================================================
% OUTPUT:
%   error_message_OUT   : update error messages
%==========================================================================
% Update error message
% --------------------
if isempty(error_message_IN{1})
    
    disp('   => test performed succesfully.');
    
else
    
    for i_err = 1:length(error_message_IN)
        
        disp(['   => ERROR: ', error_message_IN{i_err}]);
        
    end
    
end

disp(' ');
%==========================================================================