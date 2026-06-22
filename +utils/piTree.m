function piTree(X, pos, D)
% piTree - Generate a fractal tree from a digit sequence (根据数字序列生成分形树)
%   The tree grows by interpreting each digit as the number of branches at each
%   node, with special rules for digits 0 and 9 to create leaves and flowers.
%   (树根据每个数字作为每个节点的分支数生长，数字0和9有特殊规则，形成叶子和花朵)
%
%   piTree(X, pos, D) creates a single tree using the digits in X. The tree
%   is typically one segment of the "π forest", where each tree corresponds to
%   a consecutive block of digits up to the next 9.
%   (使用数字数组X创建一棵树。通常用于"π森林"中的一棵树，每棵树对应一段
%   以 9 为分隔符的连续数字块。)
%
% Inputs:
%   X   - row vector of digits. In the forest demo, X always ends with 9
%         followed by another digit (e.g., [3,1,4,1,5,9,2]).
%         (数字行向量。在森林演示中，X始终以9后接另一个数字结尾，例如 [3,1,4,1,5,9,2]。)
%   pos - starting position [x, y] of the tree trunk (树干的起始坐标 [x, y])
%   D   - Logical flag to enable or disable full branching (逻辑标志，启用或禁用完整分支)
%         When D is true, the tree grows according to the full digit sequence:
%         each digit (except the last two) determines the number of branches
%         at each node. When D is false, only the trunk is drawn and no further
%         branching occurs.
%         (若 D 为 true，树按照完整的数字序列生长：每个数字（最后两位除外）决定
%          每个节点的分支数。若 D 为 false，仅绘制树干，不产生分支)

    lw = 2;
    % Slight randomness in growth direction (生长方向的随机性)
    theta = pi/2 + (rand(1) - 0.5) * pi / 12;   
    
    % Colors for digits 0-9 (叶子/花朵颜色对应数字)
    CM = [237, 32,121; 237, 62, 54; 247, 99, 33; 255,183, 59; 245,236, 43;
          141,196, 63;  57,178, 74;   0,171,238;  40, 56,145; 146, 39,139] ./ 255;
    
    hold on
    
    % If all branching digits (excluding the last three) are zero, no branching
    if all(X(1:end-2) == 0)
        endSet = [pos, pos, theta];
    else
        kplot(pos(1) + [0, cos(theta)], pos(2) + [0, sin(theta)], lw / 0.6)
        endSet = [pos, pos + [cos(theta), sin(theta)], theta];
        
        Layer = 0;
        for i = 1:length(X)
            Layer = [Layer, ones(1, X(i)) * i];
        end
        
        if D
            for i = 1:length(X)-2
                if X(i) == 0
                    % No branch (无分支)
                    newSet = endSet(1, :);
                elseif X(i) == 1
                    % Two branches: one longer, one shorter (两个分支一长一短)
                    tTheta = endSet(1, 5);
                    tTheta = linspace(tTheta + pi/8, tTheta - pi/8, 2)' + (rand([2,1]) - 0.5) * pi / 8;
                    newSet = repmat(endSet(1, 3:4), [X(i), 1]);
                    newSet = [newSet .* [1;1], newSet + [cos(tTheta), sin(tTheta)] .* .7^Layer(i) .* [1; .1], tTheta];
                else
                    % Multiple branches evenly spaced (多个分支均匀分布)
                    tTheta = endSet(1, 5);
                    tTheta = linspace(tTheta + pi/5, tTheta - pi/5, X(i))' + (rand([X(i),1]) - 0.5) * pi / 8;
                    newSet = repmat(endSet(1, 3:4), [X(i), 1]);
                    newSet = [newSet, newSet + [cos(tTheta), sin(tTheta)] .* .7^Layer(i), tTheta];
                end
                % Draw the branches (绘制分支)
                for j = 1:size(newSet, 1)
                    kplot(newSet(j, [1,3]), newSet(j, [2,4]), lw * .6^Layer(i))
                end
                endSet = [endSet; newSet];
                endSet(1, :) = [];
            end
        end
    end
    
    % Extract terminal positions (提取末端位置)
    FLSet = endSet(:, 3:4);
    [~, FLInd] = sort(FLSet(:, 1));
    FLSet = FLSet(FLInd, :);
    
    % Randomly select length(X)-2 terminal nodes to serve as leaves and flowers,
    % then choose one terminal for flower, others for leaves 
    % (随机选择 length(X)  -2 个末端节点作为叶子和花朵, 随机选一个末端作为花朵，其余作为叶子)
    [~, tempInd] = sort(rand([1, size(FLSet, 1)]));
    tempInd = sort(tempInd(1:length(X)-2));
    flowerInd = tempInd(randi([1, length(X)-2], [1, 1]));
    leafInd = tempInd(tempInd ~= flowerInd);
    
    % Draw leaves (绘制叶子)
    for i = 1:length(leafInd)
        scatter(FLSet(leafInd(i), 1), FLSet(leafInd(i), 2), 70, ...
                'filled', 'CData', CM(X(i)+1, :))
    end
    
    % Draw flower (绘制花朵)
    for i = 1:5
        scatter(FLSet(flowerInd, 1) + cos(pi*2*i/5)*0.18, ...
                FLSet(flowerInd, 2) + sin(pi*2*i/5)*0.18, 60, ...
                'filled', 'CData', CM(X(end-2)+1, :), 'MarkerEdgeColor', [1,1,1])
    end
    scatter(FLSet(flowerInd, 1), FLSet(flowerInd, 2), 60, ...
            'filled', 'CData', CM(X(end)+1, :), 'MarkerEdgeColor', [1,1,1])
    drawnow;
    
    % Internal function to draw a segment with tapering line width (内部函数：绘制渐变粗细的线段)
    function kplot(XX, YY, LW, varargin)
        LW = linspace(LW, LW * 0.6, 10);
        XX = linspace(XX(1), XX(2), 11)';
        XX = [XX(1:end-1), XX(2:end)];
        YY = linspace(YY(1), YY(2), 11)';
        YY = [YY(1:end-1), YY(2:end)];
        for ii = 1:10
            plot(XX(ii, :), YY(ii, :), 'LineWidth', LW(ii), 'Color', [0.1, 0.1, 0.1])
        end
    end
end