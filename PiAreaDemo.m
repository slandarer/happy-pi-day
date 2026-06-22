%% PiAreaDemo : Area Chart of Proportion — 500 digits
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

% Get first 500 digits of pi (获取π的前500位小数)
Pi = getPi(500);

% Compute cumulative proportion of each digit (计算每个数字的累积比例)
Ratio = cumsum(Pi == (0:9)', 2);
Ratio = Ratio ./ sum(Ratio);

% Color palette for digits 0-9 (数字0-9对应的配色)
CM = [231, 98, 84; 239, 138, 71; 247, 170, 88; 255, 208, 111; 255, 230, 183;
    170, 220, 224; 114, 188, 213; 82, 143, 173; 55, 103, 149;  30,  70, 110] ./ 255;

% Plot stacked area chart (绘制堆叠面积图)
hold on
areaHdl = area(Ratio');
for i = 1:10
    areaHdl(i).FaceColor = CM(i, :);
    areaHdl(i).FaceAlpha = 0.9;
end

% Figure and axes decoration (图窗和坐标区域修饰)
set(gcf, 'Position', [200, 100, 720, 420]);
ax = gca;
ax.YLim = [0, 1];
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.LineWidth = 0.8;
ax.FontName = 'Cambria';
ax.FontSize = 11;
ax.TickDir = 'out';
ax.XLabel.String = 'Decimals';
ax.YLabel.String = 'Proportion';
ax.XLabel.FontSize = 13;
ax.YLabel.FontSize = 13;
ax.Title.String = 'Area Chart of Proportion — 500 digits';
ax.Title.FontSize = 14;

% Add legend for digits 0-9 and decorate
lgdHdl = legend(num2cell('0123456789'));
lgdHdl.NumColumns = 5;
lgdHdl.FontSize = 11;
lgdHdl.Location = 'southeast';