function obj_OUT = setFootNoteEnable(obj_IN, state_IN)
%==========================================================================
% VOLVO GTT 2014
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: setError.m
% PATH: ..\common\@cErrorManager
%==========================================================================
% ABSTRACT: Set the error
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Michel OLPHE GALLIARD 	AROB@S      18/04/2014  Creation
%
%   <NAME>       	<COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cErrorManager object
%   state_IN    : boolean, true if footnote visible, false otherwise
%==========================================================================
% OUTPUT:
%   obj_OUT     : Updated cErrorManager object
%==========================================================================
if ~islogical(state_IN) || ~isnumeric(state_IN)
     
    throw(ClassCastException('Logical or numeric required as input'));

end
% initialize output
% -----------------
obj_OUT=obj_IN;
% set value
% ---------
obj_OUT.footer_enable=all(state_IN);