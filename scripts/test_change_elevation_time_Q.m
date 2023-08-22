

clear
close all;

load('../data_for_dsepulveda/CTD data/octdec2011/AC_ctds.mat')
d = da_ac1; 
t = tz_ac1;
clearvars -except t d

% d(d<0.2) = NaN;

figure
plot(t,d)

% d = da_nm1; 

ix = 400:9E4;
t = t(ix);
d = d(ix);

hold all
plot(t,d)


d_movmed = movmedian(d,350);

plot(t,d_movmed)

%%
figure
subplot(211)
plot(t,d_movmed)

subplot(212)
plot(t(1440/2:89601-1440/2),d_movmed(1440:end)-d_movmed(1:end-1440+1))
datetick2('x','keeplimits')

%%

load ../external_data/usgs_pescadero_2009_2013_inst.mat

figure
subplot(311)
plot(t,d_movmed)

subplot(312)
plot(t(1440/2:89601-1440/2),d_movmed(1440:end)-d_movmed(1:end-1440+1))
datetick2('x','keeplimits')

xl = xlim;

subplot(313)
plot(t_usgs_gmt,Q_cfs)

Q_m3s = Q_cfs./35.31468492;


%%

t_delta = t(1440/2:89601-1440/2);
delta_d = d_movmed(1440:end)-d_movmed(1:end-1440+1);
Qm3s_tdelta = interp1(t_usgs_gmt,Q_m3s,t_delta);
        
figure
subplot(311)
% plot(t(1440/2:89601-1440/2),d_movmed(1440:end)-d_movmed(1:end-1440+1))
plot(t_delta,delta_d)
datetick2('x','keeplimits')

subplot(312)
plot(t_usgs_gmt,Q_m3s)
% 
% subplot(313)
% plot(t_delta,Qm3s_tdelta./delta_d')

subplot(313)
plot(t_delta,Qm3s_tdelta./delta_d')





