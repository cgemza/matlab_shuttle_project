function[]=conversion(jetPositionDouble)
    
    %This function accepts the position of the shuttle at the jettison
    %point at 126 seconds and converts it to miles.

    jetPositionMiles =jetPositionDouble/5280;
    disp("In a little over 2 minutes, the Space Shuttle Discovery traveled " + round(jetPositionMiles) + " miles.")
    disp(" ")
end