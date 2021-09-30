% ***************************************************************
% *** Matlab code for plotting parameter tunning data for both models
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

%all parameters for plotting stack plot
cc1=0.1:0.1:2.0; cc2=0.1:0.1:2.0;
ppop=10:10:100;
%gridding data for contour plot
[C1,C2]=meshgrid(cc1,cc2);

%importing all iteration data for both models
data1=importdata('model1_cost_counter.dat');
data2=importdata('model2_cost_counter.dat');

%loop for seperating data for diffrent popupation count
cnt=1; %counter for data
for ii=10:20:100
    
    model1=squeeze(data1(cnt,:,:));
    figure(1)
    hold on
    [~,h] = contourf(C1,C2,model1,10);   % plot contour at the bottom
    h.ContourZLevel = ppop(cnt);
    
    model2=squeeze(data2(cnt,:,:));
    figure(2)
    hold on
    [~,h] = contourf(C1,C2,model2,10);   % plot contour at the bottom
    h.ContourZLevel = ppop(cnt);
    
    cnt=cnt+2;
end
figure(1)
hold off
view(3);
box on
colormap cool
%c = colorbar('location','southoutside');
%c.Label.String = 'Number of time steps';
caxis([100 1000])
xlabel('C1')
ylabel('C2')
zlabel('Number of populations')

figure(2)
hold off
view(3);
box on
colormap cool
%c = colorbar('location','southoutside');
%c.Label.String = 'Number of time steps';
caxis([100 1000])
xlabel('C1')
ylabel('C2')
zlabel('Number of populations')