% ***************************************************************
% *** Help file for running matlab gui ListricFaultInv
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***	    Mr. Rajat Kumar Sharma (email: rajat.sharma.mmm@gmail.com)
% ***       Solid Earth Research Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************
This is a help file for a description of all Data, Subroutine used for running gui named ListricFaultInv which is used in 
'Structure estimation of 2D listric faults using quadratic Bezier curve for depth varying density distributions'  


Subroutines:
		a. lgwt.m
		b. Listric_Fault_Invert.m
		c. poly_gravityrho.m
		d. WIPSO.m
		e. quad_Bazier.m
		f. ListricFaultInvPSO.m

	a. lgwt.m - This script is for computing definite integrals using Legendre-Gauss 
 Quadrature. Computes the Legendre-Gauss nodes and weights  on an interval [a,b] with truncation order N. Suppose you have a continuous function f(x) which is defined on [a,b]
which you can evaluate at any x in [a,b]. Simply evaluate it at all of the values contained in the x vector to obtain a vector f. Then compute the definite integral using sum(f.*w);

	This code is written by Greg von Winckel - 02/25/2004. Here we have used it for our calculation and cited in main manuscript. 
	
	b. Listric_Fault_Invert.m - Main Matlab Function for historic Fault inversion having given Density distribution, observation points and corresponding gravity anomaly.
	
	c. poly_gravityrho.m - poly_gravityrho function calculates z component of gravity field for any polygon shape 2d body having depth varying density contrast. This program based on line integral in anticlockwise direction using Gauss Legendre quadrature
%integral formula. For more detail go through Zhou 2008. It is same as poly_gravity function but for depth varying density contrast. 

	d. WIPSO.m - WIPSO calculates the optimized parameters (best_var) for a given objective function (CostFunction) using Particle Swarm Optimization.
	
	e. quad_Bazier.m - create Bezier curve basis for representing any curve by putting appropriate control point coefficients. 

	f. ListricFaultInvPSO.m is the main GUI file for inverting historic fault structures.

Text Data:
	
	a. x_obs_gui.txt
	b. gravity_gui.txt
 
Synthetic data points of observation points are saved in x_obs_gui.txt and corresponding gravity anomalies in gravity_gui.txt. 
	 
         