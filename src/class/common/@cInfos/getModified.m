function value_OUT = getModified(obj_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getAuthor.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Get author
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         AROB@S      19/12/2012  Creation
%	Mathieu CABANES         AROB@S      04/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN  	: cInfos object
%==========================================================================
% OUTPUT:
%   value_OUT	: boolean status
%==========================================================================
value_OUT = [obj_IN.modified];
%==========================================================================