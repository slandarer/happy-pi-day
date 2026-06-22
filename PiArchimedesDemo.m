%% PiArchimedesDemo : The Archimedes spiral of π —— 500 digits
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

% Define spiral parameters (定义螺旋参数)
a = 1;          % Initial radius (初始半径)
b = 0.227;      % Growth rate per radian (每弧度增长率)

Pi = getPi(500);

% Color palette for digits 0-9 (数字0-9对应的配色)
CM = [ 78, 121, 167; 242, 142,  43; 225,  87,  89; 118, 183, 178;  89, 161,  79;
      237, 201,  72; 176, 122, 161; 255, 157, 167; 156, 117,  95; 186, 176, 172] ./ 255;

% Draw circular blocks along the spiral (沿螺旋线绘制圆形色块)
hold on
T = 0;          % Initial angle (初始角度)
R = 1;          % Initial radius (初始半径)

% Small circle shape for each digit block (每个数字块的小圆形状)
t = linspace(0, 2*pi, 100);
x = cos(t) * 0.7;
y = sin(t) * 0.7;

for i = 1:500
    X = R * cos(T);
    Y = R * sin(T);
    
    % Draw filled circle with color corresponding to the digit (绘制对应数字颜色的填充圆)
    fill(X + x, Y + y, CM(Pi(i) + 1, :), 'EdgeColor', 'none', 'FaceAlpha', 0.9)
    
    T = T + 1.0 / R * 1.4;
    R = a + b * T;
end

text(17.25, 22, {'The Archimedes spiral of \pi'; '—— 500 digits'}, ...
    'Color', [1, 1, 1], 'FontName', 'Cambria', ...
    'HorizontalAlignment', 'right', 'FontSize', 25, 'FontAngle', 'italic')

% Figure and axes decoration (图窗和坐标区域修饰)
set(gcf, 'Position', [200, 100, 820, 820]);
ax = gca;
ax.XLim = [-19, 18.5];
ax.YLim = [-20, 25];
ax.XTick = [];
ax.YTick = [];
ax.Color = [0, 0, 0];              
ax.DataAspectRatio = [1, 1, 1];
