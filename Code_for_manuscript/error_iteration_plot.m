% ***************************************************************
% *** Matlab code for rms error plot with iterations
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Mr. Rajat Kumar Sharma (email: rajat.sharma.mmm@gmail.com)
% ***       Solid Earth Research Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************
clear all
close all

%importing all error data for plotting
data1=importdata('error_energy_without_noise_model1.txt'); %importing data for model1 without noise
data2=importdata('error_energy_with_noise_model1.txt'); %importing data for model1 with noise
data3=importdata('error_energy_without_noise_model2.txt'); %importing data for model2 without noise
data4=importdata('error_energy_with_noise_model2.txt'); %importing data for model2 without noise

xx=1:length(data1);

figure(1)
semilogy(xx,data1,'linewidth',2)
hold on
semilogy(xx,data3,'linewidth',2)
xlabel('Number of time steps')
ylabel('rms error (mGal)')
legend('Model 1','Model 2')

figure(2)
semilogy(xx,data2,'linewidth',2)
hold on
semilogy(xx,data4,'linewidth',2)
xlabel('Number of time steps')
ylabel('rms error (mGal)')
legend('Model 1','Model 2')
