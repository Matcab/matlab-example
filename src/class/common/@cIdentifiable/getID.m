function value_OUT = getID(obj_IN)
%==========================================================================
%% VOLVO GTT 2013
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: getID.m
% PATH    : ..\class\common\@cIdentifiable
%==========================================================================
% ABSTRACT: Get id
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      27/07/2011  Creation
%	Mathieu CABANES         AROB@S      04/01/2013  Migration to MATLAB
%                                                   2011b
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN  	: cIdentifiable object
%==========================================================================
% OUTPUT:
%   value_OUT 	: id
%==========================================================================
value_OUT = [obj_IN.ID];
%==========================================================================
