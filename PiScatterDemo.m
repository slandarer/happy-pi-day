%% PiScatterDemo : π on a grid — 400 digits
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
Pi = [3, getPi(399)];
CM = [248,65,69; 246,152,36; 249,198,81; 67,170,139; 87,118,146] ./ 255;

hold on
t = linspace(0, 2*pi, 100);
x = cos(t) * 0.8 * 0.5;
y = sin(t) * 0.8 * 0.5;

for i = 1:400
    [col, row] = ind2sub([20, 20], i);
    if mod(Pi(i), 2) == 0
        % Even digit: filled circle with the corresponding color (偶数：填充对应颜色)
        fill(x + col, y + row, CM(round((Pi(i)+1)/2), :), ...
             'LineWidth', 1, 'EdgeAlpha', 0.8)
    else
        % Odd digit: black circle with colored edge (奇数：黑色圆，边缘用对应颜色)
        fill(x + col, y + row, [0,0,0], ...
             'EdgeColor', CM(round((Pi(i)+1)/2), :), ...
             'LineWidth', 1, 'EdgeAlpha', 0.7)
    end
end

text(10.5, -0.4, '\pi on a grid — 400 digits', ...
     'Color', [1,1,1], 'FontName', 'Cambria', ...
     'HorizontalAlignment', 'center', 'FontSize', 25, 'FontAngle', 'italic')

% Figure and axes decoration (图窗和坐标区域修饰)
set(gcf, 'Position', [200, 100, 820, 820]);
ax = gca;
ax.YDir = 'reverse';          
ax.XLim = [0.5, 20.5];
ax.YLim = [-1, 20.5];
ax.XTick = [];
ax.YTick = [];
ax.Color = [0, 0, 0];        
ax.DataAspectRatio = [1, 1, 1];