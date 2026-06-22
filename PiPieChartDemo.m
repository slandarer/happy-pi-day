%% PiPieChartDemo : Frequency of digits in π —— 1500 digits (VISUALIZING π 'Pi' Chart)
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

% Get first 1500 decimal digits of pi (获取π的前1500位小数)
Pi = getPi(1500);

% Count occurrences of each digit 0-9 (统计各个数字出现次数)
numNum = find([diff(sort(Pi)), 1]);
numNum = [numNum(1), diff(numNum)];

% Color palette for digits 0-9 (数字0-9配色)
CM = [20, 164, 199;  43, 187, 170;  53, 165,  81; 189, 190,  28; 248, 167,  22;
      232, 74,  27; 244,  57,  99; 240, 118, 177; 168, 109, 195;  78, 125, 187] ./ 255;

% Draw pie chart (绘制饼图)
pieHdl = pie(numNum);
set(gcf, 'Color', [1,1,1], 'Position', [200, 100, 620, 620]);

% Apply colors to pie slices (为饼图扇区应用颜色)
for i = 1:2:20
    pieHdl(i).EdgeColor = [1,1,1];
    pieHdl(i).LineWidth = 1;
    pieHdl(i).FaceColor = CM((i+1)/2, :);
end
for i = 2:2:20
    pieHdl(i).Color = CM(i/2, :);
    pieHdl(i).FontWeight = 'bold';
    pieHdl(i).FontSize = 14;
end

% Add legend for digits 0-9 (添加数字图例)
lgdHdl = legend(num2cell('0123456789'));
lgdHdl.FontWeight = 'bold';
lgdHdl.FontSize = 11;
lgdHdl.TextColor = [0.5, 0.5, 0.5];
lgdHdl.Location = 'southoutside';
lgdHdl.Box = 'off';
lgdHdl.NumColumns = 10;
lgdHdl.ItemTokenSize = [20, 15];

title("VISUALIZING  \pi 'Pi' Chart | 1500 digits", 'FontSize', 18, ...
      'FontName', 'Times New Roman', 'Color', [0.5, 0.5, 0.5]);
