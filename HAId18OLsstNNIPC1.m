%The time series plot figure.
%In this figure, the bar is the Houtman Abora Island Site coral delta18O,
%the read line is the Local ERSST, the blue line is the NNI and the green 
%line is the first mode of EOF


clear;
close all;
clc;

%Input data
load ('localdata_annual.mat','Hou_data_annual');
load ('localdata.mat','Hou_data');
load ('ER_index.mat','ER_index');

%Name the data
A.a1.str = '\delta^{18}O';
A.a2.str = 'Local SST';
A.a3.str = 'NNI';
A.a4.str = 'PC1';
%A.a5.str = 'Nino3.4';

A.a1.dnum = Hou_data_annual.d18o.jdyrs;
A.a2.dnum = Hou_data_annual.sst_ER.jdyrs;
A.a3.dnum = ER_index.NNI.jdyrs;
A.a4.dnum = ER_index.NNI.jdyrs;
%A.a5.dnum = ER_index.NINO.jdyrs;

A.a1.dvec = datevec(A.a1.dnum);
A.a2.dvec = datevec(A.a2.dnum);
A.a3.dvec = datevec(A.a3.dnum);
A.a4.dvec = datevec(A.a4.dnum);
%A.a5.dvec = datevec(A.a8.dnum);

A.a1.data = Hou_data_annual.d18o.jd;
A.a2.data = Hou_data_annual.sst_ER.jd;
A.a3.data = ER_index.NNI.jd;
A.a4.data = ER_index.PC1.jd;
%A.a5.data = ER_index.NINO.jd;

A.a1.st = nandetrend(A.a1.data);
A.a2.st = nandetrend(A.a2.data);
A.a3.st = nandetrend(A.a3.data);
A.a4.st = nandetrend(A.a4.data);
%A.a5.st = nandetrend(A.a8.data);

stdd = zeros(4,1);
stdd(1) = nanstd(A.a1.st);
stdd(2) = nanstd(A.a2.st);
stdd(3) = nanstd(A.a3.st);
stdd(4) = nanstd(A.a4.st);
%stdd(5) = nanstd(A.a5.st);

A.a1.st = A.a1.st/stdd(1);
A.a2.st = A.a2.st/stdd(2);
A.a3.st = A.a3.st/stdd(3);
A.a4.st = A.a4.st/stdd(4);
%A.a5.st = A.a4.st/stdd(5);


figure(1);
bar(A.a1.dnum,-A.a1.st,'facecolor',[223,194,125]/255,'linestyle','none');
hold on
plot(A.a2.dnum,A.a2.st,...
     'color',[33,102,172]/255,'linewidth',1.5);
plot(A.a3.dnum,A.a3.st,...
     'color',[178,24,43]/255,'linewidth',1.5);
plot(A.a4.dnum,A.a4.st,...
     'color',[1,102,95]/255,'linewidth',1.5);

axis([datenum('1790','yyyy') datenum('2020','yyyy') -4 4]);
yrs = [datenum('1790','yyyy'):367*10:datenum('2020','yyyy')];
xticks(yrs);
xticklabels(datestr(yrs,'yyyy'));
xlabel('Calendar year');
legend(A.a1.str,A.a2.str,A.a3.str,A.a4.str,'location','southeast');
set(gca,'xticklabelrotation',30,'linewidth',1.5,'fontsize',12);
% grid on
set(gcf,'Position',[500,700,1000,300]);

