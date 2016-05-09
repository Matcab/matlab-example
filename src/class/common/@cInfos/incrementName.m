function name_OUT = incrementName(~,name_IN)
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
% Manage input
% ------------
if ~ischar(name_IN); throw(...
        ClassCastException('Illegal input type, string recquired as input')); end;

name_components=regexp(name_IN,'_','split');
latest_char_value=str2double(name_components{end});
if isnan(latest_char_value)
    name_OUT=[name_IN '_1'];
else
    name_OUT=[name_IN(1:end-length(name_components{end})),...
        num2str(latest_char_value+1)];
end
%==========================================================================