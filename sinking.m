function(rho,rho0,eta)
rho=1100; %�����ܶ� kg/m3
rho0=1000;%ˮ���ܶ� kg/m3
g=9.8; %�������ٶ� m/s2
eta=1.005d-3;%ˮ���ճ��ϵ�� Pa*s
d;%�������ֱ����Ϊ��ʽ����࣬ȡ����Ϊ m
n;%������ĸ���
u=d.*d.*(rho-rho0).*g/18./eta;
for t=1:14 %��ʱ���� ��λ��ʱ��Ϊs
    z(:,t+1)=u.*t;
end
if sum(sum(z>1.5))~=0 %�ж��Ƿ���ڳ����������ˮ���߶ȵĿ���
    [row,column]=find(z>1.5);%ʶ������������ˮ���߶ȵĿ�������¼���±�
    z(row,column)=1.5;%ʹ�����������ˮ���߶ȵĿ���ͣ����ˮ���ײ�����λ�ò��ٱ仯
end
size=d*100;
sz=60;
for k=1:1+t
    test=z(:,k);
    figure()
    scatter(n,test,sz,size,'fill');
    %scatter(n,test,size,'MarkerFaceColor','r','MarkerEdgeColor','k')
    set(gcf,'PaperPositionMode','auto');
    set(gca,'XAxisLocation','top');
    set(gca,'YDir','reverse'); 
    ylim([0 1.5]);
    xlabel('number of particles','fontsize',12);
    ylabel('depth(m)','fontsize',12);
    caxis([0,0.18]);
    colorbar
    title(['Second',num2str(k)],'fontsize',14);
    colormap(flipud(colormap));
    print('-dpng','-r200',[num2str(k),'.png']);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:15;
    str = strcat(num2str(k), '.png');
    A=imread(str);
    [I,map]=rgb2ind(A,256);
    if(k==1)
        imwrite(I,map,'movefig.gif','DelayTime',0.1,'LoopCount',Inf)
    else
        imwrite(I,map,'movefig.gif','WriteMode','append','DelayTime',0.1)
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ʱ������
