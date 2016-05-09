function bool_OUT=isContentEmpty(obj_IN)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: isContentEmpty.m
% PATH    : ..\test\@cGenericData
%==========================================================================
% ABSTRACT: return true if no object contained in the collection
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Michel OLPHE-GALLIARD   AROB@S      10/06/2014  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN      : cGenericData object
%==========================================================================
% OUTPUT: 
%   bool_OUT     : bollean return true if empty, false otherwise
%==========================================================================
%
%==========================================================================
bool_OUT=isempty(obj_IN.element) ||...
    (length(obj_IN.element)==1 && isempty(obj_IN.element.name));