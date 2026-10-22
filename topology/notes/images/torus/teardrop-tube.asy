import three;
import graph3;
settings.render = 8;
size(10cm);
currentprojection=perspective(3,0,9);

real rad(real x) { 
	if(x<pi) { return sin(pi*(x/pi)**0.8); }
	else { return -sin(pi*((2*pi-x)/pi)**0.8); }
}

real r0 = 0.25;
real frac=0.4;


triple mysurface_param(pair p) {
	real t = frac*p.x;
	real theta = p.y;
	real curve_x = cos(t)/frac;       // dx/dt = -sin(t)
	real dx = -sin(t);
	real s2 = sin(t/2);
	real curve_y = -dx*s2*s2;   // dy/dt = -sin^2(t) + (1+cos(t))*cos(t) = 2*cos^2(t) + cos(t) - 1
	real dy = curve_x*s2*s2 + cos(t/2)*s2*(-dx);
	real n = sqrt(dx*dx + dy*dy);
	real nx;
	real ny;
	if(n==0) { nx = 0; ny = 1; }
	else {
	nx = dy/n;
	ny = -dx/n;
	}
	real r = r0*(1+0.75*rad(p.x)); 
	real x = curve_x + r*nx*cos(theta);                // n_length = sqrt()
	real y = curve_y + r*ny*cos(theta); // normal = (dy, -dx) 
	real z = r*sin(theta);  
	return (x,y,z);
}

real meridian_x(real u) { return mysurface_param((u,pi/2)).x; }
real meridian_y(real u) { return mysurface_param((u,pi/2)).y; }
real meridian_z(real u) { return mysurface_param((u,pi/2)).z; }

triple[] bluecircle_data(real s) { 
	triple Q0 = mysurface_param((s,0));
	triple Q1 = mysurface_param((s,2*pi/3));
	triple Q2 = mysurface_param((s,4*pi/3));
	triple P = (Q0+Q1+Q2)/3;
	triple n = cross(Q0-P, Q1-P);
	triple[] A = {Q0, P, n};
	return A;
}
 
path3 bluecircle(real s) {
	triple[] d = bluecircle_data(s);
	triple n = d.pop();
	if(s>pi) { n=-n; }
	triple P = d.pop();
	triple Q0 = d.pop();
	return arc(P, Q0, Q0, normal=n);
}

path3 redcurve() { 
	return graph(meridian_x, meridian_y, meridian_z, 2*(1-frac), 2*pi-2*(1-frac)); 
}

surface surf() {
	return surface(
		mysurface_param, 
    		(2*(1-frac),0), (2*pi-2*(1-frac),2*pi),
		60, 60
		);
}

void mydraw(real f, real yshift) {
	frac = f;
triple s = (-meridian_x(2*(1-frac)), yshift, 0);
triple u = (0, yshift, 0); // rotate about u--v
triple v = u+Z;
triple[] d = bluecircle_data(2*(1-frac));
triple n = d.pop();
real alpha = aCos(n.x/abs(n));
draw(rotate(alpha, u, v)*shift(s)*redcurve(), red+0.75bp, currentlight); 
draw(rotate(alpha, u, v)*shift(s)*surf(), surfacepen=material(white+opacity(0.7), emissivepen=0.3*white), meshpen=gray(0.3), currentlight);
draw(rotate(alpha, u, v)*shift(s)*bluecircle(2*(1-frac)), blue+0.75bp, arrow=MidArcArrow3(size=2.5bp), currentlight); 
draw(rotate(alpha, u, v)*shift(s)*bluecircle(2*pi - 2*(1-frac)), blue+0.75bp, arrow=MidArcArrow3(size=2.5bp), currentlight); 
}

mydraw(0.4, 0);
mydraw(0.7, 1.8);
mydraw(0.9, 3.6);

//frac = 0.4;
//draw(surf(), surfacepen=material(white+opacity(0.6), emissivepen=0.2*white), meshpen=gray(0.2));
//draw(bluecircle(2*(1-frac)), blue+0.75bp); 
//draw(bluecircle(2*pi - 2*(1-frac)), blue+0.75bp); 
//frac = 0.7;
//draw(shift(1,2,0)*surf(), surfacepen=material(white+opacity(0.6), emissivepen=0.2*white), meshpen=gray(0.2));
//draw(shift(1,2,0)*bluecircle(2*(1-frac)), blue+0.75bp); 
//draw(shift(1,2,0)*bluecircle(2*pi - 2*(1-frac)), blue+0.75bp); 
//frac = 0.9;
//draw(shift(1.2,4,0)*surf(), surfacepen=material(white+opacity(0.6), emissivepen=0.2*white), meshpen=gray(0.2));
//draw(shift(1.2,4,0)*bluecircle(2*(1-frac)), blue+0.75bp); 
//draw(shift(1.2,4,0)*bluecircle(2*pi - 2*(1-frac)), blue+0.75bp); 

