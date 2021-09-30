% ***************************************************************
% *** Matlab code for parameter tunning for Mode1 2 (Reverse listric fault) having fixed density
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

%importing synthetic gravity anomaly data for Model 2
data=importdata('listric_fault_grav_anomaly_model2.txt');
x_obs=data(:,1);       %observation points in m
g_obs=data(:,2);       %gravity anomalies in mGal

%Incorporating Gaussian noise
%g_obs=g_obs+sqrt(1.5).*randn(size(g_obs))+0; filename='error_energy_with_noise_model1.txt'; %file name for saving error energy
%finding orientation of fault
if abs(g_obs(1))>abs(g_obs(end))
    tf=-1;
else
    tf=1;
end

%depth varying density distribution of the structure
density=@(z) (-0.4-0.5*exp(-0.5*z*10^-3))*1000;

%t and c are Legendre Gaussian quadrature points for numerical integration
[t_leg,c_leg]=lgwt(10,0,1); 

%% all parameters for finding minimum costs
cc1=0.1:0.1:2.0; cc2=0.1:0.1:2.0;
ppop=10:10:100;

%loop for c1
for ip=1:length(ppop)
    for ic1=1:length(cc1)
        for ic2=1:length(cc2)
        
%% Problem Definition
%%%%    Optimization of Model 1 (normal listric fault) using PSO     %%%%
            c1=cc1(ic1); c2=cc2(ic2); 
            %Cost function with constraints for optimization
            CostFunction =@(x) myCostFunction(x,x_obs,g_obs,t_leg,c_leg,density)+1000*(constrained(x,x_obs)); 
            nVar=5;                %Number of Unknown Variables
            MaxIt = 1000;           %Maximum number of iterations
            nPoP = ppop(ip);       %Population size or swarm size
            
            for ii=1:3
                %Calling the function for optimization using PSO
                tic
                [bst_var, best_cost,iter_count,error_energy,tot_var,tot_cost] = WIPSO_spl(CostFunction,nVar,MaxIt,nPoP,c1,c2);
                tmmm(ii)=toc;
                %Saving all best cost and parameters for each independent run 
                all_best(ii)=best_cost;
                all_var(:,ii)=bst_var;
                
                counter(ii)=iter_count;
                %printing best cost after each iterations
                %fprintf('best cost=%f\n',best_cost)
            end
            %finding best model 
            [val,id]=min(all_best);
            %Parameters for best Model 
            best_var=(squeeze(all_var(:,id)))';  
            cost_counter(ip,ic1,ic2)=counter(id);
            time_span(ip,ic1,ic2)=tmmm(id);
            fprintf('For npop=%d, c1=%2.2f, c2=%2.2f, iteration=%d and time =%f\n',nPoP,c1,c2,counter(id),tmmm(id))
        end
    end
end
save model2_cost_counter.dat cost_counter               
save model2_time_counter.dat time_span

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
function [best_var, best_cost,iter_count,error_energy,all_var,all_cost]  = WIPSO_spl(CostFunction,nVar,MaxIt,nPoP,c1,c2)
	% WIPSO calculates the optimized parameters (best_var) for a given objective function (CostFunction)
	% using Particle Swarm Optimization.
%Inputs
%	Costfunction = Objective function of the optimization problem
%	nVar		 = Number of parameters of the optimization problem
%   Maxit		 = Maximum Generations for PSO 	
%	nPoP		 = Number of particles of the swarm in PSO
%	c1           = cognitive component of PSO
%	c2           = social component of PSO
%   all_var      = all variables at each iterations
%   all_cost     = cost in each iterations

%Outputs 
%best_var		= optimized parameters for PSO
%best_cost		= value of objective function for optimized parameters
%iter_count		= required number of generations for optimization
%error_energy   = Error energy after each generations. 
	
    VarSize = [1 nVar];     %Matrix size of Decision variables
    VarMin= -ones(1,nVar);          %Lower Bound of Unknown variable
    VarMax= ones(1,nVar);           %Upper Bound of Unknown variable

    %% Parameters of PSO
    w_min=0.1; w_max=0.9;                     %inertia coefficient
         
    %% Initialization
    Empty.Particle.Position =[];
    Empty.Particle.Velocity =[];
    Empty.Particle.Cost     =[];

    Empty.Particle.Best.Position =[];
    Empty.Particle.Best.Cost     =[];

    Particle=repmat(Empty.Particle, nPoP,1);

    %initial global best
    GlobalBest.Cost= Inf;
    for i=1:nPoP
        %initialize position with random number from VarMin and VarMax
        for j=1:nVar
            Particle(i).Position(j) =(VarMax(j)-VarMin(j))*rand(1) + VarMin(j);
        end
        %Initialize Velocity
        Particle(i).Velocity =zeros(VarSize);
        %checking cost function value
        Particle(i).Cost = CostFunction(Particle(i).Position);
        %update personal best
        Particle(i).Best.Position =Particle(i).Position;
        Particle(i).Best.Cost =Particle(i).Cost;
        %Update global best
        if Particle(i).Best.Cost < GlobalBest.Cost
            GlobalBest= Particle(i).Best;
        end
    end

    %Best cost value in each iterations
    BestCost=zeros(MaxIt,1);

    %%  Main loop of PSO
%loop for each time steps 
    for it=1: MaxIt
        w=w_max-((w_max-w_min)/MaxIt)*it;
        %loop for all particles of the swarm
        for i=1:nPoP
            %Update Velocity
            Particle(i).Velocity= (w).*Particle(i).Velocity+ ...
                c1*rand(VarSize).*(Particle(i).Best.Position-Particle(i).Position) ...
                + c2*rand(VarSize).*(GlobalBest.Position-Particle(i).Position);
            %Update Position
            Particle(i).Position=Particle(i).Position+Particle(i).Velocity;
            %cost for this iteration
            Particle(i).Cost = CostFunction(Particle(i).Position);
            %Update Personal Best
            if Particle(i).Cost < Particle(i).Best.Cost
                Particle(i).Best.Position =Particle(i).Position;
                Particle(i).Best.Cost =Particle(i).Cost;
                %Update Global Best
                if Particle(i).Best.Cost < GlobalBest.Cost
                    GlobalBest= Particle(i).Best;
                end
            end
        end
        %Display iteration information
        %Store Best Cost value
        BestCost(it)=GlobalBest.Cost;
        BestVar(it,:)=GlobalBest.Position;
        %break the process if misfit achieved 0.01
        if BestCost(it)<10^-2
            break
        end
        %printing the cost after each iterations 
        %fprintf('After %d iterations Best Cost Value= %.7f\n',it,BestCost(it))  
        %value for error energy plot
        error_energy(it)=(BestCost(it)).^2;
    end
    %best parameter values for the optimization
        best_var= (GlobalBest.Position)'; 
        best_cost= BestCost(it);
        iter_count= it; 
        all_var=BestVar';
        all_cost=BestCost';
end