function [struct_OUT] = upgrade(struct_IN, ref_IN, varargin)
%==========================================================================
%% VOLVO GTT 2014
%==========================================================================
% MATLAB TEMPLATE
%==========================================================================
% FILENAME: upgrade
% PATH:     $TEMPLATE_HOME$\lib
%==========================================================================
% ABSTRACT: Upgrade data structure
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE       	COMMENT
%	Olivier DUFOUR          Arob@s    	22/02/2008  Creation
%	Olivier DUFOUR          Arob@s    	05/05/2010  Update for version 1.1
%   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
%==========================================================================
% INPUT:
%   struct_IN   : Data structure to check
%   ref_IN      : Reference structure with default values
%   varargin    : command line arguments to passi_user_data (see VARARGIN)
%==========================================================================
% OUTPUT:
%   struct_OUT  : configuration file structure
%==========================================================================

% Check if input reference is a structure, if not return input structure
% ----------------------------------------------------------------------
if ~isstruct(ref_IN)
    
    % Define output as input
    struct_OUT = struct_IN;
    
    % Abord treatment
    return;
    
end

% Check if input data is a structure, if not return reference
% -----------------------------------------------------------
if ~isstruct(struct_IN)
    
    % Define output as input
    struct_OUT = ref_IN;
    
    % Abord treatment
    return;
    
end

% Upgrade input structure according to reference structure
% --------------------------------------------------------
for i_line = 1:max(size(ref_IN,1),size(struct_IN,1))

    for j_column = 1:max(size(ref_IN,2),size(struct_IN,2))

        % Define working structures
        reference = ref_IN(min(i_line,size(ref_IN,1)), ...
            min(j_column,size(ref_IN,2)));
        data      = struct_IN(min(i_line,size(struct_IN,1)), ...
            min(j_column,size(struct_IN,2)));
        
        % List structure fields
        tmp        = fieldnames(reference);
        all_fields = [fieldnames(data); ...
            tmp(~ismember(tmp,fieldnames(data)))];

        for i_field = 1:length(all_fields)

            % Check if field is defined in reference structure
            if ~isfield(reference, all_fields{i_field})
                
                % Assign output value
                data_out.(all_fields{i_field}) = data.(all_fields{i_field});               
                
                
                % Check if field is defined in data structure
            elseif ~isfield(data, all_fields{i_field})
                
                % Assign output value
                data_out.(all_fields{i_field}) = ...
                    reference.(all_fields{i_field});
                
            else
                
                % Recursive call to this function
                data_out.(all_fields{i_field}) = upgrade(...
                    data.(all_fields{i_field}), ...
                    reference.(all_fields{i_field}));
            end
            
        end
        
        % Assign output data
        struct_OUT(i_line,j_column) = data_out; %#ok<AGROW>
        
    end

end
%==========================================================================
