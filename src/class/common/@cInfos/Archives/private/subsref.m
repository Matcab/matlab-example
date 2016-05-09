function varargout=subsref(obj_IN,struct_IN)
%==========================================================================
%% VOLVO 3P 2011
%==========================================================================
% GSP-SIMULATION 2.0
%==========================================================================
% FILENAME: subsref.m
% PATH    : ..\class\vehicle\@cVehicle
%==========================================================================
% ABSTRACT: subsref of cVehicle
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      08/06/2011  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN            : cVehicle object
%   struct_IN         : special struct for assignation
%==========================================================================
% OUTPUT:
%   varargout         : desired output
%==========================================================================
%manage different cases
switch struct_IN(1).type
    case '.'
        %get subfield
        varargout{1}=obj_IN.(struct_IN(1).subs);
        %propage subsref
        if length(struct_IN)>1
            varargout{1}=subsref(varargout{1},struct_IN(2:end));
        end
    case '()'
        idx=0;
        %check if it is a boolean vector or an index number
        if all(struct_IN(1).subs{:})==0
            struct_IN(1).subs{1}=find(struct_IN(1).subs{:});            
        end
        %treat each value
        for sub_i=struct_IN(1).subs{:}
            idx=idx+1;
            %get the element
            varargout{idx}=obj_IN(sub_i);
            %propage subsref
            if length(struct_IN)>1
                varargout{idx}=subsref(varargout{idx},struct_IN(2:end));
            end
        end
end