function [status_OUT, error_message_OUT] = class_test(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: class_test.m
% PATH    : ..\common\@cLabel\test
%==========================================================================
% ABSTRACT: Test the different methods of the object cLabel
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      22/06/2011  Creation
%	Mathieu CABANES         AROB@S      03/01/2013  Migration to MATLAB
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
%   obj_IN              : cLabel object
%==========================================================================
% OUTPUT:
%   status_OUT          : Status about test success
%   error_message_OUT   : Error message
%==========================================================================
if ~isa(obj_IN, 'cLabel'); return; end;

% Manage input argument: test the input object
% --------------------------------------------
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
disp('***     Test class cLabel     ***');
disp('=================================');
disp(' ');

% Test the constructor (if several prototypes, test all of them)
% --------------------------------------------------------------
disp('-> cLabel object constructor:');

% Basic constructor
try
    
    % Create default object
    new_obj = cLabel;
    
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
        new_obj = cLabel('language', 'en', 'content', ...
            'This is an english lable');

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
assert(status_OUT, 'ClassInfos:ClassTest:Constructor', ...
    'Error in cLabel constructor.');

% Test the class display
% ----------------------
if ismember(test_status, {'all', 'constructor', 'display'})

    disp('-> cLabel object display:');
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
    assert(status_OUT, 'ClassInfos:ClassTest:Display', ...
        'Error in cLabel display.');

end

% Test the class set method
% -------------------------
if ismember(test_status, {'all', 'standard_constructor', 'set_methods'})

    % Display information to the user
    disp('-> cLabel object set methods:');
    
    try

        % Define new attributes values
        new_obj = new_obj.setLanguage('fr');
        new_obj = new_obj.setContent('Ceci est un label francais');
        
    catch exception_4

        % Define output
        status_OUT        = false;
        error_message_OUT = LocalDefineError(error_message_OUT, ...
            exception_4);

    end

    % Display informations
    LocalDisplayInformation(error_message_OUT);

    % Manage error
    assert(status_OUT, 'ClassInfos:ClassTest:SetMethods', ...
        'Error in cLabel set methods.');
    
end

% Test the class set method
% -------------------------
if ismember(test_status, {'all', 'set_methods', 'get_methods'})

    % Display information to the user
    disp('-> cLabel object get methods:');
    
    try

        % Define new attributes values
        disp(['Language              : ', new_obj.getLanguage()]);
        disp(['Content               : ', new_obj.getContent]);
        
    catch exception_5

        % Define output
        status_OUT        = false;
        error_message_OUT = LocalDefineError(error_message_OUT, ...
            exception_5);

    end

    % Display informations
    LocalDisplayInformation(error_message_OUT);

    % Manage error
    assert(status_OUT, 'ClassInfos:ClassTest:GetMethods', ...
        'Error in cLabel get methods');

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