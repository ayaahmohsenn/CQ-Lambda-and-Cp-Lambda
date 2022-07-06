clear;
clc;
%%
%%Defining constants
N = 2;                         %No. of blades
R = 20;                        %Blade Length
Uinf=8;                        %%the wind speed
rho=1.225;                     %%Density
Omega=40*2*pi/60;              %rad/s
a0=[0.1 0.1];                  %intial condition for axial and tangential induction factors
twistangle=27;                 %%Total Twist angle
s = 1:15;                      %%Range of Lamdas
redius = 0.25:0.25:20;         %devisions of the blade
n = 0;
MaxCp=0;
w=0;
W=0;
%%
% *The data for alpha, CL, and Cd after the exterpolation using XFOIL and
%%airfoil prep*
alpha = table2array(readtable('Book1.xlsx','Range','A1:A73'));
cl = table2array(readtable('Book1.xlsx','Range','B1:B73'));
cd = table2array(readtable('Book1.xlsx','Range','C1:C73'));
%%
%%First for loop excuting around different pitch angles
for theta_p = [-14 -9 -4 0 5]
    n = n + 1;
    %%second for loop excuting around different lamdas
    for tipspeed = 1:15
        x=[];
        i=0;
        %%third for loop around the blade redius
        for r = redius
            mio=r/R;
            i=i+1;
            lamda_r = tipspeed*mio;
            twist = twistangle-(twistangle*mio);
            chord= -0.0315044*r+1.95;
            segma_r=(N*chord)/(2*pi*r);
            q = @(a) BEMTR(a,cl,cd,alpha,segma_r,twist,lamda_r,theta_p);
            a =  fsolve(q,a0);
            x(i,1) = a(1);                %%axial Induction factor
            x(i,2) = a(2);                %%Tangential Induction factor
            Cp(i)=x(i,2)*(1-x(i,1))*lamda_r^2;
            CQ(i)=Cp(i)/tipspeed;
            %%excluding the negative values for Cp
            if Cp(i)<0
                Cp(i)=0;
            end
        end
        %%integration of Cp and CQ for the Whole blade for each lamda
        Cp_f(n,tipspeed)= 8*trapz(redius,redius.*(Cp)/R^2);
        CQ_f(n,tipspeed)= 8*trapz(redius,redius.*(CQ)/R^2);
        %%Finding the maximum Cp and the corresponing pitch angle and
        %%tipspeed
        if Cp_f(n,tipspeed)>MaxCp
            MaxCp=Cp_f(n,tipspeed);
            W=n;
            w=tipspeed;
        end
    end
    %%plotting the graphs
    figure(1)
    plot(s,CQ_f(n,:))
    xlabel('lamda')
    ylabel('CQ')
    title('lamda vs CQ')
    legend('Setting=-14','Setting=-9','Setting=-4','Setting=0','Setting=5')
    hold on
    figure(2)
    plot(s,Cp_f(n,:))
    xlabel('lamda')
    ylabel('Cp')
    title('lamda vs Cp')
    legend('Setting=-14','Setting=-9','Setting=-4','Setting=0','Setting=5')
    hold on
end
powerAvailable= (0.5*rho*(Uinf^3)*pi*(R)^2);
Power= powerAvailable*MaxCp;
