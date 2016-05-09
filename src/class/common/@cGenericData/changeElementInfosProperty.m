function obj_OUT = changeElementInfosProperty(obj_IN, varargin)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: changeElementInfosProperty.m
% PATH    : ..\class\common\@cGenericData
%==========================================================================
% ABSTRACT: Modify a parameter in the Infos of a specific element
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      01/06/2011  Creation
%	Marc BALME              AROB@S      23/06/2011  Avoid having several
%                                                   times the same name.
%   Marc BALME              AROB@S      25/07/2011  Standards update
%	Mathieu CABANES         AROB@S      22/01/2013  Migration to MATLAB
%                                                   2011b
%	Mathieu CABANES         AROB@S      26/02/2014  Quality update & speed
%                                                   optimization
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN                  : cGenericData to update
%   varargin                : see below
%==========================================================================
% OUTPUT:
%   obj_OUT                 : modified cGenericData
%==========================================================================
% EXCEPTION:
%   IllegalArgumentException
%   ClassCastException
%   NoSuchFieldException
%==========================================================================

% Manage input argument
% ---------------------
if length(varargin)<3 || length(varargin)>4; throw(...
        IllegalArgumentException()); end;

% Manage properties
% -----------------
if strcmp(varargin{1},'ID') && isnumeric(varargin{2})

    active_ID = true;
    ID_IN     = varargin{2};

    % Test ID
    if (~isInteger(ID_IN) || ~length(ID_IN)==1); throw(...
            ClassCastException('Integer required as ID')); end;

    property_name  = varargin{3};
    property_value = varargin{4};

else

    active_ID = false;
    name_IN   = varargin{1};

    % Test name
    if ~ischar(name_IN); throw(ClassCastException(...
            'String required as name element')); end;

    property_name  = varargin{2};
    property_value = varargin{3};

end

% Manage property name
% --------------------
if ~ischar(property_name); throw(ClassCastException(...
        'String required as property name')); end;

if ~active_ID

    % Get vehicle element
    element = obj_IN.getElementProperties(name_IN);
    ID_IN   = element.getID();

end

% Debug with subsref
% ------------------
obj_OUT = obj_IN;

% Get position
idx = (obj_OUT.Hashmap(:,1)==ID_IN);

if any(idx)

    % Get element
    tmp_element = obj_OUT.element(idx);

    switch (property_name)

        case 'name'

            element_struct = obj_OUT.getElementNameList();

            % Verify the unicity of the name
            while ismember(property_value, element_struct.name)

                property_value = [property_value,'_2']; %#ok<AGROW>

            end

            tmp_element = tmp_element.setName(property_value);

        case 'author'

            tmp_element = tmp_element.setAuthor(property_value);

        case 'comment'

            tmp_element = tmp_element.setComment(property_value);

        case 'version'

            tmp_element = tmp_element.setVersion(property_value);

        case 'modification'

            tmp_element = updateInfos(tmp_element);

        case 'creation'

            illegalaccess_exception = IllegalAccessException(...
                [property_name, ' cannot be modified']);
            throw(illegalaccess_exception);

        otherwise

            throw(NoSuchFieldException([property_name, ...
                ' is not a field of the object']));

    end

    % Update element
    % --------------
    obj_OUT.element(idx) = tmp_element;

end
%==========================================================================
