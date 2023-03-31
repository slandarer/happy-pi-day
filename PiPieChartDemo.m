% PiPieChartDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
% 获取pi前1500位小数
Pi=getPi(1500);
% 统计各个数字出现次数
numNum=find([diff(sort(Pi)),1]);
numNum=[numNum(1),diff(numNum)];
% 配色列表
CM=[20,164,199;43,187,170;53,165,81;189,190,28;248,167,22;
    232,74,27;244,57,99;240,118,177;168,109,195;78,125,187]./255;
% 绘图并修饰
pieHdl=pie(numNum);
set(gcf,'Color',[1,1,1],'Position',[200,100,620,620]);
for i=1:2:20
    pieHdl(i).EdgeColor=[1,1,1];
    pieHdl(i).LineWidth=1;
    pieHdl(i).FaceColor=CM((i+1)/2,:);
end
for i=2:2:20
    pieHdl(i).Color=CM(i/2,:);
    pieHdl(i).FontWeight='bold';
    pieHdl(i).FontSize=14;
end
% 绘制图例并修饰
lgdHdl=legend(num2cell('0123456789'));
lgdHdl.FontWeight='bold';
lgdHdl.FontSize=11;
lgdHdl.TextColor=[.5,.5,.5];
lgdHdl.Location='southoutside';
lgdHdl.Box='off';
lgdHdl.NumColumns=10;
lgdHdl.ItemTokenSize=[20,15];
title("VISUALIZING  \pi 'Pi' Chart | 1500 digits",'FontSize',18,...
    'FontName','Times New Roman','Color',[.5,.5,.5])

