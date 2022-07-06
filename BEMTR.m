function fun = BEMTR(a,cl,cd,Alpha,segma_r,twist,lamda_r,theta_p)
phi = (atan((1-a(1))/((1+a(2))*lamda_r)))*180/pi;
alpha = phi - twist - theta_p;
Cl = interp1(Alpha,cl,alpha); 
Cd = interp1(Alpha,cd,alpha); 
%%
%Momentum theory
CP_M = (4*a(2)*(1-a(1)))*lamda_r^2;
CT_star=1.6;
a_star=1-0.5*sqrt(CT_star);
if a(1) < a_star
    CT_M = 4*a(1)*(1-a(1));
else
    CT_M = CT_star -4*(sqrt(CT_star)-1)*(1-a(1));
end
%%
%BE theory
cx = Cl*sin(phi*(pi/180)) - Cd*cos(phi*(pi/180));
cy = Cl*cos(phi*(pi/180)) + Cd*sin(phi*(pi/180));
CP_BE =  ((1-a(1))^2 + (lamda_r^2)*(1+a(2))^2)*segma_r*lamda_r*cx; 
CT_BE = ((1-a(1))^2 + (lamda_r^2)*(1+a(2))^2)*segma_r*cy; 

fun = [(CP_M - CP_BE);(CT_M - CT_BE)];
end