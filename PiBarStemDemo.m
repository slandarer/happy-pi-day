%% PiBarStemDemo : Frequency and Position of π Digits —— 100 digits
% Zhaoxu Liu / slandarer (2026). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2026/3/14. 

% Create figure and two sub-axes (创建图窗和两个子坐标轴)
fig = figure('Units', 'normalized', 'Position', [.1, .3, .8, .5]);

% Upper axes: bar chart of digit frequencies (上方坐标轴：数字频率条形图)
ax1 = axes('Parent', fig, 'Position', [.05, .55, .9, .4], ...
    'TickLength', [0, 0], 'LineWidth', 2, 'Box', 'on', ...
    'XLim', [-.5, 9.5], 'NextPlot', 'add', ...
    'FontName', 'Times New Roman', 'FontSize', 14);

% Lower axes: stem plot of digit positions (下方坐标轴：数字位置散点图)
ax2 = axes('Parent', fig, 'Position', [.05, .05, .9, .4], ...
    'TickLength', [0, 0], 'LineWidth', 2, 'Box', 'on', ...
    'XTick', [], 'YTick', [], 'XLim', [.5, 100.5], 'NextPlot', 'add');

Pi = getPi(100);

% Count occurrences of each digit (统计各个数字出现次数)
numNum = find([diff(sort(Pi)), 1]);
numNum = [numNum(1), diff(numNum)];

% Color palette for digits 0-9 (数字0-9对应的配色)
CM = [ 20, 164, 199;  43, 187, 170;  53, 165,  81; 189, 190,  28; 248, 167,  22;
      232,  74,  27; 244,  57,  99; 240, 118, 177; 168, 109, 195;  78, 125, 187] ./ 255;

% Draw bar chart on ax1 (在ax1上绘制条形图)
bar(ax1, 0:9, numNum, 'LineWidth', 2, 'CData', CM, 'FaceColor', 'flat');

% Draw stem plots on ax2: each digit's position in the sequence (在ax2上绘制散点图：每个数字在序列中的位置)
for i = 1:10
    stem(ax2, find(Pi == (i - 1)), Pi(Pi == (i - 1)), ...
         'filled', 'LineWidth', 2, 'Color', CM(i, :));
end