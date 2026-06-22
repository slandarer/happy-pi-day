%% PiTreeDemo : Forest of π trees —— 800 digits
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

Pi = [3, getPi(800)];

% Locate all positions of digit 9 (these serve as delimiters between trees)
% (找到所有数字9的位置，它们作为树之间的分隔符)
pos9 = [0, find(Pi == 9)];

set(gcf, 'Position', [200, 50, 900, 900], 'Color', [1, 1, 1]);
ax = gca; 
hold on
ax.Position = [0, 0, 1, 1];
ax.DataAspectRatio = [1, 1, 1];
ax.XLim = [0.5, 36];
ax.XTick = [];
ax.YTick = [];
ax.XColor = 'none'; 
ax.YColor = 'none';

for j = 1:8
    for i = 1:11
        n = i + (j - 1) * 11; 
        if n <= 85
            tPi = Pi((pos9(n) + 1) : pos9(n + 1) + 1);
            
            if length(tPi) > 2
                % Normal tree: use full branching (正常树：启用完整分支)
                utils.piTree(tPi, [0 + i * 3, 0 - j * 4], true);
            else
                % Short tree (≤2 digits): only trunk, no branching (短树：仅树干，无分支)
                utils.piTree([Pi(pos9(n)), tPi], [0 + i * 3, 0 - j * 4], false);
            end
        end
    end
end

