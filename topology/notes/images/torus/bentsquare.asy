settings.render = 8;
import graph3;
import three;


size(14cm,0);
currentprojection = perspective(3,-6,5);  // Set the viewing angle
// currentprojection = orthographic(2,-4,4);  // Set the viewing angle

real R = 3;
real R2 = 0.4;
triple P = (0, -R, 0);
triple P2 = (0, -R2, 0);


path3 vertsegment = (0, 0, -1) -- (0, 0, 1); 

real phi = 180/pi*1/R;
surface mysquare = surface(vertsegment, angle1=-phi, angle2=phi, c=P, axis=Z, n=9);
draw(mysquare, surfacepen=material(white+opacity(0.7), emissivepen=0.1*white), meshpen=gray(0.2));
draw(rotate(-phi, P, P+Z)*vertsegment, red+0.75bp, arrow=MidArrow3(4bp));
draw(rotate(phi, P, P+Z)*vertsegment, red+0.75bp, arrow=MidArrow3(4bp));

real phi2 = 180/pi*1/R2;
surface mysquare2 = surface(vertsegment, angle1=-phi2, angle2=phi2, c=P2, axis=Z, n=9);
draw(shift((2,0,0))*mysquare2, surfacepen=material(white+opacity(0.7), emissivepen=0.1*white), meshpen=gray(0.2));
draw(shift((2,0,0))*rotate(-phi2, P2, P2+Z)*vertsegment, red+0.75bp, arrow=MidArrow3(4bp));
draw(shift((2,0,0))*rotate(phi2, P2, P2+Z)*vertsegment, red+0.75bp, arrow=MidArrow3(4bp));

real phi3 = 180;
triple P3 = (0, -1/pi, 0);
surface mysquare2 = surface(vertsegment, angle1=-phi3, angle2=phi3, c=P3, axis=Z, n=9);
draw(shift((3.5,0,0))*mysquare2, surfacepen=material(white+opacity(0.7), emissivepen=0.1*white), meshpen=gray(0.2));
draw(shift((3.5,0,0))*rotate(phi3, P3, P3+Z)*vertsegment, red+0.75bp, arrow=MidArrow3(4bp));

