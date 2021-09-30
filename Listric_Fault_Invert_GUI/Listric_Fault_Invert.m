% ***************************************************************
% *** Matlab function for generalized listric fault model having variable density
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

function [x_data,y_data,rms_error,best_error,tf]=Listric_Fault_Invert(x_obs,g_obs,density,nPoP,c1,c2,MaxIt)
    
    %size of all data
    sz1=size(x_obs); sz2=size(g_obs);
    if sz1(1)<sz1(2)
        x_obs=x_obs';
    end
    if sz2(1)<sz2(2)
        g_obs=g_obs';
    end
    
    %finding orientation of fault
    if abs(g_obs(1))>abs(g_obs(end))
        tf=-1;
    else
        tf=1;
    end
    
    %t and c are Legendre Gaussian quadrature points for numerical integration
    [t_leg,c_leg]=lgwt(10,0,1); 

    %% Problem Definition
    %%%%    Optimization of listric faul using PSO     %%%%

                %Cost function with constraints for optimization
                CostFunction =@(x) myCostFunction(x,x_obs,g_obs,t_leg,c_leg,density)+1000*(constrained(x,x_obs)); 
                nVar=5;                %Number of Unknown Variables
                for ii=1:3
                    %Calling the function for optimization using PSO
                    [bst_var, best_cost,iter_count,error_energy,tot_var,tot_cost] = WIPSO(CostFunction,nVar,MaxIt,nPoP,c1,c2);
                    %Saving all best cost and parameters for each independent run 
                    all_best(ii)=best_cost;
                    all_var(:,ii)=bst_var;
                    err_enrgy(:,ii)=error_energy';
                end
                %finding best model 
                [val,id]=min(all_best);
                %Parameters for best Model 
                best_var=(squeeze(all_var(:,id)))';  
                %error energy for best model 
                best_error=(squeeze(err_enrgy(:,id)));
                    %evaluating fault structures using Bazier polynomial    
                    [x_data,y_data]=quad_Bazier(best_var,20);
                                        
                     %close polygonal form of depth profile 
                      x1(1:length(x_data)+2)=[x_data tf*inf tf*inf];
                      y1(1:length(y_data)+2)=[y_data y_data(end) y_data(1)];
                     %gravity field for given depth profile 
                     zz1=tf*poly_gravityrho(x_obs,0,x1,y1,density,t_leg,c_leg);
 
     %finding RMS error of  gravity anomaly
     rms_error=(norm(g_obs-zz1')/norm(g_obs))*100;
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
                tff=-1;
            else
                tff=1;
            end
         [x_ddata,y_ddata]=quad_Bazier(x,20);
         %close polygonal form of depth profile 
         xx1(1:length(x_ddata)+2)=[x_ddata tff*inf tff*inf];
         yy1(1:length(y_ddata)+2)=[y_ddata y_ddata(end) y_ddata(1)];
         %gravity field for given depth profile 
         zzz1=tff*poly_gravityrho(x_obs,0,xx1,yy1,density,t_leg,c_leg);
         %misfit functional for observed and inverted gravity anomaly
         val=(norm(g_obs'-zzz1)./norm(g_obs'))*100;
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
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 