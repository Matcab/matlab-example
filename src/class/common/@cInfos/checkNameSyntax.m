function value_OUT = checkNameSyntax(obj_IN,varargin)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% MATLAB CLASS
%==========================================================================
% FILENAME: checkNameSyntax.m
% PATH    : ..\common\@cInfos
%==========================================================================
% ABSTRACT: Get creation date
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Michel OLPHE-GALLIARD   AROB@S      04/01/2013  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   obj_IN   	: cInfos object
%==========================================================================
% OUTPUT:
%   value_OUT	: boolean
%==========================================================================
if nargin>1 && ischar(varargin{1})
    name_IN=varargin{1};
else
    name_IN=obj_IN.name;
end
value_OUT = ~isempty(name_IN) && ~any(regexp(name_IN,'[^0-9a-zA-Z_]+','ONCE'));
%==========================================================================