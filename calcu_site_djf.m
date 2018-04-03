close;clear;clc;

%%load data
load sst_data
load localdata
path_sst.SO = '/Users/mattia/科研/ningaloo coral/data/SST/SODA_sst.nc';
SO.raw = ncread(path_sst.SO,'TEMP');
SO.raw = squeeze(SO.raw(:,:,1,:));
SO.raw(find(SO.raw < -100)) = nan;
SO.lat = ncread(path_sst.SO,'LAT');
SO.lon = ncread(path_sst.SO,'LONN359_360');
SO.tim = ncread(path_sst.SO,'TIME');

%%
%对数据进行距平处理（去除气候态度月平均）
%1 时间序列数据（Nin/Hou）距平标准化
Nin_data_ano.d18o = remove_mons(Nin_data.d18o.rw,6);
Nin_data_ano.sst_ER = remove_mons(Nin_data.sst_ER.rw,12);
Nin_data_ano.sst_IC = remove_mons(Nin_data.sst_IC.rw,12);
Nin_data_ano.sst_HA = remove_mons(Nin_data.sst_HA.rw,12);
Nin_data_ano.sst_SO = remove_mons(Nin_data.sst_SO.rw,12);

Hou_data_ano.d18o = remove_mons(Hou_data.d18o.rw,6);
Hou_data_ano.sst_ER = remove_mons(Hou_data.sst_ER.rw,12);
Hou_data_ano.sst_IC = remove_mons(Hou_data.sst_IC.rw,12);
Hou_data_ano.sst_HA = remove_mons(Hou_data.sst_HA.rw,12);
Hou_data_ano.sst_SO = remove_mons(Hou_data.sst_SO.rw,12);

%2 进行DJF年数据处理
[Nin_data_annual.d18o.djf,Nin_data_annual.d18o.yrs] = annual_mean(...
    Nin_data_ano.d18o,Nin_data.d18o.tm,6,12,2);
[Nin_data_annual.sst_ER.djf,Nin_data_annual.sst_ER.yrs] = annual_mean(...
    Nin_data_ano.sst_ER,Nin_data.sst_ER.tm,12,12,2);
[Nin_data_annual.sst_IC.djf,Nin_data_annual.sst_IC.yrs] = annual_mean(...
    Nin_data_ano.sst_IC,Nin_data.sst_IC.tm,12,12,2);
[Nin_data_annual.sst_HA.djf,Nin_data_annual.sst_HA.yrs] = annual_mean(...
    Nin_data_ano.sst_HA,Nin_data.sst_HA.tm,12,12,2);
[Nin_data_annual.sst_SO.djf,Nin_data_annual.sst_SO.yrs] = annual_mean(...
    Nin_data_ano.sst_SO,Nin_data.sst_SO.tm,12,12,2);

[Hou_data_annual.d18o.djf,Hou_data_annual.d18o.yrs] = annual_mean(...
    Hou_data_ano.d18o,Hou_data.d18o.tm,6,12,2);
[Hou_data_annual.sst_ER.djf,Hou_data_annual.sst_ER.yrs] = annual_mean(...
    Hou_data_ano.sst_ER,Hou_data.sst_ER.tm,12,12,2);
[Hou_data_annual.sst_IC.djf,Hou_data_annual.sst_IC.yrs] = annual_mean(...
    Hou_data_ano.sst_IC,Hou_data.sst_IC.tm,12,12,2);
[Hou_data_annual.sst_HA.djf,Hou_data_annual.sst_HA.yrs] = annual_mean(...
    Hou_data_ano.sst_HA,Hou_data.sst_HA.tm,12,12,2);
[Hou_data_annual.sst_SO.djf,Hou_data_annual.sst_SO.yrs] = annual_mean(...
    Hou_data_ano.sst_SO,Hou_data.sst_SO.tm,12,12,2);
%%
[Nin_data_annual.d18o.jd,Nin_data_annual.d18o.jdyrs] = annual_mean(...
    Nin_data_ano.d18o,Nin_data.d18o.tm,6,2,12);
[Nin_data_annual.sst_ER.jd,Nin_data_annual.sst_ER.jdyrs] = annual_mean(...
    Nin_data_ano.sst_ER,Nin_data.sst_ER.tm,12,1,12);
[Nin_data_annual.sst_IC.jd,Nin_data_annual.sst_IC.jdyrs] = annual_mean(...
    Nin_data_ano.sst_IC,Nin_data.sst_IC.tm,12,1,12);
[Nin_data_annual.sst_HA.jd,Nin_data_annual.sst_HA.jdyrs] = annual_mean(...
    Nin_data_ano.sst_HA,Nin_data.sst_HA.tm,12,1,12);
[Nin_data_annual.sst_SO.jd,Nin_data_annual.sst_SO.jdyrs] = annual_mean(...
    Nin_data_ano.sst_SO,Nin_data.sst_SO.tm,12,1,12);

[Hou_data_annual.d18o.jd,Hou_data_annual.d18o.jdyrs] = annual_mean(...
    Hou_data_ano.d18o,Hou_data.d18o.tm,6,2,12);
[Hou_data_annual.sst_ER.jd,Hou_data_annual.sst_ER.jdyrs] = annual_mean(...
    Hou_data_ano.sst_ER,Hou_data.sst_ER.tm,12,1,12);
[Hou_data_annual.sst_IC.jd,Hou_data_annual.sst_IC.jdyrs] = annual_mean(...
    Hou_data_ano.sst_IC,Hou_data.sst_IC.tm,12,1,12);
[Hou_data_annual.sst_HA.jd,Hou_data_annual.sst_HA.jdyrs] = annual_mean(...
    Hou_data_ano.sst_HA,Hou_data.sst_HA.tm,12,1,12);
[Hou_data_annual.sst_SO.jd,Hou_data_annual.sst_SO.jdyrs] = annual_mean(...
    Hou_data_ano.sst_SO,Hou_data.sst_SO.tm,12,1,12);

save('localdata_annual.mat','Hou_data_annual','Nin_data_annual');