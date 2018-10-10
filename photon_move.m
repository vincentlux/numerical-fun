% group project credit to Vincent Lu and Zeyao Liu
clc; clear all;
syms t i j 
format long e;
% time t
% initial value x = y = 0; r = 1/3
% p: coord of photon
% v: vector direction and speed
t = 10;
circle(1/3,t); 
time = 10;
p = [0.5; 0.1];
v = [1; 0];


% exact
exact = val(time, p, v)
% perturb (10^-15 perturbation)
p = [0.5+10^-15; 0.1];
perturb = val(time, p, v)
% condition number
condition = abs(perturb - exact) / norm([0.5+10^-15 0.1] - [0.5 0.1])


function value = val(time, p, v)
    % main function to calculate the distance between the photon and the
    % origin.

    while time > 0
        % distance from one point on the circle to the center of another circle
        % is at least 2/3
        c = round(p + (2/3)*v);
        % time
        s = piece_t(p, v, c);
        if s < 10
            p = p+s*v;
            v = (reflection(c, p))*v;
        else
            s = min(time, 2/3);
            p = p+s*v;
        end
        time = time-s;
    end
    % distance to (0,0)
    value = norm(p);
end


function [piece_time] = piece_t(p, v, c)
    % to calculate time piece between each hit
    syms x y;

    p1 = p(1,1);
    p2 = p(2,1);
    v1 = v(1,1); v2 = v(2,1);
    c1 = c(1,1); c2 = c(2,1);

    eqn1 = y == (v2/v1)*x + (p2-(v2/v1)*p1);
    eqn2 = 1/9 == (x-c1)^2 + (y-c2)^2;

    sol = solve([eqn1, eqn2], [x,y]);
    xSol = sol.x;
    ySol = sol.y;

    sqrt1 = sqrt(((xSol(1)-p1)^2 + (ySol(1)-p2)^2));

    sqrt2 = sqrt(((xSol(2)-p1)^2 + (ySol(2)-p2)^2));
    if imag(sqrt1) ~= 0 && imag(sqrt2) ~= 0
        piece_time = double(ones(0,1));
    else
        piece_time = double(min(sqrt2, sqrt1));
    end
end


function h = circle(r,t)
    % Draw all circles with max length the value of t
    hold on
    
    % round up to next int
    t = ceil(t);
    ang = 0:pi/1000:2*pi;
    % loop to draw all circles
    for X = -t: 1: t
        for Y = -t: 1: t
            xunit = r * cos(ang) + X;
            yunit = r * sin(ang) + Y;
            h = plot(xunit, yunit);
            hold on
        end
    end
    hold off
end


function [A] = reflection(center, point)
    % reflection function
    l = point - center;
    x1 = (l(2))^2 - (l(1))^2;
    x2 = -2 * l(1) * l(2);
    A = 9 * [x1 x2; x2 (-x1)];
end

