function value_OUT = getListID(obj_IN, name_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getListID.m
% PATH    : ..\class\common\@cIdentifiable
%==========================================================================
% ABSTRACT: Get a list of ids
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      25/08/2011  Creation
%	Mathieu CABANES         AROB@S      04/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN  	: cIdentifiable object (unused)
%   name_IN     : type name
%==========================================================================
% OUTPUT:
%   value_OUT 	:  list of IDs used by this type
%==========================================================================
% Initialize output
% -----------------
[~, value_OUT] = obj_IN.manageID('get', name_IN);
%==========================================================================
