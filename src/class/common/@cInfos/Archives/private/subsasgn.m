function obj_OUT=subsasgn(obj_IN,struct_IN,value_IN)
%==========================================================================
%% VOLVO 3P 2011
%==========================================================================
% GSP-SIMULATION 2.0
%==========================================================================
% FILENAME: subsasgn.m
% PATH    : ..\class\common\@cGenericData
%==========================================================================
% ABSTRACT: subsasgn of cGenericData
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
%   obj_IN            : cGenericData object
%   struct_IN         : special struct for assignation
%   value_IN          : value ot assign
%==========================================================================
% OUTPUT:
%   obj_OUT           : updated object
%==========================================================================
%initialize output
obj_OUT=obj_IN;

%manage different cases
switch struct_IN(1).type
    case '.'
        if length(struct_IN)>1
            tmp_element=obj_OUT.(struct_IN(1).subs);
            tmp_element=subsasgn(tmp_element,struct_IN(2:end),value_IN);
        else
            tmp_element=value_IN;
        end
        obj_OUT.(struct_IN(1).subs)=tmp_element;

    case '()'
        %check if it is a boolean vector or an index number
        if all(struct_IN(1).subs{:})==0
            struct_IN(1).subs{1}=find(struct_IN(1).subs{:});            
        end
        for sub_i=struct_IN(1).subs{:}
            if length(struct_IN)>1
                %get the desired element
                tmp_element=obj_OUT.element(sub_i);
                tmp_element=subsasgn(tmp_element,struct_IN(2:end),value_IN);
            else
                tmp_element=value_IN;
            end
            obj_OUT(sub_i)=tmp_element;
        end

end