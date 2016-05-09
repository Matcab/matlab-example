function state_OUT = isFootNoteEnable(obj_IN)
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
% set value
% ---------
state_OUT=obj_IN.footer_enable;