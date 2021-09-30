% ***************************************************************
% *** Matlab function for uncertainty apprisal for fault structure
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

%%Matlab Function for Fault inversion having given Density distribution
function [model,ccst,best_var,best_cost]=Fault_Invert_uncertainty(g_obs,x_obs,density,tol1,tol2)

    %% Input Parameters
    %data         =  gravity anomaly in mGal
    %x_obs        =  Horizontal location of oservation points 
    %z_obs        =  Vertical location of oservation points
    %y_span       =  span of y direction of the fault in meter
    %tol1         =  saving model data beyond this threshold
    %tol2         =  breaking the model;
    
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
    bc=0; %counter for saving model data having cost less than tol
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
        if BestCost(it)<tol1
            bc=bc+1; 
            x_m=GlobalBest.Position; 
            [xx_data,yy_data]=quad_Bazier(x_m,20);
            model(:,bc)=[xx_data';yy_data'];    %model parameters
            ccst(bc,1)=GlobalBest.Cost;        %cost for choosen model parameter
            fprintf('After %d iterations Best Cost Value= %.7f\n',bc,BestCost(it))  
        end
        %break the process if misfit achieved 0.01
        if BestCost(it)<tol2
            break
        end
        %best parameter values for the optimization
        best_var= (GlobalBest.Position)'; 
        best_cost= BestCost(it);
        
    end
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
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  