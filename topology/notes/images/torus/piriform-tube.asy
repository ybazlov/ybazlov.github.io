//import three;
import graph3;
size(200,0);
currentprojection=perspective(6,3,2);

triple mysurface_param(pair p) {
	real r0 = 0.2;
	real t = p.x;
	real theta = p.y;
	real curve_x = 1 + cos(t);       // dx/dt = -sin(t)
	real dx = -sin(t);
	real curve_y = -curve_x*dx;   // dy/dt = -sin^2(t) + (1+cos(t))*cos(t) = 2*cos^2(t) + cos(t) - 1
	real dy = -dx*dx + curve_x*(curve_x-1);
	real n = sqrt(dx*dx + dy*dy);
	real nx = dy/n;
	real ny = -dx/n;
	real r = r0; 
	real x = curve_x + r*nx*cos(theta);                // n_length = sqrt()
	real y = curve_y + r*ny*cos(theta); // normal = (dy, -dx) 
	real z = r*sin(theta);  
	return (x,y,z);
}

surface s = surface(
mysurface_param, 
    (0,0), (2*pi,2*pi),
80, 80
);
draw(s, surfacepen=material(white+opacity(0.7), emissivepen=0.1*white), meshpen=gray(0.2));

