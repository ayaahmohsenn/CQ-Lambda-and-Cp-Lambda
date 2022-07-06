# CQ-Lambda-and-Cp-Lambda
we were asked to analyze a small wind turbine rotor, and We were asked to: 1- Generate the CQ vs Lambda and Cp vs Lambda curves for a suitable range of blade pitch angles applied rigidly to the whole blade.
First, the constants that we need in our code were defined like: the density, Uinf , number of
blades N, length of the blade R, twist angle.
we then assumed a maximum tip speed ratio of 25 and initial chord length at the root of 1 meter.
The angle of attack along with the CL and CD values were imported from Excel to MATLAB
using the built in function table2array.
The general structure of the code consists of three main for loops:
1- The first one loops on different values of the pitch angle (Beta) ranging from -15 to 5
2- the second one loops on the values of the tip speed ratio (lambda) ranging from 1 to 25
with 50 steps.
3- the third one loops on each section of the blade ranging from r=0.5 to r=20 (blade length)
with a step of 0.25m
For each section of the blade, the following were calculated;
- radius
- chord length according to the linear distribution C=-0.0315044*r+1.95
- twist according to the linear distribution; 𝑡𝑤𝑖𝑠𝑡 = 𝑡𝑤𝑖𝑠𝑡𝑎𝑛𝑔𝑙𝑒 −
𝑇𝑤𝑖𝑠𝑡𝑎𝑛𝑔𝑙𝑒
𝑅
∗ 𝑟 ; where n
is the number of partitions
- µ=r/R
- local speed ratio = tip speed ratio * µ
- local solidity according to
Then, the induction factors were calculated using a function that we built called BEMTR.m ,
this function takes in the previous calculated values and numerically solves the CQ and CT Blade
Element theory and the Momentum theory equations simultaneously using the MATLAB built
in function fsolve to output the axial and tangential induction factors a and a`
respectively.

For getting the Cp curve for all Lambdas, we have to use numerical integration to
integrate Cp all over lamdas, so we the functions trapz, to integrate Cp, in order to get it
for a single pitch angle,
