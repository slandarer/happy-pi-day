%% PiPlotDemo : Cumulative proportion of each digit in π —— 1500 digits
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

% Get first 1500 decimal digits of pi (获取π的前1500位小数)
Pi = getPi(1500);

% Compute cumulative proportion of each digit 0-9 (计算每个数字0-9的累积比例)
Ratio = cumsum(Pi == (0:9)', 2);
Ratio = Ratio ./ sum(Ratio);

D = 1:length(Ratio);

% Color palette for digits 0-9 (数字0-9配色)
CM = [ 20,164,199;  43,187,170;  53,165, 81; 189,190, 28; 248,167, 22;
      232, 74, 27; 244, 57, 99; 240,118,177; 168,109,195;  78,125,187] ./ 255;

hold on
% Plot cumulative proportion curves for each digit (绘制每个数字的累积比例曲线)
for i = 1:10
    plot(D(20:end), Ratio(i, 20:end), 'Color', [CM(i,:), 0.6], 'LineWidth', 1.8)
end

% Axes decoration (坐标区域修饰)
ax = gca;
box on; grid on
ax.YLim = [0, 0.2];
ax.YTick = 0:0.05:0.2;
ax.XTick = 0:200:1400;
ax.YTickLabel = {'0%','5%','10%','15%','20%'};
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.LineWidth = 0.8;
ax.GridLineStyle = '-.';
ax.FontName = 'Cambria';
ax.FontSize = 11;
ax.XLabel.String = 'Decimals';
ax.YLabel.String = 'Proportion';
ax.XLabel.FontSize = 13;
ax.YLabel.FontSize = 13;

% Add legend for digits 0-9 and decorate (添加图例并修饰)
lgdHdl = legend(num2cell('0123456789'));
lgdHdl.NumColumns = 5;
lgdHdl.FontWeight = 'bold';
lgdHdl.FontSize = 11;
lgdHdl.TextColor = [0.5, 0.5, 0.5];








