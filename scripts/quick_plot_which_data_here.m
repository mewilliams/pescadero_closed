addpath('~/Research/general_scripts/matlabfunctions/')

clear;
close all;


load('../data_for_dsepulveda/CTD data/octdec2011/DC_ctds.mat')
clearvars -except tl* da*

load('../data_for_dsepulveda/CTD data/octdec2011/AC_ctds.mat')
clearvars -except tl* da*

load('../data_for_dsepulveda/CTD data/octdec2011/NM_ctds.mat')
clearvars -except tl* da*
%%
figure
subplot(3,1,1)
plot(tl_dc1,da_dc1), hold all
plot(tl_dc2,da_dc2)
plot(tl_dc3,da_dc3)
plot(tl_dc4,da_dc4)
legend('1','2','3','4')
ylim([0 5])
title('DC')
ylabel({'sensor ','depth [m]'})


subplot(3,1,2)
plot(tl_ac1,da_ac1), hold all
plot(tl_ac2,da_ac2)
% plot(tl_dc3,da_dc3)
% plot(tl_dc4,da_dc4)
legend('1','2')
title('AC / ML')
ylabel({'sensor ','depth [m]'})


subplot(3,1,3)
plot(tl_nm1,da_nm1), hold all
% plot(tl_ac2,da_ac2)
% plot(tl_dc3,da_dc3)
% plot(tl_dc4,da_dc4)
legend('1')
title('NM')
ylabel({'sensor ','depth [m]'})

datetick2('x')

%%
clear all

load('../data_for_dsepulveda/CTD data/janmar2012/DC_ctds_fixed_gmt.mat')
load('../data_for_dsepulveda/CTD data/janmar2012/AC_ctds.mat')
load('../data_for_dsepulveda/CTD data/janmar2012/NM_ctds.mat')
load('../data_for_dsepulveda/CTD data/janmar2012/PC_ctds.mat')
load('../data_for_dsepulveda/CTD data/janmar2012/BC_ctds.mat')

whos
%%

figure
subplot(4,1,1)
plot(tl_dc1,da_dc1), hold all
plot(tl_dc2,da_dc2)
plot(tl_dc3,da_dc3)
plot(tl_dc4,da_dc4)
legend('DC1','DC2','DC3','DC4')
ylim([0 5])
title('DC')
ylabel({'sensor ','depth [m]'})


subplot(4,1,2)
plot(tl_ac1,da_ac1), hold all
plot(tl_ac2,da_ac2)
% plot(tl_dc3,da_dc3)
% plot(tl_dc4,da_dc4)
legend('ML1','ML2','ML3')
title('AC / ML')
ylabel({'sensor ','depth [m]'})


subplot(4,1,3)
plot(tl_nm1,da_nm1), hold all
plot(tl_nm2,da_nm2)
plot(tl_nm3,da_nm3)
% plot(tl_ac2,da_ac2)
% plot(tl_dc3,da_dc3)
% plot(tl_dc4,da_dc4)
legend('NM1','NM2','NM3')
title('NM')
ylabel({'sensor ','depth [m]'})



subplot(4,1,4)
plot(tl_bc,da_bc), hold all
plot(tl_pc,da_pc), hold all

% plot(tl_ac2,da_ac2)
% plot(tl_dc3,da_dc3)
% plot(tl_dc4,da_dc4)
legend('BC','PC')
title('NM')
ylabel({'sensor ','depth [m]'})

datetick2('x')



