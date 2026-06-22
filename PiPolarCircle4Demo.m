%% PiPolarCircle4Demo : Spiral of 4-digit proportion circles in π —— 1200 digits
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

% Archimedean spiral parameters (阿基米德螺旋参数)
a = 1;          % Initial radius (初始半径)
b = 0.227;      % Growth rate per radian (每弧度增长率)

Pi = [3, getPi(1199)];

% Color palette for digits 0-9 (数字0-9配色)
CM = [239, 32,120; 239, 60, 52; 247, 98, 32; 255,182, 60; 247,235, 44;
      142,199, 57;  55,180, 70;   0,170,239;  40, 56,146; 147, 37,139] ./ 255;

% Draw spiral circles (绘制螺旋圆)
hold on
T = 0; R = 1;         
t = linspace(0, 2*pi, 100);
x = cos(t) * 0.7;
y = sin(t) * 0.7;

for i = 1:4:length(Pi)
    X = R * cos(T); Y = R * sin(T); 
    
    % Extract the 4-digit segment (提取四位数字段)
    tNum = Pi(i:i+3);
    % Count occurrences of each digit (统计各数字出现次数)
    numNum = find([diff(sort(tNum)), 1]);
    numNum = [numNum(1), diff(numNum)];
    cumNum = cumsum(numNum);
    uniNum = unique(tNum);
    
    % Draw concentric rings from outer to inner (从外到内绘制同心环)
    for j = length(cumNum):-1:1
        fill(x ./ 4 .* cumNum(j) + X, ...
             y ./ 4 .* cumNum(j) + Y, ...
             CM(uniNum(j)+1, :), 'EdgeColor', 'none')
    end
    
    % Update spiral angle and radius (更新螺旋角度和半径)
    T = T + 1.0 / R * 1.4;
    R = a + b * T;
end

text(14, 16.5, {'The ratio of four numbers from \pi'; '—— 1200 digits'}, ...
     'Color', [1,1,1], 'FontName', 'Cambria', 'FontSize', 23, ...
     'FontAngle', 'italic', 'HorizontalAlignment', 'right')

% Figure and axes decoration (图窗和坐标区域修饰)
set(gcf, 'Position', [200, 100, 820, 820]);
ax = gca;
ax.XLim = [-15, 15.5];
ax.YLim = [-15, 19];
ax.XTick = [];
ax.YTick = [];
ax.Color = [0, 0, 0];
ax.DataAspectRatio = [1, 1, 1];