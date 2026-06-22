%% PiBubbleGraphDemo : Bubble Graph of Digit Transitions in π —— 1000 digits
% Zhaoxu Liu / slandarer (2026). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2026/3/14.

figure('Units', 'normalized', 'Position', [.1, .05, .7, .85])

% Build adjacency matrix of digit transitions (构建相邻数字转移的邻接矩阵)
dataMat = zeros(10, 10);
Pi = getPi(1001);
for i = 1:1000
    dataMat(Pi(i) + 1, Pi(i+1) + 1) = dataMat(Pi(i) + 1, Pi(i+1) + 1) + 1;
end

% Prepare node labels (准备节点标签)
%   Node 1: π (root)
%   Nodes 2-11: digits 0-9
%   Nodes 12-111: transfer nodes "i-j" representing transition from digit i to j
str1 = compose("%d", 0:9).';
str2 = compose("%d-%d", (0:9).', (0:9)).';
str = ["π"; str1(:); str2(:)];

% Build adjacency matrix for the graph (构建图邻接矩阵)
DMat = zeros(111);
% Edges from root π to each digit, weight = overall frequency of the digit
DMat(1, 2:11) = sum(dataMat, 2) ./ sum(sum(dataMat));
% Edges from digit i to transfer node i-j, weight = conditional probability P(j|i)
for i = 1:10
    dataMat(i, :) = dataMat(i, :) ./ sum(dataMat(i, :));
    DMat(i+1, (2:11) + i*10) = dataMat(i, :);
end

% Create graph with upper triangular adjacency (创建图对象)
G = graph(DMat, 'upper');
G.Nodes = str;

% Plot the graph using force-directed layout (绘制力导向布局图)
pHdl = plot(G, 'Layout', 'force', 'WeightEffect', 'direct', 'Iterations', 1000);
ax = gca;
ax.NextPlot = 'add';
ax.DataAspectRatio = [1, 1, 1];
ax.XLim = ax.XLim;
ax.YLim = ax.YLim;

% Color palette for digits 0-9 (数字0-9配色)
CM = [231,  98,  84; 239, 138,  71; 247, 170,  88; 255, 208, 111; 255, 230, 183;
      170, 220, 224; 114, 188, 213;  82, 143, 173;  55, 103, 149;  30,  70, 110] ./ 255;

% Draw bubble charts for transition probabilities (绘制转移概率的气泡图)
for i = 1:10
    bubblechart(pHdl.XData((11+i):10:end), pHdl.YData((11+i):10:end), ...
                dataMat(:, i).', CM(i, :), 'MarkerFaceAlpha', 0.5);
    bhdl(i) = fill([100, 100, 101], [101, 101, 100], CM(i, :), ...
                   'FaceAlpha', 0.4, 'EdgeColor', CM(i, :));
end
uistack(pHdl, 'top')

% Add text labels for digit nodes (添加数字节点文本)
for i = 1:10
    text(pHdl.XData(i+1), pHdl.YData(i+1), num2str(i-1), ...
         'FontName', 'Times New Roman', 'FontSize', 20, ...
         'HorizontalAlignment', 'center', 'LineWidth', 1)
end
% Add label for root π node (添加根节点π文本)
text(pHdl.XData(1), pHdl.YData(1), 'π', ...
     'FontName', 'Times New Roman', 'FontSize', 100, ...
     'HorizontalAlignment', 'center', 'LineWidth', 1)

% Add bubble legend for transition sizes (添加气泡大小图例)
bubblelegend('Location', 'northeast')
% Add color legend for digits (添加数字颜色图例)
legend(bhdl, compose("%d", 0:9), 'FontName', 'Times New Roman', 'FontSize', 14, ...
       'NumColumns', 2, 'AutoUpdate', 'off', 'Location', 'northeast')


