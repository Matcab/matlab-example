function [status_OUT, error_message_OUT] = class_test(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: class_test.m
% PATH    : ..\common\@cIdentifiable\test
%==========================================================================
% ABSTRACT: Test the different methods of the object cIdentifiable
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      04/01/2013  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM: launch for each method a test
%   - Constructor
%   - Display
%   - Set methods
%   - Get methods
%==========================================================================
% INPUT:
%   obj_IN              : cIdentifiable object
%==========================================================================
% OUTPUT:
%   status_OUT          : Status about test success
%   error_message_OUT   : Error message
%==========================================================================
% Manage input argument: test the input object
% --------------------------------------------
if ~isa(obj_IN, 'cIdentifiable'); return; end;

if nargin>1 && ischar(varargin{1})
    
    test_status = varargin{1};
    
else
    
    test_status = 'all';

end

% output variable
status_OUT        = true;
error_message_OUT = {''};

% Display informations to the user
% --------------------------------
disp('=================================');
disp('***  Test class cIdentifiable ***');
disp('=================================');
disp(' ');

% Test the constructor (if several prototypes, test all of them)
% --------------------------------------------------------------
disp('-> cIdentifiable object constructor:');

% Basic constructor
try
    
    % Create default object
    new_obj = cIdentifiable;
    
catch exception_1
    
    % Define output
    status_OUT        = false;
    error_message_OUT = LocalDefineError(error_message_OUT, ...
        exception_1);
    
end

% Standard constructor
if ismember(test_status, {'all',  'constructor', 'standard_constructor'})

    try

        % Create default object
        new_obj = cIdentifiable('new', 'configuration');

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
assert(status_OUT, 'ClassIdentifiable:ClassTest:Constructor', ...
    'Error in cIdentifiable constructor.');

% Test the class display
% ----------------------
if ismember(test_status, {'all', 'constructor', 'display'})

    disp('-> cIdentifiable object display:');
    try

        % display object
        display(new_obj, 'long');

        if ~strcmp(questdlg('Is the object well displayed ?', ...
                'Display test'), 'Yes'); status_OUT = false; end;

    catch exception_3

        % Define output
        status_OUT        = false;
        error_message_OUT = LocalDefineError(error_message_OUT, ...
            exception_3);

    end

    % Display informations
    LocalDisplayInformation(error_message_OUT);
    
    % Manage error
    assert(status_OUT, 'ClassIdentifiable:ClassTest:Display', ...
        'Error in cIdentifiable display.');

end

% Test the class set method
% -------------------------
if ismember(test_status, {'all', 'standard_constructor', 'set_methods'})

    % Display information to the user
    disp('-> cIdentifiable object set methods:');
    
    try

        % Define new attributes values
        new_obj = new_obj.setID(2);
        
    catch exception_4

        % Define output
        status_OUT        = false;
        error_message_OUT = LocalDefineError(error_message_OUT, ...
            exception_4);

    end

    % Display informations
    LocalDisplayInformation(error_message_OUT);

    % Manage error
    assert(status_OUT, 'ClassIdentifiable:ClassTest:SetMethods', ...
        'Error in cIdentifiable set methods.');
    
end

% Test the class set method
% -------------------------
if ismember(test_status, {'all', 'set_methods', 'get_methods'})

    % Display information to the user
    disp('-> cIdentifiable object get methods:');
    
    try

        % Define new attributes values
        disp(['Object ID             : ', num2str(new_obj.getID)]);
        
    catch exception_5

        % Define output
        status_OUT        = false;
        error_message_OUT = LocalDefineError(error_message_OUT, ...
            exception_5);

    end

    % Display informations
    LocalDisplayInformation(error_message_OUT);

    % Manage error
    assert(status_OUT, 'ClassIdentifiable:ClassTest:GetMethods', ...
        'Error in cIdentifiable get methods');

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