% Zhaoxu Liu / slandarer (2026). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2026/3/14.
figure('Units','normalized','Position',[.1,.05,.7,.85])
dataMat=zeros(10,10);
Pi=getPi(1001);
for i=1:1000
    dataMat(Pi(i)+1,Pi(i+1)+1)=dataMat(Pi(i)+1,Pi(i+1)+1)+1;
end
str1 = compose("%d", 0:9).';
str2 = compose("%d-%d",(0:9).',(0:9)).';
str = ["\pi";str1(:);str2(:)];
DMat = zeros(111);
DMat(1, 2:11) = sum(dataMat,2)./sum(sum(dataMat));
for i = 1:10
    dataMat(i,:) = dataMat(i,:)./sum(dataMat(i,:));
    DMat(i+1, (2:11)+i*10) = dataMat(i,:);
end
% 构建网络图
G = graph(DMat,'upper');
G.Nodes = str;
% 绘图
pHdl = plot(G,'Layout','force','WeightEffect','direct','Iterations',1000);
ax = gca;
ax.NextPlot = 'add';
ax.DataAspectRatio = [1,1,1];
ax.XLim = ax.XLim;
ax.YLim = ax.YLim;
CM=[231,98,84;239,138,71;247,170,88;255,208,111;255,230,183;
    170,220,224;114,188,213;82,143,173;55,103,149;30,70,110]./255;
for i = 1:10
    bubblechart(pHdl.XData((11+i):10:end), pHdl.YData((11+i):10:end), dataMat(:,i).',...
        CM(i,:),'MarkerFaceAlpha',.5);
    bhdl(i) = fill([100,100,101],[101,101,100],CM(i,:),'FaceAlpha',.4,'EdgeColor',CM(i,:));
end
uistack(pHdl,'top')
% 绘制文本
for i = 1:10
    text(pHdl.XData(i+1),pHdl.YData(i+1),num2str(i-1),'FontName','Times New Roman','FontSize',20,...
    'HorizontalAlignment','center','LineWidth',1)
end
text(pHdl.XData(1),pHdl.YData(1),'\pi','FontName','Times New Roman','FontSize',100,...
    'HorizontalAlignment','center','LineWidth',1)
% 绘制图例
bubblelegend('Location','northeast')
legend(bhdl,compose("%d",0:9),'FontName','Times New Roman','FontSize',14,...
    'NumColumns',2,'AutoUpdate','off','Location','northeast')


