function(rho,rho0,eta)
rho=1100; %particle density kg/m3
rho0=1000;%water density kg/m3
g=9.8; %gravitational acceleration m/s2
eta=1.005d-3;%Viscosity coefficient of water Pa*s
d;% particle diameter，for the simplicity of formula，consider its unit as m
n;% particle numbers
u=d.*d.*(rho-rho0).*g/18./eta;
for t=1:14 % time interval (s)
    z(:,t+1)=u.*t;
end
if sum(sum(z>1.5))~=0 %  test whether the particle sinking distance longer than the water depth
    [row,column]=find(z>1.5);% Identify particles whose sinking distance is greater than the depth of the water column and record their coordinates
    z(row,column)=1.5;% Make the particles whose sinking distance is greater than the depth of the water column stay at the bottom of the water column, that is, the position does not change
end
size=d*100;
sz=60;
% plot
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
% plot the time series
