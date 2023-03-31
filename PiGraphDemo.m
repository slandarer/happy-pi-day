% PiGraphDemo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
% 构建连接矩阵
corrMat=zeros(10,10);
Pi=getPi(401);
for i=1:400
    corrMat(Pi(i)+1,Pi(i+1)+1)=corrMat(Pi(i)+1,Pi(i+1)+1)+1;
end
% 配色列表
colorList=[0.3725    0.2745    0.5647
    0.1137    0.4118    0.5882
    0.2196    0.6510    0.6471
    0.0588    0.5216    0.3294
    0.4510    0.6863    0.2824
    0.9294    0.6784    0.0314
    0.8824    0.4863    0.0196
    0.8000    0.3137    0.2431
    0.5804    0.2039    0.4314
    0.4353    0.2510    0.4392];
t=linspace(0,2*pi,11);t=t(1:10)';
posXY=[cos(t),sin(t)];

maxWidth=max(corrMat(corrMat>0));
minWidth=min(corrMat(corrMat>0));
ttList=linspace(0,1,3)';
% 循环绘图
hold on
for i=1:size(corrMat,1)  
    for j=i+1:size(corrMat,2)
        if corrMat(i,j)>0
            tW=(corrMat(i,j)-minWidth)./(maxWidth-minWidth);
            colorData=(1-ttList).*colorList(i,:)+ttList.*colorList(j,:);
            CData(:,:,1)=colorData(:,1);
            CData(:,:,2)=colorData(:,2);
            CData(:,:,3)=colorData(:,3);
            % 绘制连线
            fill(linspace(posXY(i,1),posXY(j,1),3),...
                 linspace(posXY(i,2),posXY(j,2),3),[0,0,0],'LineWidth',tW.*12+1,...
                 'CData',CData,'EdgeColor','interp','EdgeAlpha',.7,'FaceAlpha',.7)
        end
    end
    % 绘制圆点
    scatter(posXY(i,1),posXY(i,2),200,'filled','LineWidth',1.2,...
        'MarkerFaceColor',colorList(i,:),'MarkerEdgeColor',[.7,.7,.7]); 
    text(posXY(i,1).*1.13,posXY(i,2).*1.13,num2str(i-1),'Color',[1,1,1].*.7,...
        'FontSize',30,'FontWeight','bold','FontName','Cambria','HorizontalAlignment','center')
end
text(0,1.3,'Numerical adjacency of \pi — 400 digits','Color',[1,1,1],'FontName','Cambria',...
    'HorizontalAlignment','center','FontSize',25,'FontAngle','italic')
% 图窗和坐标区域修饰
set(gcf,'Position',[200,100,820,820]);
ax=gca;
ax.XLim=[-1.2,1.2];
ax.YLim=[-1.21,1.5];
ax.XTick=[];
ax.YTick=[];
ax.Color=[0,0,0];
ax.DataAspectRatio=[1,1,1];




