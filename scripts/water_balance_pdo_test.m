% 21 august 2023.


addpath('~/Research/general_scripts/matlabfunctions/')
normal_figure_startup

clear;
close all

load('../data_for_dsepulveda/CTD data/octdec2011/DC_ctds.mat')

figure
plot(tz_dc1,da_dc1), hold all;

figure
plot(da_dc1)


ix = 2500:450400; 

t = tl_dc1(ix); % local time. 
d = da_dc1(ix);


clearvars -except t d

figure
plot(t,d), datetick2('x')


subplot(2,1,1)
plot(t,d)

subplot(2,1,2)
plot(t,gradient(d')./gradient(t)); ylabel('change in height m/day')
title('instantaneous')

datetick2('x')



subplot(2,1,1)
plot(t,d)

subplot(2,1,2)
plot(t,gradient(d')./gradient(t)); ylabel('change in height m/day')
title('instantaneous')
datetick2('x')

N = 6*60*24; % samples per day.

%%

ixdrain = 1.25E5;


t = t(1:ixdrain);
d = d(1:ixdrain);

figure
plot(t,d)



p = polyfit(t,d,1);

%%


usgs_fn = '../data_for_dsepulveda/pescadero_chapter/raw_data/usgs/USGS_11162500_PESCADERO_dailydata_1951_2014_noheaders_commadelim.txt';

fid = fopen(usgs_fn);
% for i = 1:5
%     header = fgetl(fid);
% end

data = textscan(fid, '%s%s%s%f%s%f%s%f%s%f%s%f%s%s%s','Delimiter',',','EmptyValue',NaN);
fclose(fid)


% timeusgs = char(data{3});


for i = 1:length(data{3})
dayusgs(i) = datenum(data{3}(i),'yyyy-mm-dd');
end


%%

qm3s = 0.028316847*data{10};
qm3day = qm3s*(3600*24);


figure
subplot(211)
plot(dayusgs,data{10},'.--')
ylabel('daily mean streamflow (cfs)')
subplot(212)
plot(t,d), xl = xlim;

datetick2('x')
xlim(xl);


figure
subplot(211)
plot(dayusgs,qm3s,'.--')
ylabel('daily mean streamflow (m3/s)')
subplot(212)
plot(t,d), xl = xlim;

datetick2('x')
xlim(xl);


figure
subplot(211)
plot(dayusgs,qm3day,'.--')
ylabel('daily mean streamflow (m3/day)')
subplot(212)
plot(t,d), xl = xlim;

datetick2('x')
xlim(xl);


%%

tsec = t-t(1); % days, from 0.
tsec = tsec*3600*24;

figure
plot(tsec,d)


dd = [tsec',d];

addpath('~/Research/general_scripts/matlabfunctions/wavelet-coherence/')

[wave,period,scale,coi,sig95]=wt(dd,'MakeFigure',1);
[wave,period,scale,coi,sig95]=wt(d,'MakeFigure',1);
%%
figure
subplot(3,1,[1 2])
[wave,period,scale,coi,sig95]=wt(detrend(d(1:74989)),'MakeFigure',1);

subplot(3,1,3)
plot(t(1:74989),d(1:74989))


%%




% figure
% subplot(3,1,[1 2])
% [wave,period,scale,coi,sig95]=wt(detrend(dd(74989:end)),'MakeFigure',1);
% 
% subplot(3,1,3)
% plot(t(74989:end),d(74989:end))

% depth = d;

% make_wavelet(t',depth)

dd = dd(1:74989,:);
detrend_depth = dd(:,2);
detrend_depth = detrend(detrend_depth);
dd(:,2) = detrend_depth;
t = t(1:74989)';
t = tsec(1:74989);
s = size(t);
if s(2)>s(1)
    t = t';
end


% t = tt(:,1);
[wave,period,scale,coi,sig95]=wt(dd,'MakeFigure',0);
[d,dt]=formatts(dd);
sigma2=var(dd(:,2));
power = (abs(wave)).^2 ;        % compute wavelet power spectrum
H=imagesc(t,log2(period),log2(abs(power/sigma2))); %#ok,log2(levels));  %*** or use 'contourfill'
clim=get(gca,'clim'); %center color limits around log2(1)=0
clim=[-1 1]*max(clim(2),3);
set(gca,'clim',clim)
colormap(cbrewer('seq','YlGnBu',2^5))

Yticks = 2.^(fix(log2(min(period))):fix(log2(max(period))));

HCB=colorbar;
% set(HCB,'ytick',-7:7);
set(HCB,'ytick',-floor(clim(2)):2:floor(clim(2)));

barylbls=rats(2.^(get(HCB,'ytick')'));
barylbls([1 end],:)=' ';
barylbls(:,all(barylbls==' ',1))=[];
set(HCB,'yticklabel',barylbls);


set(gca,'YLim',log2([min(period),max(period)]), ...
    'YDir','reverse', ...
    'YTick',log2(Yticks(:)), ...
    'YTickLabel',num2str(Yticks'), ...
    'layer','top')
%xlabel('Time')
ylabel('Period')
hold on

disp('min period is: ')
disp(min(period))

disp('max period is: ')
disp(max(period))



[c,h] = contour(t,log2(period),sig95,[1 1],'k'); %#ok
set(h,'linewidth',2)
%plot(t,log2(coi),'k','linewidth',3)
% tt=[t([1 1])-dt*.5;t;t([end end])+dt*.5];
% hcoi=fill(tt,log2([period([end 1]) coi period([1 end])]),'w');
% set(hcoi,'alphadatamapping','direct','facealpha',.5)


% t_transp = t';
% t = t_transp;
tt=[t([1 1])-dt*.5;t;t([end end])+dt*.5];
hcoi=fill(tt,log2([period([end 1]) coi period([1 end])]),'w');
set(hcoi,'alphadatamapping','direct','facealpha',.5)

% hold off
% set(gca,'box','on','layer','top');



function [] = make_wavelet(tunif,Qunif)

d = [tunif;Qunif];

[wave,period,scale,coi,sig95]=wt(d,'MakeFigure',0);
[d,dt]=formatts(d);
t = tunif';
sigma2=var(Qunif);
power = (abs(wave)).^2 ;        % compute wavelet power spectrum

Yticks = 2.^(fix(log2(min(period))):fix(log2(max(period))));
% Yticks = [3/24 6/24 12/24 1 2 7 14 28];

% figure
H=imagesc(t,log2(period),log2(abs(power/sigma2))); %#ok,log2(levels));  %*** or use 'contourfill'
clim=get(gca,'clim'); %center color limits around log2(1)=0
clim=[-1 1]*max(clim(2),3);
set(gca,'clim',clim)
colormap(cbrewer('seq','YlGnBu',2^5))



HCB=colorbar;
% set(HCB,'ytick',-7:7);
set(HCB,'ytick',-floor(clim(2)):2:floor(clim(2)));

barylbls=rats(2.^(get(HCB,'ytick')'));
barylbls([1 end],:)=' ';
barylbls(:,all(barylbls==' ',1))=[];
set(HCB,'yticklabel',barylbls);


set(gca,'YLim',log2([min(period),max(period)]), ...
    'YDir','reverse', ...
    'YTick',log2(Yticks(:)), ...
    'YTickLabel',num2str(Yticks'), ...
    'layer','top')
%xlabel('Time')
ylabel('Period')
hold on

disp('min period is: ')
disp(min(period))

disp('max period is: ')
disp(max(period))

set(gca,'YTickLabel',{'3 h','6 h','12 h','1 d','2 d','7 d','14 d','28 d'})
% set(gca,'YLim',log2([2/24 max(period)])
set(gca,'YLim',log2([3/24,max(period)]), ...
    'YDir','reverse')

[c,h] = contour(t,log2(period),sig95,[1 1],'k'); %#ok
set(h,'linewidth',2)
%plot(t,log2(coi),'k','linewidth',3)
tt=[t([1 1])-dt*.5;t;t([end end])+dt*.5];
hcoi=fill(tt,log2([period([end 1]) coi period([1 end])]),'w');
set(hcoi,'alphadatamapping','direct','facealpha',.5)

hold off
set(gca,'box','on','layer','top');

datetick2('x')
end

