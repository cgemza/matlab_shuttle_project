clear, close all, clc

%Chelsea Gemza
%Final Project
%CSCI 1153 R02 Fall 2023

%% Part 1
clear, close all, clc
format bank

%Reference: https://www.youtube.com/watch?v=CtF43zNmHdQ&t=729s
%Reference: Example 10 equation from Calculus by James Stewart pg. 285

disp("PART A)")
disp(" ")

%Create symbolic variables
syms a v y t

%Velocity in feet per second
v = (.001302.*(t.^3))-(.09029.*(t.^2))+(23.61.*t)-3.083;

%Acceleration by taking derivative of velocity function
a = diff(v, t);

%Position by taking integral of velocity function
y = int(v, t);

%Display values in graphs

subplot 311
fplot (v, [0 126] )
grid
xlabel('Time')
ylabel('Velocity (ft/sec')
title('Hubble Space Telescope Velocity')

subplot 312
fplot (a, [0 126])
grid
ylabel('Acceleration (ft/sec^2')
xlabel('Time')
title('Hubble Space Telescope Acceleration')

subplot 313
fplot (y, [0 126])
grid
ylabel('Position (ft)')
xlabel('Time')
title('Hubble Space Telescope Position')

%Perform calculations & display output

jetVelocity = subs(v,t,126);
jetVelocityDouble = double(jetVelocity);

jetAcceleration = subs(a,t,126);
jetAccelerationDouble = double(jetAcceleration);

jetPosition = subs(y,t,126);
jetPositionDouble = double(jetPosition);

disp("At 126 seconds, the Space Shuttle Discovery jettisoned the solid rocket boosters.")
disp(" ")

%Use fprintf to display output in table format
matrix1 = [(round(jetVelocityDouble));(round(jetAccelerationDouble));(round(jetPositionDouble))];
fprintf(' Velocity         Acceleration        Position\n')
fprintf('%5d ft/sec  %6d ft/sec^2  %13d ft \n\n', matrix1)


%Call a function that calculates conversion of feet to miles with one input
%and no output (displays directly from function)

conversion(jetPositionDouble);

%Reference: https://esahubble.org/about/general/fact_sheet/

%The Webb Telescope launched in 2021, taking 29 days to travel 1,000,000 miles
%to the L2 orbit of the sun. Assuming the same speed, calculate how long it
%took the Hubble Space Telescope to reach orbit of 354 miles above Earth. 


minutesWebb = 29*24*60;
timeToOrbit = (minutesWebb*353)/1000000;
disp("It took the Webb Space Telescope an estimated " + round(timeToOrbit) + " minutes to travel 353 miles.")
disp("The Webb Space Telescope reached final orbit at L02 (1,000,000 miles from Earth) in 29 days.")
disp(" ")

%Compare this to the earlier calculation for the Hubble Telescope position
%after 2 minutes.

%Reference: https://esahubble.org/about/general/fact_sheet/
estimatedTimeToOrbit = (2*353)/40;
disp("It took the Hubble Space Telescope an estimated " + round(estimatedTimeToOrbit) + " minutes to travel 353 miles.")
disp("The Hubble Space Telescope reached final orbit at 353 miles from Earth. ")

%% Part 2
clear, close all, clc

disp('PART B)')
disp(' ')
%Read-in data for mass and quantity of telescope components
% use dot product to calculate center of mass pre and post jettison
% display results as a table
% create matrix of lifespan of components
% use loops to calculate end of life and display
%use input to take user data for what year it is

%Read in data and display in a table
%Note: I made up this data for the exercise
format shortg
matrix_data = readmatrix('shuttleparts.dat');
tableShuttleParts = table(matrix_data(:,1),matrix_data(:,2), matrix_data(:,3), matrix_data(:,4), matrix_data(:,5));
tableShuttleParts.Properties.VariableNames = {'Part Number','Quantity','Cost', 'Weight (lbs)', 'Lifespan (years)'};
disp(tableShuttleParts)

%Calculate total weight per component into new matrix

matrixTotalWeight = matrix_data(:,2).*matrix_data(:,4);

disp("Total Weight Per Component (lbs)")
disp(' ')
disp(round(matrixTotalWeight))

disp("Total Weight of Space Shuttle with Telescope")
totalWeight = sum(matrixTotalWeight);
fprintf("\n%d lbs\n\n", round(totalWeight))

%Use dot product to calculate center of mass pre and post jettison

disp('Center of Gravity Pre-Jettison of Solid Rocket Boosters: ')

%Input is location of each component in an x-y-z coordinate system and mass
x_meters = [.1; 1; 1.5; 2; .4; 2; 3; .2; 2.1; 1.4];
y_meters = [.3, .22, .5, .8, .9, .45, .13, .5, .9, .44];
z_meters = [2, 3, 1, 4, 3, 5, 2, 3, 1, 3];

%Output is the location of the center of gravity
x_bar = dot(x_meters,matrixTotalWeight)/sum(matrixTotalWeight);
disp(['x bar = ', num2str(x_bar)])

y_bar = dot(y_meters, matrixTotalWeight)/sum(matrixTotalWeight);
disp(['y bar = ', num2str(y_bar)])

z_bar = dot(z_meters, matrixTotalWeight)/sum(matrixTotalWeight);
disp(['z bar = ', num2str(z_bar)])

disp(' ')
disp('Center of Gravity Post-Jettison of Solid Rocket Boosters: ')

%Input is location of each component in an x-y-z coordinate system and mass
x_meters = [2; 3; 1.1; .33; .4; 1; 1; .3; 4; 3.1];
y_meters = [.9, .25, 3, 3, 2.1, 2.2, .9, .47, 1, .43];
z_meters = [1, 4, 4, 5, 1, 2, 2, 3, 3, 2];

%Output is the location of the center of gravity
x_bar = dot(x_meters,matrixTotalWeight)/sum(matrixTotalWeight);
disp(['x bar = ', num2str(x_bar)])

y_bar = dot(y_meters, matrixTotalWeight)/sum(matrixTotalWeight);
disp(['y bar = ', num2str(y_bar)])

z_bar = dot(z_meters, matrixTotalWeight)/sum(matrixTotalWeight);
disp(['z bar = ', num2str(z_bar)])

%Create matrix of lifespan of components
fprintf("\nLifespan of components: \n")
componentNumber = matrix_data(:,1);
years = matrix_data(:,5);
newMatrix = [ componentNumber, years];
tableLifespan = table(newMatrix (:,1), newMatrix(:,2));
tableLifespan.Properties.VariableNames = {'Component Number', 'Years'};
disp(tableLifespan)

%Use loops to calculate end of life and display
input_user_component = input("The Hubble Space Telescope launched in 1990. Enter component number (1-10): ");

if input_user_component <1 | input_user_component >10
    error('Improper Input')
else
    for input_user_component = componentNumber(input_user_component)
        endYear = 1990 + years(input_user_component);
        fprintf('\nComponent number %d expired in %d.', input_user_component, endYear)
    end
end

%% Part 3
clear, close all, clc

%Use curve fitting to estimate data points and an equation for position of the Webb Telescope
%From Part 1: It took the Webb Space Telescope an estimated 15 minutes to travel 353 miles.

%Hubble took an estimated 18 minutes to travel 353 miles
x = [0, 350, 500, 1080]; %15 minutes*60seconds = 
y = [0, 93192, 455000,  1863840]; %Launch from Earth to orbit of 353 miles


subplot(1,2,1)

plot(x,y,'g*') %Original data points
xlabel('Time (seconds)')
ylabel('Distance (feet)')
title('Hubble Position Curve')

hold on

coeffs=polyfit(x,y,3);
new_y = polyval(coeffs,x);
plot(x,new_y,'-g') %Line of fit


%Webb took an estimated 15 minutes to travel 353 miles
x1 = [0, 250, 600, 900]; %18 minutes*60seconds
y1 = [0, 90000, 1000000, 1863840]; %353miles*5280feet

subplot(1,2,2)

plot(x1,y1,'b*') %Original data points
xlabel('Time (seconds)')
ylabel('Distance (feet)')
title('Webb Position Curve')

hold on

coeffs=polyfit(x1,y1,3);
new_y1 = polyval(coeffs,x1);
plot(x1,new_y1,'-b') %Line of fit

%Layer Hubble and Webb on graph

figure
plot(x,new_y,'-g') %Line of fit Webb
hold on
plot(x1,new_y1,'-b') %Line of fit Hubble
xlabel('Time (seconds)')
ylabel('Distance (feet)')
title('Hubble & Webb Position Curve')
legend('Webb','Hubble')

%Note: I did learn about how to make an exponential line of fit on YoutTube
%But I chose to stick with what we covered in class for this project.
%Reference: https://www.youtube.com/watch?v=wByQEHNceyI&t=10s
%Reference: https://www.youtube.com/watch?v=o57o_ih9izs&t=727s
