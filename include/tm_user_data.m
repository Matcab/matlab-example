function [struct_OUT] = tm_user_data(varargin)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% MATLAB TEMPLATE
%==========================================================================
% FILENAME: tm_user_data.m
% PATH    : $TEMPLATE_HOME$\include
%==========================================================================
% ABSTRACT: Define default structure for user defined data (saved in
% configuration file and used in UserData structure)
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%	Mathieu CABANES         Arob@s      31/05/2010  Creation
% 
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% ALGORITHM: 
%==========================================================================
% INPUT:
%   varargin    : command line arguments to gst_user_data (see VARARGIN)
%==========================================================================
% OUTPUT:
%   struct_OUT  : configuration file structure
%==========================================================================

% Define default structure
% ------------------------
struct_OUT = struct( ...
    'LANGUAGE',         'en', ...
    'SCREEN_SIZE',     	'1280x800', ...
    'SKIN',             'default', ...
    'MODE',             'standard', ...
    'WORK_DIR',         '');
%==========================================================================
