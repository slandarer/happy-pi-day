% Zhaoxu Liu / slandarer (2026). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2026/3/14.

clc; clear 
% author : slandarer

% 生成随机数据
rng(6)
Data=zeros(10,10);
Pi=getPi(1001);
for i=1:1000
    Data(Pi(i)+1,Pi(i+1)+1)=Data(Pi(i)+1,Pi(i+1)+1)+1;
end

% 数据名称
% 'Class-1','Class-2',... ...,'Class-6'
Name1 = compose('%d-x', 0:9);
Name2 = compose('x-%d', 0:9);
% 配色
CList = [231,98,84;239,138,71;247,170,88;255,208,111;255,230,183;
    170,220,224;114,188,213;82,143,173;55,103,149;30,70,110]./255;
% 数据展示范围及刻度
YLim = [];
YTick = [];

% =========================================================================
% 开始绘图
if isempty(YLim) || isempty(YTick)
    tFig = figure('Visible', 'off');
    tAx = axes('Parent',tFig);
    tAx.NextPlot = 'add';
    bar(tAx, Data, 'stacked')
    if isempty(YLim), YLim = tAx.YLim; else, tAx.YLim = YLim; end
    if isempty(YTick), YTick = tAx.YTick; end
    close(tFig)
end
% 创建图窗
fig = figure('Units','normalized', 'Position',[.2,.1,.5,.8]);
ax = axes('Parent',fig, 'Position',[0,0,1,1]);
ax.NextPlot = 'add';
ax.XColor = 'none';
ax.YColor = 'none';
ax.DataAspectRatio = [1,1,1];
% 绘制坐标轴和刻度线
TLim = [pi/2, -pi - pi/6];
t01 = linspace(0, 1, 80);
N = size(Data, 1);
tT = t01.*diff(TLim) + TLim(1);
tX = cos(tT).*(N + N/2 + 1);
tY = sin(tT).*(N + N/2 + 1);
plot(ax, tX, tY, 'LineWidth',.8, 'Color','k')
ax.XLim = [-1,1].*(N + N/2 + 2);
ax.YLim = [-1,1].*(N + N/2 + 2);
tT = (YTick - YLim(1))./diff(YLim).*diff(TLim) + TLim(1);
tX = [cos(tT).*(N + N/2 + 1); cos(tT).*(N + N/2 + 1 + N/50); tT.*nan];
tY = [sin(tT).*(N + N/2 + 1); sin(tT).*(N + N/2 + 1 + N/50); tT.*nan];
plot(ax, tX(:), tY(:), 'LineWidth',.8, 'Color','k')
for i = 1:length(YTick)
    iT = tT(i); iR = iT/pi*180;
    YTickHdl = text(ax, tX(2,i), tY(2,i),...
        num2str(YTick(i)), 'FontName','Times New Roman', 'FontSize',13, 'HorizontalAlignment','center');
    if mod(iR, 360) > 180 && mod(iR, 360) < 360
        YTickHdl.Rotation = iR + 90;
        YTickHdl.VerticalAlignment = 'top';
    else
        YTickHdl.Rotation = iR - 90;
        YTickHdl.VerticalAlignment = 'bottom';
    end
end

Data = cumsum([zeros(N, 1), Data], 2);
% 绘制柱状图
for i = 1:N
    for j = 1:(size(Data, 2) - 1)
        tR = [(N + N/2 + 1 - i - .4).*ones(1, 80), (N + N/2 + 1 - i + .4).*ones(1, 80)];
        tT = (t01.*(Data(i, j + 1) - Data(i, j)) + Data(i, j) - YLim(1))./diff(YLim).*diff(TLim) + TLim(1);
        tX = cos([tT, tT(end:-1:1)]).*tR;
        tY = sin([tT, tT(end:-1:1)]).*tR;
        tHdl = fill(ax, tX, tY, CList(j,:), 'LineWidth',1, 'EdgeColor','k','FaceAlpha',.7);
        if i == 1
            lgdHdl(j) = tHdl;
        end
    end
end
% 绘制数据名称
for i = 1:N
    text(ax, 0, N + N/2 + 1 - i, [Name1{i},'  '], 'FontName','Times New Roman',...
        'FontSize',16, 'HorizontalAlignment','right');
end
% 绘制图例
legend(lgdHdl, Name2, 'FontName','Times New Roman',...
    'FontSize',16, 'Box','off', 'Location','best',...
    'Position',[.22, .93 - .04*(size(Data, 2) - 1), .1, .04*(size(Data, 2) - 1)]);

text(0,0,'\pi','FontName','Times New Roman','FontSize',100,...
    'HorizontalAlignment','center','LineWidth',1)