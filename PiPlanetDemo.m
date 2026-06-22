%% PiPlanetDemo : Gravitational simulation of pi digits —— 72 particles
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.

% Get digit sequence: leading 3 and first 71 decimals (共72个数字)
Pi = [3, getPi(71)];
K = 0.18;   % Mass exponent factor (质量指数因子)

% Color palette for digits 0-9 (数字0-9配色)
CM = [239, 32,120; 239, 60, 52; 247, 98, 32; 255,182, 60; 247,235, 44;
      142,199, 57;  55,180, 70;   0,170,239;  40, 56,146; 147, 37,139] ./ 255;

% Initial positions: evenly spaced on a circle (初始位置：均匀分布在圆上)
T = linspace(0, 2*pi, length(Pi)+1)';
T = T(1:end-1);

ct = linspace(0, 2*pi, 100);
cx = cos(ct) * 0.027;
cy = sin(ct) * 0.027;

% Initialize particle data (初始化粒子数据)
Pi = Pi(:);
N = Pi;                          % Digit values (数字值)
X = cos(T); Y = sin(T);          % Current positions (当前位置)
VX = T*0; VY = T*0;              % Current velocities (当前速度)
PX = X; PY = Y;                  % Trajectory history (轨迹历史)

% Mass of each particle (每个粒子的质量)
getM = @(x) (x+1).^K;
M = getM(N);

% Draw initial particles (绘制初始粒子)
hold on
for i = 1:length(N)
    fill(cx + X(i), cy + Y(i), CM(N(i)+1, :), 'EdgeColor', 'w', 'LineWidth', 1)
end

% Main simulation loop (主模拟循环)
for k = 1:800
    % ---- Compute gravitational acceleration (计算引力加速度) ----
    Rn2 = 1 ./ squareform(pdist([X, Y])).^2;   % Inverse squared distances (距离平方倒数)
    Rn2(eye(length(X)) == 1) = 0;              % Exclude self (排除自身)
    MRn2 = Rn2 .* (M');                        % Mass-weighted (质量加权)
    
    AX = X' - X; AY = Y' - Y;                  % Coordinate differences (坐标差)
    normXY = sqrt(AX.^2 + AY.^2);
    AX = AX ./ normXY; AX(eye(length(X)) == 1) = 0;
    AY = AY ./ normXY; AY(eye(length(X)) == 1) = 0;
    AX = sum(AX .* MRn2, 2) ./ 150000;         % Acceleration X (X方向加速度)
    AY = sum(AY .* MRn2, 2) ./ 150000;         % Acceleration Y (Y方向加速度)
    
    % Update velocity and position (更新速度和位置)
    VX = VX + AX; X = X + VX; PX = [PX, X];
    VY = VY + AY; Y = Y + VY; PY = [PY, Y];
    
    % Collision detection (碰撞检测)
    R = squareform(pdist([X, Y]));
    R(triu(ones(length(X))) == 1) = inf;
    [row, col] = find(R <= 0.04);
    
    if isscalar(X)
        break;   % Only one particle left (只剩一个粒子)
    end
    
    if ~isempty(row)
        % Merge colliding particles (合并碰撞粒子)
        % Compute merged position (计算合并后的位置)
        XC = (X(row) + X(col)) ./ 2;
        YC = (Y(row) + Y(col)) ./ 2;
        % Merge velocity by momentum conservation (按动量守恒合并速度)
        VXC = (VX(row).*M(row) + VX(col).*M(col)) ./ (M(row) + M(col));
        VYC = (VY(row).*M(row) + VY(col).*M(col)) ./ (M(row) + M(col));
        PC = nan(length(row), size(PX, 2));
        % New digit value is sum mod 10 (新数字值为两数之和模10)
        NC = mod(N(row) + N(col), 10);
        
        % Remove collided particles and draw their trajectories (移除碰撞粒子并绘制其轨迹)
        uniNum = unique([row; col]);
        X(uniNum) = []; VX(uniNum) = [];
        Y(uniNum) = []; VY(uniNum) = [];
        for i = 1:length(uniNum)
            plot(PX(uniNum(i), :), PY(uniNum(i), :), 'LineWidth', 2, 'Color', CM(N(uniNum(i))+1, :))
        end
        PX(uniNum, :) = []; PY(uniNum, :) = []; N(uniNum, :) = [];
        
        % Draw the new merged particles (绘制新合并的粒子)
        for i = 1:length(XC)
            fill(cx + XC(i), cy + YC(i), CM(NC(i)+1, :), 'EdgeColor', 'w', 'LineWidth', 1)
        end
        
        % Append merged particles (添加合并后的粒子)
        X = [X; XC]; Y = [Y; YC];
        VX = [VX; VXC]; VY = [VY; VYC];
        PX = [PX; PC]; PY = [PY; PC];
        N = [N; NC];
        M = getM(N);   % Update mass (更新质量)
    end
end

% Draw remaining trajectories (绘制剩余粒子的轨迹)
for i = 1:size(PX, 1)
    plot(PX(i, :), PY(i, :), 'LineWidth', 2, 'Color', CM(N(i)+1, :))
end

% Display parameters (显示参数)
text(-1, 1, {['Num = ', num2str(length(Pi))]; ['K = ', num2str(K)]}, ...
     'FontSize', 13, 'FontName', 'Cambria')

% Figure and axes decoration (图窗及坐标区域修饰)
set(gcf, 'Position', [200, 100, 820, 820]);
ax = gca;
ax.Position = [0, 0, 1, 1];
ax.DataAspectRatio = [1, 1, 1];
ax.XLim = [-1.1, 1.1];
ax.YLim = [-1.1, 1.1];
ax.XTick = [];
ax.YTick = [];
ax.XColor = 'none';
ax.YColor = 'none';