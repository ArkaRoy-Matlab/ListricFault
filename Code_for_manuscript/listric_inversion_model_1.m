% ***************************************************************
% *** Matlab code for optimizing Mode1 1 (Normal listric fault) having fixed density
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
data=importdata('listric_fault_grav_anomaly_model1.txt');
x_obs=data(:,1);       %observation points in m
g_obs=data(:,2);       %gravity anomalies in mGal
filename='error_energy_without_noise_model1.txt'; %file name for saving error energy
%Incorporating Gaussian noise
%g_obs=g_obs+sqrt(1.5).*randn(size(g_obs))+0; filename='error_energy_with_noise_model1.txt'; %file name for saving error energy
%finding orientation of fault
if abs(g_obs(1))>abs(g_obs(end))
    tf=-1;
else
    tf=1;
end
%plotting gravity anomaly data
figure(1)
subplot(2,1,1)
hold on
plot(x_obs,g_obs,'ro','linewidth',0.5)

%depth varying density distribution of the structure
density=@(z) -650+0.*z;

%t and c are Legendre Gaussian quadrature points for numerical integration
[t_leg,c_leg]=lgwt(10,0,1); 
    
%% Problem Definition
%%%%    Optimization of Model 1 (normal listric fault) using PSO     %%%%
c1=1.4; c2=1.7; 
            %Cost function with constraints for optimization
            CostFunction =@(x) myCostFunction(x,x_obs,g_obs,t_leg,c_leg,density)+1000*(constrained(x,x_obs)); 
            nVar=5;                %Number of Unknown Variables
            MaxIt = 500;           %Maximum number of iterations
            nPoP = 40;             %Population size or swarm size
            %Loop for 3 independent run
            cost_uncrtn=[]; var_uncrtn=[];
            for ii=1:3
                %Calling the function for optimization using PSO
                [bst_var, best_cost,iter_count,error_energy,tot_var,tot_cost] = WIPSO(CostFunction,nVar,MaxIt,nPoP,c1,c2);
                %Saving all best cost and parameters for each independent run 
                all_best(ii)=best_cost;
                all_var(:,ii)=bst_var;
                err_enrgy(:,ii)=error_energy';
                cost_uncrtn=[cost_uncrtn tot_cost];
                var_uncrtn=[var_uncrtn tot_var];
                %printing best cost after each iterations
                fprintf('best cost=%f\n',best_cost)
            end
            %finding best model 
            [val,id]=min(all_best);
            %Parameters for best Model 
            best_var=(squeeze(all_var(:,id)))';  
            %error energy for best model 
            best_error=(squeeze(err_enrgy(:,id)));
            
                %evaluating fault structures using Bazier polynomial
                [x_data,y_data]=quad_Bazier(best_var,20);
                %importing synthetic Model data points corresponding to the gravity anomaly
                listric_data=importdata('listric_fault_synthetic_model1.txt');
                xm=(listric_data(:,1))';
                ym=(listric_data(:,2))';
                %plotting the inverted fault structure
                subplot(2,1,2)
                hold on
                   if tf==1
                        %plotting the inverted fault structure using patched surface
                        p2=patch([x_data x_obs(end) x_obs(end) x_data(1)],[y_data y_data(end) y_data(1) y_data(1)],density([y_data y_data(end) y_data(1) y_data(1)]),'EdgeColor','none') ;
                        %plotting the synthetic fault structure using black dashed line
                        p1=plot([xm x_obs(end) x_obs(end) xm(1)],[ym ym(end) ym(1) ym(1)],'k--','linewidth',2);
                    else
                        %plotting the inverted fault structure using patched surface
                        p2=patch([x_data x_obs(1) x_obs(1) x_data(1)],[y_data y_data(end) y_data(1) y_data(1)],density([y_data y_data(end) y_data(1) y_data(1)]),'EdgeColor','none') ;
                        %plotting the synthetic fault structure using black dashed line
                        p1=plot([xm x_obs(1) x_obs(1) xm(1)],[ym ym(end) ym(1) ym(1)],'k--','linewidth',2);
                    end
                %colormap for the surface plot
                colormap hsv
                clim=[-1000 -400]; %colorbar axis limit in kg/m^3
                %positioning the color bar
                hp4 = get(subplot(2,1,2),'Position');
                c=colorbar('Position', [hp4(1)+hp4(3)+0.01  hp4(2)+0.03  0.015  .3]);
                %colorbar labelling
                c.Label.String = 'Density contrast (kg/m^3)';
                caxis(clim)
                set(c,'visible','off')
                box on
                %reversing the axis
                set(gca,'Ydir','reverse')   
                %axis limit 
                xlim([x_obs(1) x_obs(end)])
                ylim([0 5000])
                % drawing the legend
                hleg = legend([p1 p2],'location','northwest');
                % legend atributes
                hleg.String = {'Synthetic Model','Optimized Model'};
                %axis labelling
                xlabel('Horizontal distance (m)')
                ylabel('Depth (m)')
                %close polygonal form of depth profile 
                x1(1:length(x_data)+2)=[x_data tf*inf tf*inf];
                y1(1:length(y_data)+2)=[y_data y_data(end) y_data(1)];
                 %gravity field for optimized depth profile 
                 zz1=poly_gravityrho(x_obs,0,x1,y1,density,t_leg,c_leg);
                 %plotting optimized gravity anomaly profile
                 subplot(2,1,1)
                 hold on
                 plot(x_obs,zz1,'k')
                 %axis limit
                 xlim([x_obs(1) x_obs(end)])
                 legend('Synthetic data','Optimized data','location','northeast');
                 %axis labelling
                 xlabel('Horizontal distance (m)')
                 ylabel('Anomaly (mGal)')
                 box on   
 fprintf('\t For Model 1\n')
 %finding Frechet distance between sythetic and optimized data
 synth=[xm' ym']; optmzd=[x_data' y_data'];
 [cm, cSq] = DiscreteFrechetDist(synth,optmzd);
 fprintf('The Frechet distance between synthetic and optimized fault plane is %f m\n',cm)
 fprintf('Maximum optimized depth is %f m  and synthetic depth is %f m.\n',max(y_data),max(ym))
 
 %finding RMS error of  gravity anomaly
 rms_error=(norm(g_obs-zz1')/norm(g_obs))*100;
 fprintf('RMS error in gravity anomaly is %2.4e\n',rms_error)

%saving data for error energy
save(filename,'best_error','-ascii') % best_error is the error matrix 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%%    Objective functions and Constraints   %%%%
function val=myCostFunction(x,x_obs,g_obs,t_leg,c_leg,density)
     %%inputs are 
     %x= parameters for PSO algorithm
     %x_obs= observation points
     %g_obs= observed gravity field 
     %t_leg and c_leg are  Legendre Gaussian quadrature points for numerical integration
     % subroutine for t_leg and c_leg evaluation is given in lgwt.m file 
     %finding orientation of fault
        if abs(g_obs(1))>abs(g_obs(end))
            tf=-1;
        else
            tf=1;
        end
     [x_data,y_data]=quad_Bazier(x,20);
     %close polygonal form of depth profile 
     x1(1:length(x_data)+2)=[x_data tf*inf tf*inf];
     y1(1:length(y_data)+2)=[y_data y_data(end) y_data(1)];
     %gravity field for given depth profile 
     zz1=tf*poly_gravityrho(x_obs,0,x1,y1,density,t_leg,c_leg);
     %misfit functional for observed and inverted gravity anomaly
     val=(norm(g_obs'-zz1)./norm(g_obs'))*100;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
function val=constrained(x,x_obs)
    
%%inputs are 
     %x     =   parameters for PSO algorithm
     %x_obs =   observation points
%%output
     %val   =   penalty barrier method for minimum bound
        
     %all bounds for Bazier curve parameters
      min_x=min(x_obs); max_x=max(x_obs);
     gg1=(x(1)-max_x);
     gg2=(-x(1)+min_x);
     
     gg3=x(1)-x(2);
     gg8=x(2)-x(3);
     
     gg4=x(1)-x(3);
     gg5=x(3)-max_x;
     
     gg6=-x(4);
     gg7=-x(5);
     
     gg=[0 gg1 gg2 gg3 gg4 gg5 gg6 gg7 gg8];
     val=(max(gg))^2;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  