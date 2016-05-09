function value_OUT = getDisplayedName(obj_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getDisplayedName.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Get name
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu GUERIN          AROB@S      02/03/2012  Creation
%	Mathieu CABANES         AROB@S      04/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN    	: cInfos object
%==========================================================================
% OUTPUT:
%   value_OUT  	: displayed name
%==========================================================================
value_OUT = obj_IN.displayedName;
%==========================================================================