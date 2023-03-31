% PiBarConnectDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
% 获取pi前100位小数
Pi=getPi(100); 
% 计算比例变化
Ratio=cumsum(Pi==(0:9)',2);
Ratio=Ratio./sum(Ratio);

X=Ratio(:,10:10:80)';
barHdl=bar(X,'stacked','BarWidth',.2);

CM=[231,98,84;239,138,71;247,170,88;255,208,111;255,230,183;
    170,220,224;114,188,213;82,143,173;55,103,149;30,70,110]./255;
for i=1:10
    barHdl(i).FaceColor=CM(i,:);
end
% 以下是生成连接的部分
hold on;axis tight 
yEndPoints=reshape([barHdl.YEndPoints]',length(barHdl(1).YData),[])';
zeros(1,length(barHdl(1).YData));
yEndPoints=[zeros(1,length(barHdl(1).YData));yEndPoints];
barWidth=barHdl(1).BarWidth;
for i=1:length(barHdl)
    for j=1:length(barHdl(1).YData)-1
        y1=min(yEndPoints(i,j),yEndPoints(i+1,j));
        y2=max(yEndPoints(i,j),yEndPoints(i+1,j));
        if y1*y2<0
            ty=yEndPoints(find(yEndPoints(i+1,j)*yEndPoints(1:i,j)>=0,1,'last'),j);
            y1=min(ty,yEndPoints(i+1,j));
            y2=max(ty,yEndPoints(i+1,j));
        end
        y3=min(yEndPoints(i,j+1),yEndPoints(i+1,j+1));
        y4=max(yEndPoints(i,j+1),yEndPoints(i+1,j+1));
        if y3*y4<0
            ty=yEndPoints(find(yEndPoints(i+1,j+1)*yEndPoints(1:i,j+1)>=0,1,'last'),j+1);
            y3=min(ty,yEndPoints(i+1,j+1));
            y4=max(ty,yEndPoints(i+1,j+1));
        end
        fill([j+.5.*barWidth,j+1-.5.*barWidth,j+1-.5.*barWidth,j+.5.*barWidth],...
            [y1,y3,y4,y2],barHdl(i).FaceColor,'FaceAlpha',.4,'EdgeColor','none');
    end
end
% 图窗和坐标区域修饰
set(gcf,'Position',[200,100,720,420]);
ax=gca;box off
ax.YLim=[0,1];
ax.XMinorTick='on';
ax.YMinorTick='on';
ax.LineWidth=.8;
ax.FontName='Cambria';
ax.FontSize=11;
ax.TickDir='out';
ax.XTickLabel={'10','20','30','40','50','60','70','80'};
ax.XLabel.String='Decimals';
ax.YLabel.String='Proportion';
ax.XLabel.FontSize=13;
ax.YLabel.FontSize=13;
ax.Title.String='Area Chart of Proportion — 10-80 digits';
ax.Title.FontSize=14;
% 绘制图例并修饰
lgdHdl=legend(barHdl,num2cell('0123456789'));
lgdHdl.NumColumns=5;
lgdHdl.FontSize=11;
lgdHdl.Location='southeast';