classdef ModifyFigure < handle
    properties
        config_plot = struct;
    end

    methods (Access = public)
        function self = ModifyFigure
            self.set_config_default;
        end

        function self = set_config_default(self)
            self.config_plot.FontWeight = 'normal';
            self.config_plot.FontSize = 10;
            self.config_plot.LineWidth = 1;
            self.config_plot.LineWidth_plot = 1.5;
            self.config_plot.LineStyle = '-';
            self.config_plot.Color = 'k';
            self.config_plot.label = {'Time [s]';'Amplitude [µV]'};
            self.config_plot.position_figure = [1, 1, 814, 380];
            self.config_plot.font_default = 'Arial';
            self.config_plot.is_box = 0;
        end

        function self = set_config(self,varargin)
            assert(numel(varargin)>=2,['Input the pair of variable name and variable. ' ...
                'e.g., ''position_figure'',[1, 1, 100, 100]'])
            for i_var = 1 : 2 : numel(varargin)
                self.config_plot.(varargin{2*(i_var-1)+1}) = varargin{2*i_var};
            end
        end

        function set_font(self)            
            set(groot,'defaultAxesFontName', self.config_plot.font_default);
            set(groot,'defaultTextFontName', self.config_plot.font_default);
            set(groot,'defaultLegendFontName', self.config_plot.font_default);
            set(groot,'defaultColorbarFontName', self.config_plot.font_default);
        end

        function get_list_config(self)
            list_config = fieldnames(self.config_plot);            
            for i_name = 1 : numel(list_config)
                try
                    if ischar(self.config_plot.(list_config{i_name}))
                        fprintf('%s: %s\n',list_config{i_name},self.config_plot.(list_config{i_name}));
                    else
                        fprintf('%s: %0.2f\n',list_config{i_name},self.config_plot.(list_config{i_name}));
                    end
                catch
                    fprintf('%s: %s\n',list_config{i_name},self.config_plot.(list_config{i_name}){1});
                    fprintf('%s: %s\n',list_config{i_name},self.config_plot.(list_config{i_name}){2});
                end
            end
        end
    end

    methods (Access = public)
        function out_figure = figure(self)
            out_figure = figure;
            set(out_figure,'color',[1 1 1]);
        end

        function out_line = plot(self,time,data_plot)
            if nargin < 2
                time = 1 : size(data_plot,1);
            end
              
            plot(time,data_plot,'Color',self.config_plot.Color, ...
                'LineStyle',self.config_plot.LineStyle, ...
                'LineWidth',self.config_plot.LineWidth_plot);
        end

        function main(self)
            set(gcf,'color',[1 1 1])
            set(gca,'LineWidth',self.config_plot.LineWidth);
            self.set_box;
            set(gca,'FontWeight',self.config_plot.FontWeight);

            FontSize = ceil(self.config_plot.FontSize*35/19);            
            set(gca,'FontSize',FontSize);

            xlabel(self.config_plot.label{1});
            ylabel(self.config_plot.label{2});
        end

        function set_box(self)
            if self.config_plot.is_box
                box('on')
            else
                box('off');
            end
        end
    end

    methods (Static)
        function time = get_time(signal,Fs)
            time = 1/Fs:1/Fs:size(signal,1)/Fs;
        end
    end
end