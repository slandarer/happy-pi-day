%% PiSunburstDemo : Sunburst chart of digit transitions in π —— 1000 digits
% Zhaoxu Liu / slandarer (2026). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2026/3/14.

rng(1); 
% Build adjacency matrix of digit transitions (构建相邻数字转移的邻接矩阵)
dataMat = zeros(10, 10);
Pi = getPi(1001);
for i = 1:1000
    dataMat(Pi(i)+1, Pi(i+1)+1) = dataMat(Pi(i)+1, Pi(i+1)+1) + 1;
end

% Prepare hierarchy data: current digit, next digit, and transition count
% (准备层次数据：当前数字、下一个数字、转移计数)
Name1 = repmat(compose("%d", 0:9).', [1,10]);   % First-level labels (第一层标签)
Name2 = compose("%d-%d", (0:9).', (0:9));       % Second-level labels (第二层标签)
Name1 = Name1(:); Name2 = Name2(:);
Value  = dataMat(:);
Table  = table(Name1, Name2, Value);

%% ========================================================================
% Convert categorical columns to numeric indices, then sort by hierarchy
% (将分类列转换为数值索引，然后按层次排序)
NameList  = Table.Properties.VariableNames;
NameNum   = length(NameList) - 1;
NameCell{NameNum} = ' ';
valueList = zeros(length(Table.(NameList{1})), NameNum);
for i = 1:NameNum-1
    tName = Table.(NameList{i});
    tUniq = unique(tName, 'rows');
    NameCell{i} = tUniq;
    ind = grp2idx([tUniq; tName]);
    ind(1:length(tUniq)) = [];
    valueList(:, i) = ind;
end
valueList(:, end) = -Table.(NameList{end});
[VAL, IDX] = sortrows(valueList, 1:size(valueList, 2));
VAL(:, end) = -VAL(:, end);

%% ========================================================================
% Color palette for digits 0-9 (数字0-9配色)
CList = [231, 98, 84; 239,138, 71; 247,170, 88; 255,208,111; 255,230,183;
         170,220,224; 114,188,213;  82,143,173;  55,103,149;  30, 70,110] ./ 255;
% Font properties for labels (标签字体属性)
FontProp = {'FontSize',14,'Color',[0,0,0],'FontName','Times New Roman'};
% Minimum proportion to display text (显示文本的最小比例阈值)
TextThreshold = 0.001;
%% ========================================================================
% Create figure and axes (创建图窗和坐标轴)
figure('Units', 'normalized', 'Position', [.2, .1, .52, .72]);
ax = gca; hold on
ax.DataAspectRatio = [1, 1, 1];
ax.XColor = 'none';
ax.YColor = 'none';

% Center π symbol (中心π符号)
text(0, 0, 'π', 'FontSize', 100, 'FontName', 'Times New Roman', ...
     'HorizontalAlignment', 'center');

% Angular sampling for each ring segment (每个环形段的角采样)
tT = linspace(0, 1, 100);
LCList = CList(1:length(NameCell{1}), :);

% Loop over each level of the hierarchy (循环遍历每个层次)
for i = 1:size(VAL, 2) - 1
    tRateSum = 0;
    tNum = length(NameCell{i});
    NCList = zeros(tNum, 3);
    for j = 1:tNum
        tRate = sum(VAL(VAL(:, i) == j, end)) / sum(VAL(:, end));
        tTheta = [tRateSum + tT .* tRate, tRateSum + tRate - tT .* tRate] .* pi .* 2;
        tR = [tT .* 0 + i, tT .* 0 + i + 1];
        
        if i == 1
            fill(cos(tTheta) .* tR, sin(tTheta) .* tR, CList(j, :), ...
                 'EdgeColor', [1,1,1], 'LineWidth', 1);
        else
            tCN = VAL(find(VAL(:, i) == j, 1), i-1);
            tNN = j - VAL(find(VAL(:, i-1) == tCN, 1), i) + 1;
            tPN = length(unique(VAL(VAL(:, i-1) == tCN, i)));
            if mod(i, 2) ~= 0
                tRN = tNN;
            else
                tRN = tPN + 1 - tNN;
            end
            NCList(j, :) = LCList(tCN, :) .* 0.8^(tRN-1) + [1,1,1] .* (1 - 0.8^(tRN-1));
            fill(cos(tTheta) .* tR, sin(tTheta) .* tR, NCList(j, :), ...
                 'EdgeColor', [1,1,1], 'LineWidth', 1);
        end
        
        % Add label if segment is large enough (若扇区足够大则添加标签)
        rotation = (tRateSum + tRate/2) * 360;
        if tRate > TextThreshold
            midAngle = (tRateSum + tRate/2) * pi * 2;
            radiusPos = i + 0.4; 
            if rotation > 90 && rotation < 270
                % Flip text for left side (左侧文字翻转)
                rotation = rotation + 180;
                text(cos(midAngle) * radiusPos, sin(midAngle) * radiusPos, ...
                     NameCell{i}(j, :) + " ", FontProp{:}, ...
                     'Rotation', rotation, 'HorizontalAlignment', 'right');
            else
                text(cos(midAngle) * radiusPos, sin(midAngle) * radiusPos, ...
                     " " + NameCell{i}(j, :), FontProp{:}, ...
                     'Rotation', rotation);
            end
        end
        tRateSum = tRateSum + tRate;
    end
    if i ~= 1
        LCList = NCList;
    end
end

tRateSum = 0;
tNameCell = Table.(NameList{end-1});
NCList = zeros(size(VAL, 1), 3);
for j = 1:size(VAL, 1)
    tRate = VAL(j, end) / sum(VAL(:, end));
    tTheta = [tRateSum + tT .* tRate, tRateSum + tRate - tT .* tRate] .* pi .* 2;
    tR = [tT .* 0 + size(VAL, 2), tT .* 0 + size(VAL, 2) + 1];

    tCN = VAL(j, size(VAL, 2)-1);
    tNN = j - find(VAL(:, size(VAL, 2)-1) == tCN, 1) + 1;
    tPN = sum(VAL(:, size(VAL, 2)-1) == tCN);
    if mod(size(VAL, 2), 2) ~= 0
        tRN = tNN;
    else
        tRN = tPN + 1 - tNN;
    end
    NCList(j, :) = LCList(tCN, :) .* 0.8^(tRN-1) + [1,1,1] .* (1 - 0.8^(tRN-1));
    fill(cos(tTheta) .* tR, sin(tTheta) .* tR, NCList(j, :), ...
         'EdgeColor', [1,1,1], 'LineWidth', 1);

    rotation = (tRateSum + tRate/2) * 360;
    if tRate > TextThreshold
        midAngle = (tRateSum + tRate/2) * pi * 2;
        radiusPos = size(VAL, 2) + 1;
        if rotation > 90 && rotation < 270
            rotation = rotation + 180;
            text(cos(midAngle) * radiusPos, sin(midAngle) * radiusPos, ...
                 tNameCell(IDX(j), :) + " ", FontProp{:}, ...
                 'Rotation', rotation, 'HorizontalAlignment', 'right');
        else
            text(cos(midAngle) * radiusPos, sin(midAngle) * radiusPos, ...
                 " " + tNameCell(IDX(j), :), FontProp{:}, ...
                 'Rotation', rotation);
        end
    end
    tRateSum = tRateSum + tRate;
end