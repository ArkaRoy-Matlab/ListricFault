% ***************************************************************
% *** Help file for running all codes used in manuscript
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
This is a help file for a description of all Data, Source Code, and Subroutine used for the implementation of our present paper 
'Structure estimation of 2D listric faults using quadratic Bezier curve for depth varying density distributions'  

(Copy all set of files including data in one folder and run)

	1. Data Files
		a. listric_fault_grav_anomaly_model1
		b. listric_fault_grav_anomaly_model2
		c. listric_fault_synthetic_model1
		d. listric_fault_synthetic_model2
		e. grav_data_godaveri
		f. fault_data_godaveri
		g. error_energy_with_noise_model1
		h. error_energy_with_noise_model2
		i. error_energy_without_noise_model1
		j. error_energy_without_noise_model2
		k. model1_cost_counter
		l. model1_time_counter
		m. model2_cost_counter
		n. model2_time_counter
		

	File (a) contains synthetic gravity anomalies for model 1 for given density distributions.
	File (b) contains synthetic gravity anomalies for model 2 for given density distributions.

	file (c) contains data for synthetic listric fault structure for model 1.
	file (d) contains data for synthetic listric fault structure for model 2.
	
	file (e) contains observed gravity anomalies due to listric fault for Godavari sub basin. 
	file (f) contains listric fault structure obtained by Chakravarthi et al. 2017.

	files (g), (h), (i), (j) are the data file for error energy plot of model1 and model2 for noise-free and noisy data case.

	files (k), (l), (m), (n) are the data for iteration counts and time for parameter tuning of acceleration coefficients (c1, c2) and swarm populations. 
	 

	2. Subroutines
		a. lgwt.m
		b. quad_Bazier.m
		c. poly_gravityrho.m
		d. WIPSO.m
		e. Fault_Invert_uncertainty.m
		f. pca_reduction.m
		g. DiscreteFrechetDist.m

	a. lgwt.m - This script is for computing definite integrals using Legendre-Gauss 
 Quadrature. Computes the Legendre-Gauss nodes and weights  on an interval [a,b] with truncation order N. Suppose you have a continuous function f(x) which is defined on [a,b]
which you can evaluate at any x in [a,b]. Simply evaluate it at all of the values contained in the x vector to obtain a vector f. Then compute the definite integral using sum(f.*w);

	This code is written by Greg von Winckel - 02/25/2004. Here we have used it for our calculation and cited in main manuscript. 

	b. quad_Bazier.m - create Bezier curve basis for representing any curve by putting appropriate control point coefficients. 
		
	c. poly_gravityrho.m - poly_gravityrho function calculates z component of gravity field for any polygon shape 2d body having depth varying density contrast. This program based on line integral in anticlockwise direction using Gauss Legendre quadrature
%integral formula. For more detail go through Zhou 2008. It is same as poly_gravity function but for depth varying density contrast. 

	d. WIPSO.m - WIPSO calculates the optimized parameters (best_var) for a given objective function (CostFunction) using Particle Swarm Optimization.

	e. Fault_Invert_uncertainty.m - Main Matlab Function for Fault inversion having given Density distribution, observation points and corresponding gravity anomaly and used for uncertainty analysis.
	
	f. pca_reduction - Matlab function for principal component analysis and projecting actual data into pca space.

	g. DiscreteFrechetDist - function for calculating frechet distance between two curves. 
 
	
	3. Source Codes
		a. listric_inversion_model_1.m
		b. listric_inversion_model_2.m
\		c. listric_inversion_real.m
		d. model1_parameter_tunning.m
		e. model2_parameter_tunning.m
		f. model1_uncertainty.m
		g. model2_uncertainty.m
		h. plot_parameter_tune.m
		i. colorbar_plot.m
				
	a. listric_inversion_model_1.m- It calculates the inversion of gravity anomaly for a synthetic listric fault having constant density contrast with and without noise case (Model1) shown in figure 4. 

	b. listric_inversion_model_2.m- It calculates the inversion of gravity anomaly for a synthetic listric fault having exponential density contrast with and without noise case (Model2) shown in figure 4. 

	c. listric_inversion_real.m- It calculates the inversion of gravity anomaly for a real listric fault having exponential density contrast shown in figure 4. 

	d. model1_parameter_tunning.m- This code for Parameter tuning of PSO for acceleration coefficients (c1, c2) and nPoP for model 1.  Output of the code is shown in figure 5. 
 	
	e. model2_parameter_tunning.m- This code for Parameter tuning of PSO for acceleration coefficients (c1, c2) and nPoP for model 2.  Output of the code is shown in figure 5.  
 
	f. model1_uncertainty.m- It calculates the uncertainty appraisal for model 1 and plotting the error topography as shown in figure 7.
 
	g. model2_uncertainty.m- It calculates the uncertainty appraisal for model 2 and plotting the error topography as shown in figure 7. 

	h. plot_parameter_tune.m- It plots the stack plot for parameter tune data for both the models.

	i. colorbars.m - It plots all colorbars separately. 