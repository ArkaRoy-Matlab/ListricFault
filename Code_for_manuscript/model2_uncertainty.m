% ***************************************************************
% *** Matlab for uncertainty appraisal for Model 2
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

%importing synthetic gravity anomaly data for Model 1
data=importdata('listric_fault_grav_anomaly_model2.txt');
x_obs=data(:,1);       %observation points in m
g_obs=data(:,2);       %gravity anomalies in mGal

%Incorporating Gaussian noise
%g_obs=g_obs+sqrt(1.5).*randn(size(g_obs))+0; 

%depth varying density distribution of the structure
density=@(z) (-0.4-0.5*exp(-0.5*z*10^-3))*1000;

%finding orientation of fault
        if abs(g_obs(1))>abs(g_obs(end))
            tf=-1;
        else
            tf=1;
        end
%t and c are Legendre Gaussian quadrature points for numerical integration
    [t_leg,c_leg]=lgwt(10,0,1); 
%% Problem Definition for noise free data
    tol1=0.2*10^2;
    tol2=0.2*10^-5;
    %loop for 5 independent run
    for ii=1:5
        [model,ccst,best_var,best_cost]=Fault_Invert_uncertainty(g_obs,x_obs,density,tol1,tol2);
         my_field1 = strcat('model',num2str(ii));
         variable.(my_field1) = model;
         my_field2 = strcat('cost',num2str(ii));
         variable.(my_field2) =ccst;
         bbst_ccst(ii)=best_cost;      
    end
    %finding minimum out of 3 independent run
    [v,p]=min(bbst_ccst);
    model=variable.(strcat('model',num2str(p)));
    ccst=variable.(strcat('cost',num2str(p)));
    best_cost=v;
    
    [pc,Evalues,W] =pca_reduction(model);
    %plot PCA space of the first two PCs: PC1 and PC2
    %plot(pc(1,:),pc(2,:),'.')  
      
     %plotting error topography
     x=pc(1,:); y=pc(2,:);
     [xq,yq] = meshgrid(min(x):10:max(x), min(y):10:max(y));
     vq = griddata(x,y,ccst,xq,yq);
     figure(1)
     subplot(2,1,1)
     %contour plot
     contourf(xq,yq,vq,10)
     colormap jet
     colorbar
     best_model=model(:,end);
     %importing synthetic Model data points corresponding to the gravity anomaly
     listric_data=importdata('listric_fault_synthetic_model2.txt');
     xm=(listric_data(:,1));
     ym=(listric_data(:,2));
     true_model=[xm;spline(xm,ym,best_model(1:20))];
     
     %close polygonal form of depth profile 
                x1(1:length(xm)+2)=[xm' tf*inf tf*inf];
                y1(1:length(xm)+2)=[ym' ym(end) ym(1)];
                 %gravity field for optimized depth profile 
                 g_obs1=tf*poly_gravityrho(x_obs,0,x1,y1,density,t_leg,c_leg);
                 
     %cost for true model
     true_cost=(norm(g_obs-g_obs1')./norm(g_obs))*100;
     %location of true model and best model in pca plane
     loc_best_model=W*(best_model-mean(model,2));
     loc_true_model=W*(true_model-mean(model,2));
     %Plotting true model and best model in pca plane
     hold on
     plot(loc_best_model(1),loc_best_model(2),'r^','linewidth',4)
     plot(loc_true_model(1),loc_true_model(2),'gv','linewidth',4)
     %Axis labelling
     xlabel('Principal component 1')
     ylabel('Principal component 2')
     %title('Relative Misfit in PCA space(Normal Fault), noise free data ')
     lg1=sprintf('Equivalence function topography (in %%)');
     lg2=sprintf('Best model (relative misfit %2.2f%%)',best_cost);
     lg3=sprintf('True model (relative misfit %2.2f%%)',true_cost);
     legend(lg1,lg2,lg3,'location','best')
     
     %printing the result
     fprintf('For noise free problem\n')
     fprintf('\tRelative misfit for Best model=%f\n',best_cost)
     fprintf('\tRelative misfit for True model=%f\n',true_cost)
     
clear all

%importing synthetic gravity anomaly data for Model 2
data=importdata('listric_fault_grav_anomaly_model2.txt');
x_obs=data(:,1);       %observation points in m
g_obs=data(:,2);       %gravity anomalies in mGal

%Incorporating Gaussian noise
g_obs=g_obs+sqrt(2).*randn(size(g_obs))+0;

%depth varying density distribution of the structure
density=@(z) (-0.4-0.5*exp(-0.5*z*10^-3))*1000;

%finding orientation of fault
        if abs(g_obs(1))>abs(g_obs(end))
            tf=-1;
        else
            tf=1;
        end
%t and c are Legendre Gaussian quadrature points for numerical integration
    [t_leg,c_leg]=lgwt(10,0,1); 
%% Problem Definition for noise free data
    tol1=0.2*10^2;
    tol2=0.2*10^-5;
    %loop for 5 independent run
    for ii=1:5
        [model,ccst,best_var,best_cost]=Fault_Invert_uncertainty(g_obs,x_obs,density,tol1,tol2);
         my_field1 = strcat('model',num2str(ii));
         variable.(my_field1) = model;
         my_field2 = strcat('cost',num2str(ii));
         variable.(my_field2) =ccst;
         bbst_ccst(ii)=best_cost;      
    end
    %finding minimum out of 3 independent run
    [v,p]=min(bbst_ccst);
    model=variable.(strcat('model',num2str(p)));
    ccst=variable.(strcat('cost',num2str(p)));
    best_cost=v;
    
    [pc,Evalues,W] =pca_reduction(model);
    %plot PCA space of the first two PCs: PC1 and PC2
    %plot(pc(1,:),pc(2,:),'.')  
      
     %plotting error topography
     x=pc(1,:); y=pc(2,:);
     [xq,yq] = meshgrid(min(x):10:max(x), min(y):10:max(y));
     vq = griddata(x,y,ccst,xq,yq);
     figure(1)
     subplot(2,1,2)
     %contour plot
     contourf(xq,yq,vq,10)
     colormap jet
     colorbar
     best_model=model(:,end);
     %importing synthetic Model data points corresponding to the gravity anomaly
     listric_data=importdata('listric_fault_synthetic_model2.txt');
     xm=(listric_data(:,1));
     ym=(listric_data(:,2));
     true_model=[xm;spline(xm,ym,best_model(1:20))];
     
     %close polygonal form of depth profile 
                x1(1:length(xm)+2)=[xm' tf*inf tf*inf];
                y1(1:length(xm)+2)=[ym' ym(end) ym(1)];
                 %gravity field for optimized depth profile 
                 g_obs1=tf*poly_gravityrho(x_obs,0,x1,y1,density,t_leg,c_leg);
                 
     %cost for true model
     true_cost=(norm(g_obs-g_obs1')./norm(g_obs))*100;
     %location of true model and best model in pca plane
     loc_best_model=W*(best_model-mean(model,2));
     loc_true_model=W*(true_model-mean(model,2));
     %Plotting true model and best model in pca plane
     hold on
     plot(loc_best_model(1),loc_best_model(2),'r^','linewidth',4)
     plot(loc_true_model(1),loc_true_model(2),'gv','linewidth',4)
     %Axis labelling
     xlabel('Principal component 1')
     ylabel('Principal component 2')
     %title('Relative Misfit in PCA space(Normal Fault), noise free data ')
     lg1=sprintf('Equivalence function topography (in %%)');
     lg2=sprintf('Best model (relative misfit %2.2f%%)',best_cost);
     lg3=sprintf('True model (relative misfit %2.2f%%)',true_cost);
     legend(lg1,lg2,lg3,'location','best')
     
     %printing the result
     fprintf('For noise incorporated problem\n')
     fprintf('\tRelative misfit for Best model=%f\n',best_cost)
     fprintf('\tRelative misfit for True model=%f\n',true_cost)