function getLogo
% Zhaoxu Liu / slandarer (2023). Happy Pi Day 
% (https://www.mathworks.com/matlabcentral/fileexchange/126210-happy-pi-day), 
% MATLAB Central File Exchange. 检索来源 2023/3/13.
if ~exist('image','dir')
    mkdir('image\')
end
logoSet=['.',char(65:90)];
for i=1:27
    figure();
    ax=gca;
    ax.XLim=[-1,1];
    ax.YLim=[-1,1];
    ax.XColor='none';
    ax.YColor='none';
    ax.DataAspectRatio=[1,1,1];
    logo=logoSet(i);
    hold on
    text(0,0,logo,'HorizontalAlignment','center','FontSize',320,'FontName','Segoe UI Black')
    exportgraphics(ax,['image\',logo,'.png'])
    close
end
dotPic=imread('image\..png');
newDotPic=uint8(ones([400,size(dotPic,2),3]).*255);
newDotPic(end-size(dotPic,1)+1:end,:,1)=dotPic(:,:,1);
newDotPic(end-size(dotPic,1)+1:end,:,2)=dotPic(:,:,2);
newDotPic(end-size(dotPic,1)+1:end,:,3)=dotPic(:,:,3);
imwrite(newDotPic,'image\..png')

S=20;
for i=1:27
    logo=logoSet(i);
    tPic=imread(['image\',logo,'.png']);
    sz=size(tPic,[1,2]);
    sz=round(sz./sz(1).*400);
    tPic=imresize(tPic,sz);
    tBox=uint8(255.*ones(size(tPic,[1,2])+S));
    tBox(S+1:S+size(tPic,1),S+1:S+size(tPic,2))=tPic(:,:,1);
    imwrite(cat(3,tBox,tBox,tBox),['image\',logo,'.png'])
end
end