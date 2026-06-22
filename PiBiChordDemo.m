%% PiBiChordDemo : Bidirectional Chord Diagram of Adjacent Digit Transitions in π —— 1000 digits 
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

% Zhaoxu Liu / slandarer (2026). biChordChart (bidirectional chord diagram | 有向弦图) 
% (https://www.mathworks.com/matlabcentral/fileexchange/121043-bichordchart-bidirectional-chord-diagram), 
% MATLAB Central File Exchange. Retrieved April 14, 2026.

% Build adjacency matrix of digit transitions (构建相邻数字转移的连接矩阵)
dataMat = zeros(10, 10);
Pi = getPi(1001);

% Count transitions from digit i to digit i+1 (统计从数字i到数字i+1的转移次数)
for i = 1:1000
    dataMat(Pi(i) + 1, Pi(i + 1) + 1) = dataMat(Pi(i) + 1, Pi(i + 1) + 1) + 1;
end

% Create and draw a biChordChart with arrows and labels (创建并绘制带箭头和标签的弦图)
BCC = utils.biChordChart(dataMat, 'Arrow', 'on', 'Label', num2cell('0123456789'));
BCC = BCC.draw();

BCC.tickState('on');
BCC.setFont('FontName', 'Cambria', 'FontSize', 17);

% Figure decoration (图窗修饰)
set(gcf, 'Position', [200, 100, 820, 820]);
