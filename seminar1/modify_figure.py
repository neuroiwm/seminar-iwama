# refactored using ChatGPT
import numpy as np
import matplotlib.pyplot as plt

class ModifyFigure:
    def __init__(self):
        self.config_plot = {}
        self.set_config_default()

    def set_config_default(self):
        self.config_plot['FontWeight'] = 'normal'
        self.config_plot['FontSize'] = 36
        self.config_plot['LineWidth'] = 1
        self.config_plot['LineWidth_plot'] = 1.5
        self.config_plot['LineStyle'] = '-'
        self.config_plot['Color'] = 'k'
        self.config_plot['label'] = ['Time [s]', 'Amplitude [µV]']
        self.config_plot['position_figure'] = None
        self.config_plot['font_default'] = 'Arial'
        self.config_plot['is_box'] = 1

    def set_config(self, *args):
        assert len(args) >= 2, 'Input the pair of variable name and variable. e.g., ''position_figure'',[1, 1, 100, 100]'
        for i_var in range(0, len(args), 2):
            self.config_plot[args[2 * i_var]] = args[2 * i_var + 1]

    def set_font(self):
        plt.rc('font', family=self.config_plot['font_default'])

    def get_list_config(self):
        for key, value in self.config_plot.items():
            if isinstance(value, str):
                print(f"{key}: {value}")
            elif isinstance(value, (int, float)):
                print(f"{key}: {value:.2f}")
            else:
                print(f"{key}: {value[0]}")
                print(f"{key}: {value[1]}")

    def figure(self):
        fig = plt.figure(figsize=self.config_plot['position_figure'])
        #fig.patch.set_facecolor([1, 1, 1])
        return fig

    def plot(self, time, data_plot):
        if time is None:
            time = range(data_plot.shape[0])
        plt.plot(time, data_plot, color=self.config_plot['Color'], linewidth=self.config_plot['LineWidth_plot'],
                 linestyle=self.config_plot['LineStyle'])

    def main(self):
        plt.gca().spines['top'].set_visible(False)
        plt.gca().spines['right'].set_visible(False)
        plt.gca().spines['left'].set_linewidth(self.config_plot['LineWidth'])
        plt.gca().spines['bottom'].set_linewidth(self.config_plot['LineWidth'])
        #plt.gca().tick_params(width=self.config_plot['LineWidth'])
        self.set_box()
        plt.gca().set_facecolor([1, 1, 1])
        plt.gca().set_ylabel(self.config_plot['label'][1], fontsize=self.config_plot['FontSize'])
        plt.gca().set_xlabel(self.config_plot['label'][0], fontsize=self.config_plot['FontSize'])
        plt.gca().tick_params(labelsize=self.config_plot['FontSize'])

    def set_box(self):
        if self.config_plot['is_box']:
            plt.box(True)
        else:
            plt.box(False)

    @staticmethod
    def get_time(signal, Fs):
        return np.arange(1, signal.shape[0] + 1) / Fs

if __name__ == '__main__':
    Fs = 1000
    signal = np.random.random((5000,1))
    modify_figure = ModifyFigure()
    modify_figure.set_font()
    f = modify_figure.figure()
    plt.pause(0.1)
    time = modify_figure.get_time(signal=signal,Fs=Fs)
    modify_figure.plot(time=time,data_plot=signal)
    modify_figure.main()
    plt.show()