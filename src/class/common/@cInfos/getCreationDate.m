function value_OUT = getCreationDate(obj_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getCreationDate.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Get creation date
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      22/07/2011  Creation
%	Mathieu CABANES         AROB@S      04/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN   	: cInfos object
%==========================================================================
% OUTPUT:
%   value_OUT	: creation date
%==========================================================================
value_OUT = obj_IN.creation;
%==========================================================================
