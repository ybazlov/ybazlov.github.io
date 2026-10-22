settings.render = 8;
import graph3;
import three;

//include "torus_parameters.asy";

real varphi = 180;
real theta = 180;

size(7cm,0);
currentprojection = perspective(0.3,-6,7);  // Set the viewing angle
// currentprojection = orthograthetac(2,-4,4);  // Set the viewing angle

real R = 2;
real r = 2;
triple P = (R, 0, 0);
triple P1 = (R+r, 0, 0);
triple RP = rotate(varphi, Z)*P;
triple RP1 = rotate(varphi, Z)*P1;

draw( (-R-r-0.5,0,0) -- (R+r+2,0,0), gray(0.5)+0.125bp, Arrow3);
label("$x$", (R+r+1.5, 0, 0), align=NE);
draw( (0,0,0) -- (0,R+r+2,0), gray(0.5)+0.125bp, Arrow3);
label("$y$", (0, R+r+1.5, 0), align=NE);

triple Q0 = P + rotate(theta,-Y)*(r*X);
triple Q0minus = P + rotate(theta-1.0,-Y)*(r*X);
triple Q0plus = P + rotate(theta+1.0,-Y)*(r*X);
path3 myarc = arc(P, Q0plus, Q0minus, normal=-Y);

surface semitorus = surface(myarc, angle1=0, angle2=varphi, c=O, axis=Z, n=9);
draw(semitorus, surfacepen=material(white+opacity(0.5), emissivepen=0.1*white), meshpen=gray(0.2));

path3 largecircle = circle(O, R);
draw(largecircle, blue+0.75bp);
draw(myarc, red+0.75bp);
draw(rotate(varphi, Z)*myarc, red+0.75bp);
dot(O, blue+3bp);
dot(P, blue+3bp);
dot(RP, blue+4bp);
draw(O -- rotate(varphi, Z)*P, blue+0.5bp);
path3 myxradius = P -- P+r*X;
draw(myxradius, black+0.25bp);
draw(rotate(varphi,Z)*myxradius, black+0.25bp);

