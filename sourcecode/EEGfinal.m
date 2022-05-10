

%% File Reading
clc
close all
t = tcpclient('127.0.0.1',5152)
data = transpose(read(t, 17920, 'double'));
Fs = 256;
%% Picking Channels from the table Normal and Fatigue
OO1  = data; %Normal
%% Fitting of Channels to an Array
channels  = OO1;
%% Storing channel names as string in array
tmp_name = ['Normale';'Fatigue';];
name = cellstr(tmp_name);
N = length(OO1);

%% Smoothing of Signal                        
name = cellstr(tmp_name);
tmp_signal = medfilt1(channels,5); 
signal = tmp_signal; 

%% Here we compare our preprocessed signal 
which_channel = channels;
which_signal = signal;
%%                              Digital filtering
%% Creating Filters
Delta_filter = designfilt('lowpassiir','FilterOrder',8,'PassbandFrequency',4,'PassbandRipple',0.2, 'SampleRate',Fs);
Theta_filter = designfilt('bandpassiir', 'FilterOrder', 20, 'PassbandFrequency1', 4,'PassbandFrequency2',8,'PassbandRipple',1,'SampleRate', Fs);
Alpha_filter = designfilt('bandpassiir', 'FilterOrder', 20, 'PassbandFrequency1', 8,'PassbandFrequency2',12,'PassbandRipple',1,'SampleRate', Fs);
Beta_filter = designfilt('bandpassiir', 'FilterOrder', 20, 'PassbandFrequency1', 12,'PassbandFrequency2',25,'PassbandRipple',1,'SampleRate', Fs);
Gamma_filter = designfilt('bandpassiir', 'FilterOrder', 20, 'PassbandFrequency1', 25,'PassbandFrequency2',45,'PassbandRipple',1,'SampleRate', Fs);
%% Applying Filter
 a = 0.0025;
 b = 70;
delta = filter(Delta_filter,signal);
theta = filter(Theta_filter,signal);
alpha = filter(Alpha_filter,signal); 
beta  = filter(Beta_filter,signal);
gamma = filter(Gamma_filter,signal);
%% Power
which_alpha = alpha;
which_beta =  beta;
which_delta = delta;
which_theta = theta;
 
% Square functions to get power of signal
p_alpha = which_alpha.^2;
p_beta =  which_beta.^2;
p_delta = which_delta.^2;
p_theta = which_theta.^2;
% Sum power over time (1 second) to get energy of signal per second
n = (N/Fs);
Ts = (1:n);
 w_alpha = sum(reshape(p_alpha,Fs,n));
 w_beta = sum(reshape(p_beta,Fs,n));
 w_delta= sum(reshape(p_delta,Fs,n));
 w_theta = sum(reshape(p_theta,Fs,n));

 ydb = transpose(pow2db(w_delta));
 yab = transpose(pow2db(w_alpha));
 ybd = transpose(pow2db(w_beta));
 ytb = transpose(pow2db(w_theta));
 
%% Data Standardizing  
 Stand_delta = (ydb - mean(ydb))/std(ydb);
ydb = Stand_delta;
Stand_alpha = (yab - mean(yab))/std(yab);
yab = Stand_alpha;
Stand_theta = (ytb - mean(ytb))/std(ytb);
ytb = Stand_theta;
empty = cell(70,1);
pred = table([ydb], [ytb], [yab] ,[empty]);
pred.Properties.VariableNames = {'x___Deltadb' 'Thetadb' 'Alphadb' 'State'};
 mdl = fitcknn(prepocesseddata,'State');
 yfit3 = mdl.predict(pred)

%  yfit3 = mdl.predictFcn(pred)
