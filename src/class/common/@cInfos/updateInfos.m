function obj_OUT = updateInfos(obj_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: updateInfos.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: update cInfos by modifying modification date
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      04/04/2011  Creation
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
%   obj_OUT  	: updated cInfos object
%==========================================================================

% Initialize output object
% ------------------------
obj_OUT = obj_IN;

% Update modification date
% ------------------------
obj_OUT.modification = datestr(now);
%==========================================================================
