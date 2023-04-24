classdef SaveFigure < handle
    properties
        config_save = struct;
    end

    methods (Access = public)
        function self = SaveFigure
            self.set_config_default;
        end

        function self = set_config_default(self)
            self.config_save.list_format = {'fig';'pdf';'tiffn';'jpg'};
            self.config_save.format_save = [1,2,4];
        end
        

        function save_current_figure(self,name_figure)
            if nargin < 2
                name_figure = 'figure';
            end
            str_now = datestr(now,'yyyymmdd_HHMMSS');
            name_figure = sprintf('%s_%s',name_figure,str_now);

            [list_format, num_format] = self.get_format();
            for i_format = 1 : num_format
                name_format = list_format{i_format};
                saveas(gcf,name_figure,name_format);
            end

            path_figure = fullfile(cd,str_now);
            self.move_figure(str_now,path_figure)            
        end

        function save_all_figure(self,name_figure)
            if nargin < 2
                name_figure = 'figure';
            end
            num_fig = get(gcf,'Number');
            for i_fig = 1 : num_fig
                figure(i_fig)
                self.save_current_figure(name_figure);
            end
        end

        function move_figure(self,name_figure,path_figure)            
            self.mkdir_chk(path_figure);
            movefile(sprintf('*%s*',name_figure),path_figure);
        end        
    end

    methods (Access = private)
        function [list_format, num_format] = get_format(self)
            num_format = numel(self.config_save.format_save);
            list_format = self.config_save.list_format(self.config_save.format_save);
        end
    end

    methods (Static)
        function mkdir_chk(path_base)
            if ~exist(path_base,'dir')
                mkdir(path_base)
            end
        end
    end
end