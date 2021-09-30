% ***************************************************************
% *** %Matlab function for quadratic Bazier basis
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
%%Matlab function for quadratic Bazier basis
function [x_data,y_data]=quad_Bazier(x,n)
    %input: n=number of data points
    %       x=control point parameters
    %output:
            %x_data= x coordinates
            %y_data= y coordinates
            
    t=linspace(0,1,n);
    %all b values for x_data
    bx0=x(1); bx1=x(2); bx2=x(3);
    
    %all b values for y_data
    by0=0; by1=x(4); by2=x(5); 
    
    x_data=bx0.*(1-t).^2+bx1.*2.*t.*(1-t)+bx2.*t.^2;
    y_data=by0.*(1-t).^2+by1.*2.*t.*(1-t)+by2.*t.^2;
end
