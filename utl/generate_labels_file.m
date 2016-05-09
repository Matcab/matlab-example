function generate_labels_file(varargin)
%==========================================================================
%% RENAULT TRUCKS 2006
%==========================================================================
% FILENAME: generate_labels_file
% PATH:     $SOFT\utl
%==========================================================================
% DESCRIPTION: Tool used to generate lable text file from GUI figure file
%==========================================================================
% REVISION HISTORY:
%   AUTHOR                  COMPANY     DATE        COMMENT
%   Olivier DUFOUR          AROB@S      15/05/2009  Management of several
%                                                   files and languages
%   Mathieu CABANES         AROB@S      22/02/2008  Update to be used by
%                                                   any developper
%   Laurent VAYLET          AROB@S      27/01/2006  Creation
%
%   <NAME>         <COMPANY>    <DATE>       <COMMENT>
%==========================================================================

%% Check on varagin
%  ----------------
if nargin == 0
    gui_path = [];
    gui_filename = [];
    lang = {'fr', 'en'};    
elseif nargin == 1    
    [gui_path, filename, ext] = fileparts(varargin{1});
    gui_filename = [filename, ext];
    lang = {'fr', 'en'};
elseif nargin == 2
    [gui_path, filename, ext] = fileparts(varargin{1});
    gui_filename = [filename, ext];
    lang = varargin{2};
else
    return
end

%% File selection
%  --------------
if (isempty(gui_filename))
    % Define starting dir
    if (exist(strrep(pwd, 'utl', 'src\gui'), 'dir'))
        starting_dir = strrep(pwd, 'utl', 'src\gui');
    elseif (exist(strrep(pwd, 'utl', 'src\ihm'), 'dir'))
        starting_dir = strrep(pwd, 'utl', 'src\ihm');
    else
        starting_dir = pwd;
    end

    [gui_filename gui_path] = uigetfile('*.fig', 'Select figure file', starting_dir);    
end

if (gui_path == 0)
    return
else
    gui_filename = cellstr(gui_filename);
end

% Loop on selected figure and languages
for i_gui = 1:length(gui_filename)

    % Loop on selected language
    for i_lang = 1:length(lang)

        % if the user stop the generation
        [gui_path,gui_name,gui_ext] = fileparts(fullfile(gui_path,gui_filename{i_gui}));

        %% File validity checking
        %  ----------------------
        if ~strcmpi(gui_ext,'.fig')

            uiwait(errordlg('Invalid GUI file (extension must be .fig)', 'Error'));
            break

        end

        %% File existing checking
        %  ----------------------
        if ~exist(fullfile(gui_path,[gui_name,gui_ext]), 'file')

            uiwait(errordlg('GUI file not exists', 'Error'));
            break

        end

        %% Output file name building
        %  -------------------------
        if strfind(gui_name,'_gui')

            if strcmpi(gui_name(end-3:end),'_gui')

                output_file = strrep(gui_name,'_gui','_label.txt');

            else

                output_file = strcat(gui_name,'_label.txt');

            end

        elseif strfind(gui_name,'_gui')

            if strcmpi(gui_name(end-3:end),'_gui')

                output_file = strrep(gui_name,'_gui','_label.txt');

            else

                output_file = strcat(gui_name,'_label.txt');

            end

        else

            output_file = strcat(gui_name,'_label.txt');

        end

        %% output directory definition
        %  ---------------------------
        % Create output dir variable
        output_dir = fullfile(regexprep(gui_path, 'src.+?$', 'data'), lang{i_lang});
        
        % Verify output dir existence
        if (~exist(output_dir, 'dir'))

            uiwait(errordlg('Invalid language choosen', 'Error'));
            break

        end

        %% Properties for each style of uicontrol definition
        %  -------------------------------------------------
        prop.Fg = {'Name','WindowStyle'};
        prop.St = {'String'};
        prop.Pb = {'String'};
        prop.Tb = {'String'};
        prop.Rb = {'String'};
        prop.Cb = {'String'};
        prop.Ed = {'TooltipString'};
        prop.Lb = {'TooltipString'};
        prop.Pu = {'TooltipString'};
        prop.Mb = {'Label'};
        prop.Pn = {'Title'};

        id_list = {'Fg','St','Pb','Tb','Rb','Cb','Ed','Lb','Pu','Mb', 'Pn'};

        %% Header definition according to the selected language
        %  ----------------------------------------------------
        if strcmpi(lang,'fr')

            header = sprintf([...
                '%% Fichier associe : (%s)\n' ...
                '%%-----------------------------------------------------------------------------------------\n' ...
                '%% Attention : Les blanc dans les chaines de caracteres sont remplaces par le caractere "-"\n' ...
                '%%             Pour obtenir le caractere "-" a l''affichage, ecrire la chaine de caracteres\n' ...
                '%%             "<moins>" dans ce fichier texte\n' ...
                '%% Lire avec la commande ci-dessous :\n' ...
                '%% textread(''<file>.txt'',''%%s%%s%%s'',''commentstyle'',''matlab'')\n' ...
                '%%-----------------------------------------------------------------------------------------\n' ...
                '%% Genere le : %s\n' ...
                '%%-----------------------------------------------------------------------------------------\n' ...
                '%% Tag                                   Property            Value\n' ...
                '%%-----------------------------------------------------------------------------------------\n'], ...
                output_file, datestr(now));

        else

            header = sprintf([ ...
                '%% Associated file : (%s)\n' ...
                '%%-----------------------------------------------------------------------------------------\n' ...
                '%% Warning : Space characters should be replaced by "-" in this file.\n' ...
                '%%           Write "<moins>" in order to display a "-" in the GUI\n' ...
                '%% Read this file with the following command line :\n' ...
                '%% textread(''<file>.txt'',''%%s%%s%%s'',''commentstyle'',''matlab'')\n' ...
                '%%-----------------------------------------------------------------------------------------\n' ...
                '%% Generated : %s\n' ...
                '%%-----------------------------------------------------------------------------------------\n' ...
                '%% Tag                                   Property            Value\n' ...
                '%%-----------------------------------------------------------------------------------------\n'], ...
                output_file, datestr(now));

        end

        %% Interface design loading
        fig_hdl = hgload(fullfile(gui_path, [gui_name, '.fig']));

        %% text uicontronl listing
        %  -----------------------
        list.Fg = get(fig_hdl, 'Tag');
        list.St = get(findobj(fig_hdl, 'Style', 'text'),        'Tag');
        list.Pb = get(findobj(fig_hdl, 'Style', 'pushbutton'),  'Tag');
        list.Tb = get(findobj(fig_hdl, 'Style', 'togglebutton'),'Tag');
        list.Rb = get(findobj(fig_hdl, 'Style', 'radiobutton'), 'Tag');
        list.Cb = get(findobj(fig_hdl, 'Style', 'checkbox'),    'Tag');
        list.Ed = get(findobj(fig_hdl, 'Style', 'edit'),        'Tag');        
        list.Lb = get(findobj(fig_hdl, 'Style', 'listbox'),     'Tag');        
        list.Pu = get(findobj(fig_hdl, 'Style', 'popupmenu'),   'Tag');
        list.Mb = get(findobj(fig_hdl, 'Type',  'uimenu'),      'Tag');
        list.Pn = get(findobj(fig_hdl, 'Type',  'uipanel'),     'Tag');

        %% interface closing
        %  -----------------
        delete(fig_hdl);
        
        % Compare data to existing file
        % -----------------------------
        % Verify output file existence
        if (exist(fullfile(output_dir,output_file), 'file'))
            
            % Open and read file
            fid = fopen(fullfile(output_dir,output_file), 'rt');
            if (fid == -1); break; end;
            
            % Read file
            car = fread(fid);
            
            % Close file
            fclose(fid);
            
            % Extract file data
            txt_data = strread(char(car'), '%s', 'delimiter', '\n');
            
            % Read file header
            comments = cellfun(@(x) char(regexp(x, '%.+', 'match')), txt_data, 'UniformOutput', false);
            header = char(comments(1:find(cellfun(@isempty, comments), 1, 'first')-1));
            
            % Remove comment lines from data
            txt_data(~cellfun(@isempty, comments)) = [];                                    
            
        else
            txt_data = [];
        end
        
        %% Outputfile writing
        %  ------------------
        str = [];
        
        for i_head = 1:size(header, 1)
            str = [str; {sprintf('%s',header(i_head, :))}];
        end

        for ind = 1:length(id_list)

            listTemp = list.(id_list{ind});
            propTemp = prop.(id_list{ind});

            if ~isempty(listTemp)

                listTemp = cellstr(listTemp);

                % Element deletion for empty Tag
                listTemp(find(cellfun('isempty', listTemp))) = [];

                for i_prop = 1:length(propTemp)

                    for i_tag = 1:length(listTemp)

                        % Define line string
                        line = sprintf('%-40s%-20s',listTemp{i_tag},propTemp{i_prop});
                        
                        if (any(strncmpi(txt_data, line, length(line))))
                            str = [str; txt_data(strncmpi(txt_data, line, length(line)))];
                        else
                            str = [str; {sprintf('%-40s%-20s',listTemp{i_tag},propTemp{i_prop})}];
                        end

                    end

                end

                % Add separator
                str = [str; {sprintf('%%----------------------------------------------------------------------------------------')}];

            end

        end
               
        % Write output file
        fid = fopen(fullfile(output_dir,output_file),'w');
        fprintf(fid,'%s\n',str{:});
        fclose(fid);
        
        % Inform user
        fprintf(1, 'Write label %s file for %s gui and %s language\n', ...
            fullfile(output_dir,output_file), gui_filename{i_gui}, lang{i_lang});

    end
end
%==========================================================================
