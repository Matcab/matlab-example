function struct_OUT = cInfos_data(varargin)
%==========================================================================
%% VOLVO 3P 2011
%==========================================================================
% GST 2.0
%==========================================================================
% FILENAME: cInfos_data.m
% PATH    : include\@cInfos\private
%==========================================================================
% ABSTRACT: cInfos attribute structure
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Marc BALME              AROB@S      04/04/2011  Creation
%
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM:
%==========================================================================
% INPUT:
%   varargin    : command line argument of cInfos_data (see VARARGIN)       
%==========================================================================
% OUTPUT: 
%   struct_OUT 	: structure of cInfos attributes
%==========================================================================
% Define attributes structure
% ---------------------------
struct_OUT = struct(...
    'name',           '', ...
    'displayedName',  '', ...
    'creation',       datestr(now), ...
    'modification',   datestr(now), ...
    'author',         '', ...
    'version',        1.0, ...
    'modified',       false, ...
    'comment',        '');
%==========================================================================
