classdef cInfos
    %======================================================================
    %% VOLVO GTT 2013
    %======================================================================
    % MATLAB CLASS
    %======================================================================
    % FILENAME: cInfos.m
    % PATH    : ..\common\@cInfos
    %======================================================================
    % ABSTRACT: cInfos constructor
    %======================================================================
    % REVISION HISTORY:
    %   AUTHOR                  COMPANY     DATE        COMMENT
    %	Marc BALME              AROB@S      04/04/2011  Creation
    %	Mathieu CABANES         AROB@S      03/01/2013  Migration to MATLAB
    %                                                   2011b
    %	Mathieu CABANES         AROB@S      27/02/2014  Change
    %                                                   getenv("fullname")
    %                                                   for
    %                                                   getenv("username")
    %                                                   which give the
    %                                                   login name instead
    %                                                   of the name due to
    %                                                   a change in
    %                                                   environment
    %                                                   variables
    %
    %   <NAME>                  <COMPANY>   <DATE>      <COMMENT>
    %======================================================================
    % ALGORITHM:
    %======================================================================
    % INPUT:
    %   varargin    : pair of attribute & attribute value
    %======================================================================
    % OUTPUT:
    %   obj_OUT     : cInfos object
    %======================================================================
    
    % Protected attributes
    % --------------------
    properties (Access = protected)
                
        name          = '';             % name
        author        = '';             % author
        comment       = '';             % comment
        version       = 1.0;            % version
        label         = cLabel;         % labels
        modification  = '';             % modification date
        modified      = false;          % modified status
        creation      = '';             % creation date

    end
    
    % Dependent attributes
    % --------------------
    properties (Dependent, Access = protected)
        
        available_languages;            % list of avaialable languages
        displayedName;                  % displayed name
        
    end
    
    % Methods
    % -------
    methods
        
        function obj_OUT = cInfos(varargin)
            %==============================================================
            %% DESCRIPTION: Overloaded constructor method
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   varargin    : pair of attribute & attribute value
            %==============================================================
            % OUTPUT:
            %   obj_OUT     : cInfos object
            %==============================================================
            % initialisation of creation and modification date
            % ------------------------------------------------
            obj_OUT.creation = datestr(now);
            obj_OUT.modification = obj_OUT.creation;
            
            % Define current author name in any case
            % --------------------------------------
            % Get the name from the environment variables
            tmp_author_name = getenv('username');
                        
            % Define default value if no name
            if isempty(tmp_author_name); tmp_author_name = ''; end;
            
            % Update name
            obj_OUT.author = tmp_author_name;
            
            % boolean used to know the necessity of label initialization
            % ----------------------------------------------------------
            isLabelDefined=false;
                        
            % Manage several argument
            % -----------------------
            if nargin>=2
                
                % Manage input parameters
                for var_i=1:2:length(varargin)
                    
                    if isprop(obj_OUT, varargin{var_i}) && ...
                            strcmp(varargin{var_i}, 'label')

                        obj_OUT = obj_OUT.setLabel(varargin{var_i+1});
                        isLabelDefined=true;
                        
                    elseif isprop(obj_OUT, varargin{var_i}) && ...
                            ~strcmp(varargin{var_i}, 'displayedName')
                        
                        obj_OUT.(varargin{var_i}) = varargin{var_i+1};
                        
                    end
                    
                end
                
            end
            
            % initialize label
            % ----------------
            if ~isLabelDefined
                languagesList=obj_OUT.available_languages;
                if ~isempty(languagesList)
                    label_struct=struct();
                    for i=1:length(languagesList)
                        label_struct.(languagesList{i})='';
                    end
                    
                    obj_OUT=obj_OUT.setLabel(label_struct);
                end
                
            end
        end
        %==================================================================
        
        function displayed_name_OUT = get.displayedName(obj_IN)
            %==============================================================
            %% DESCRIPTION: Define dependent displayName property
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN              : cInfos object
            %==============================================================
            % OUTPUT:
            %   displayed_name_OUT	: displayName property of cInfos object
            %==============================================================
            
            % Define display name according to the name
            % -----------------------------------------
            displayed_name_OUT = obj_IN.name;

        end
        %==================================================================
        
        function languages_OUT = get.available_languages(obj_IN) %#ok<MANU>
            %==============================================================
            %% DESCRIPTION: Define dependent available languages
            %==============================================================
            % ALGORITHM:
            %==============================================================
            % INPUT:
            %   obj_IN          : cInfos object
            %==============================================================
            % OUTPUT:
            %   languages_OUT	: List of available languages
            %==============================================================
            
            % Initialize output variable
            % --------------------------
            languages_OUT = {'en'};
            
            % Update automatically the available languages
            % --------------------------------------------
            if isappdata(0, 'AvailableLanguages')
                
                languages_OUT = getappdata(0, 'AvailableLanguages'); 
            
            elseif isappdata(0, 'MainData') && ...
                    isfield(getappdata(0, 'MainData'), 'SOFT_LANGUAGES')
                
                main_data     = getappdata(0, 'MainData');
                languages_OUT = main_data.SOFT_LANGUAGES;
                
            end

        end
        %==================================================================

    end
    
end
%==========================================================================
