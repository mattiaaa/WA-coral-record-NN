%读取数据
clear;close;clc;

path_sst.ER = '/Users/mattia/科研/ningaloo coral/data/SST/ERSST_v5.nc';
path_sst.IC = '/Users/mattia/科研/ningaloo coral/data/SST/ICODAS_sst.nc';
path_sst.HA = '/Users/mattia/科研/ningaloo coral/data/SST/HadISST_sst.nc';
path_sst.SO = '/Users/mattia/科研/ningaloo coral/data/SST/SODA_sst.nc';

path_coral.Nin_sst = '/Users/mattia/科研/ningaloo coral/data/row/zinke2015-ning-sst.txt';
path_coral.Nin_d18 = '/Users/mattia/科研/ningaloo coral/data/row/kuhnert2000-bimonth_noaa.txt';
path_coral.Hou_sst = '/Users/mattia/科研/ningaloo coral/data/row/zinke2015-hai-sst.txt';
path_coral.Hou_d18 = '/Users/mattia/科研/ningaloo coral/data/row/kuhnert1999-bimonth_noaa.txt';
path_coral.Nin_tnt = '/Users/mattia/科研/ningaloo coral/data/row/zinke2015-tnt.txt';
path_coral.Nin_bun = '/Users/mattia/科研/ningaloo coral/data/row/zinke2015-bun.txt';

ER.raw = ncread(path_sst.ER,'sst');
ER.raw(find(ER.raw < -100)) = nan;
ER.lat = ncread(path_sst.ER,'lat');
ER.lon = ncread(path_sst.ER,'lon');
ER.tim = ncread(path_sst.ER,'time');
ER.tim = double(ER.tim+datenum('1800-1-1 00:00:00','yyyy-mm-dd HH:MM:SS'));

IC.raw = ncread(path_sst.IC,'sst');
IC.raw(find(IC.raw == 32766)) = nan;
IC.lat = ncread(path_sst.IC,'lat');
IC.lon = ncread(path_sst.IC,'lon');
IC.tim = ncread(path_sst.IC,'time');
IC.tim = double(IC.tim+datenum('1800-1-1 00:00:00','yyyy-mm-dd HH:MM:SS'));

HA.raw = ncread(path_sst.HA,'sst');
HA.raw(find(HA.raw < -100)) = nan;
HA.lat = ncread(path_sst.HA,'latitude');
HA.lon = ncread(path_sst.HA,'longitude');
HA.tim = ncread(path_sst.HA,'time');
HA.tim = double(HA.tim+datenum('1870-1-1 00:00:00','yyyy-mm-dd HH:MM:SS'));

SO.raw = ncread(path_sst.SO,'TEMP');
SO.raw = squeeze(SO.raw(:,:,1,:));
SO.raw(find(SO.raw < -100)) = nan;
SO.lat = ncread(path_sst.SO,'LAT');
SO.lon = ncread(path_sst.SO,'LONN359_360');
SO.tim = ncread(path_sst.SO,'TIME');
SO.tim = double(SO.tim+datenum('0001-1-1 00:00:00','yyyy-mm-dd HH:MM:SS'));

Nin_sst_reco = load(path_coral.Nin_sst);
Nin_d18o = load(path_coral.Nin_d18);
Nin_tnt_SC = load(path_coral.Nin_tnt);
Nin_bun_SC = load(path_coral.Nin_bun);
Hou_sst_reco = load(path_coral.Hou_sst);
Hou_d18o = load(path_coral.Hou_d18);

Nin_data.sst_reco.rw = Nin_sst_reco(:,2);
Nin_data.sst_reco.tm = coral_date(Nin_sst_reco(:,1));

Nin_data.d18o.rw = Nin_d18o(:,3);
Nin_data.d18o.tm = coral_date(Nin_d18o(:,1));

Nin_data.tnt_SC.rw = Nin_tnt_SC(:,2)-nanmean(Nin_tnt_SC(:,2));
Nin_data.tnt_SC.tm = coral_date(Nin_tnt_SC(:,1));

Nin_data.bun_SC.rw = Nin_bun_SC(:,2)-nanmean(Nin_bun_SC(:,2));
Nin_data.bun_SC.tm = coral_date(Nin_bun_SC(:,1));



Nin_data.sst_ER.rw = squeeze(ER.raw(58,56,:));
Nin_data.sst_ER.tm = ER.tim;

Nin_data.sst_IC.rw = squeeze(IC.raw(57,56,:));
Nin_data.sst_IC.tm = IC.tim;

Nin_data.sst_HA.rw = squeeze(HA.raw(295,112,:));
Nin_data.sst_HA.tm = HA.tim;

Nin_data.sst_SO.rw = squeeze(SO.raw(589,108,:));
Nin_data.sst_SO.tm = SO.tim;

Hou_data.sst_reco.rw = Hou_sst_reco(:,2);
Hou_data.sst_reco.tm = coral_date(Hou_sst_reco(:,1));

Hou_data.d18o.rw = flipud(Hou_d18o(:,2));
Hou_data.d18o.tm = coral_date(flipud(Hou_d18o(:,1)));

Hou_data.sst_ER.rw = squeeze(ER.raw(58,59,:));
Hou_data.sst_ER.tm = ER.tim;

Hou_data.sst_IC.rw = squeeze(IC.raw(57,60,:));
Hou_data.sst_IC.tm = IC.tim;

Hou_data.sst_HA.rw = squeeze(HA.raw(294,119,:));
Hou_data.sst_HA.tm = HA.tim;

Hou_data.sst_SO.rw = squeeze(SO.raw(588,95,:));
Hou_data.sst_SO.tm = SO.tim;


save('localdata.mat','Nin_data','Hou_data');

