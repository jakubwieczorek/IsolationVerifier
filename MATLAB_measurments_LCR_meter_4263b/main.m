% Agile 4263B Hewlett Packard LCR Meter

% https://community.keysight.com/thread/36568
% https://www.keysight.com/en/pd-1000000850%3Aepsg%3Apro-pn-4263B/lcr-meter-100-hz-to-100-khz?pm=PL&nid=-32776.536879695&cc=CH&lc=ger
% http://na.support.keysight.com/vna/help/latest/Programming/Learning_about_GPIB/Understanding_Command_Synchronization.htm

clear all;

vs = configure(1);
pause(1)

minutes_amount = 30;

data = measure(vs, 60*minutes_amount);

%% close & delete
fclose(vs);
delete(vs);
clear vs;

%% plot
t = 0:(1/60):minutes_amount;
t = t(1:60*minutes_amount);

plot(t, data(1, :))
xlim([2 minutes_amount])
ylim([-10000 max(data(1, :))])
grid on
xlabel('t')
ylabel('R')

beep

%% legend
% *_x_y.mat
% * - name
% x - number of measurement
% y - configuration: 1 - sticked vertically in the middle
%                    2 - sticked horizontally up 
%                    3 - sticked horizontally down