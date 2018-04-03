%%%%%%% EOF %%%%%%
clc;close;clear all;
%%
%%%录入ERSST文件
ncdisp('/Users/mattia/科研/ningaloo coral/data/SST/ERSST_v5.nc');
lon = ncread('/Users/mattia/科研/ningaloo coral/data/SST/ERSST_v5.nc','lon');
lat = ncread('/Users/mattia/科研/ningaloo coral/data/SST/ERSST_v5.nc','lat');
sst = ncread('/Users/mattia/科研/ningaloo coral/data/SST/ERSST_v5.nc','sst');
tim = ncread('/Users/mattia/科研/ningaloo coral/data/SST/ERSST_v5.nc','time');
load ER_SO_index.mat;

tim = tim + datenum('1800-1-1 00:00:00','yyyy-mm-dd HH:MM:SS');
sst(find(sst <= -100)) = nan;


%%%     region by Takahito et al., 2013     %%%
%%%     100E - 120E 12S - 34S               %%%
sst_region = sst(51:61,51:62,:);  
[X,Y]=meshgrid(lon(51:61),lat(51:62));%印度洋海区
[sst_region_ano,sst_region_mon] = remove_mons(sst_region,12);
[EOF_WA_sst,PC_WA_sst,G_EOFs_WA,num_WA_sst] = eof_lun(sst_region_ano,12);

% save('eof_sst.mat','Vr_sst','PC_sst');
%-------------------------作主要模态的时空分布图-----------------------------
%%
load color_lun.mat

figure(1);
position1 = [0.1 0.4 0.3 0.3];
position2 = [0.5 0.45 0.4 0.2];

% subplot('position',position1);
m_proj('miller','lon',[100 120],'lat',[-34 -12]);
m_contourf(X,Y,EOF_WA_sst(:,:,1)',50,'linestyle','none');
hold on;
% [C,h]=m_contour(X,Y,VR(:,:,1)');
% set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2);
m_plot([110 115],[-20 -20],'y','linewidth',2);
m_plot([110 115],[-28 -28],'y','linewidth',2);
m_plot([110 110],[-20 -28],'y','linewidth',2);
m_plot([115 115],[-20 -28],'y','linewidth',2);

caxis([0.5 1.5]);
colormap(color_lun1);
colorbar;
% ck=colorbar('vertical'); 
% set(ck,'Position',[0.93 0.18 0.02 0.65]);
m_coast('patch',[225 225 225]/255,'edgecolor','k','linewidth',1.5);
m_grid('linestyle','none','tickdir','out','linewidth',1.5);
title('The 1st mode of SSTa in the region of WA');
% 

% subplot('position',position2);
figure(2);
plot(tim,PC_WA_sst(:,1));
hold on
plot(tim,ER_NNI_ano);
axis([datenum('1850','yyyy') datenum('2020','yyyy') -3 3]);
yrs = [datenum('1850','yyyy'):367*10:datenum('2020','yyyy')];
xticks(yrs);
xticklabels(datestr(yrs,'yyyy'));
xlabel('Calendar year');
ylabel('SSTA (^{\circ}C)');
legend('PC1','NNI','location','southeast')
grid on;
set(gca,'linewidth',1.5);
set(gcf,'Position',[500,700,1000,300]);


load ('sst_data.mat','ER');
ER_index.PC1.ano = PC_WA_sst(:,1);
[ER_index.PC1.jd,ER_index.PC1.jdyrs] = annual_mean(ER_index.PC1.ano...
    ,ER.tim,12,1,12);


save('ER_index.mat','ER_index');