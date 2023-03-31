% PiPlotDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
% 获取pi前1500位小数
Pi=getPi(1500); 
% 计算比例变化
Ratio=cumsum(Pi==(0:9)',2);
Ratio=Ratio./sum(Ratio);
D=1:length(Ratio);
% 配色列表
CM=[20,164,199;43,187,170;53,165,81;189,190,28;248,167,22;
    232,74,27;244,57,99;240,118,177;168,109,195;78,125,187]./255;
hold on
% 循环绘图
for i=1:10
    plot(D(20:end),Ratio(i,20:end),'Color',[CM(i,:),.6],'LineWidth',1.8)
end
% 坐标区域修饰
ax=gca;box on;grid on
ax.YLim=[0,.2];
ax.YTick=0:.05:.2;
ax.XTick=0:200:1400;
ax.YTickLabel={'0%','5%','10%','15%','20%'};
ax.XMinorTick='on';
ax.YMinorTick='on';
ax.LineWidth=.8;
ax.GridLineStyle='-.';
ax.FontName='Cambria';
ax.FontSize=11;
ax.XLabel.String='Decimals';
ax.YLabel.String='Proportion';
ax.XLabel.FontSize=13;
ax.YLabel.FontSize=13;
% 绘制图例并修饰
lgdHdl=legend(num2cell('0123456789'));
lgdHdl.NumColumns=5;
lgdHdl.FontWeight='bold';
lgdHdl.FontSize=11;
lgdHdl.TextColor=[.5,.5,.5];








