settings.render = 8;
import graph3;
import three;
size(6cm,0);
currentprojection = perspective(10,6,-8);  // Set the viewing angle

path3 myarc = Arc(c=O, normal=X, v1=rotate(2,X)*(-Z), v2=rotate(-2,X)*Z, n=10);
path3 hole = Arc(c=(0,0,Cos(2)), normal=Z, v1=(0,Sin(2),Cos(2)), v2=(0,-Sin(2),Cos(2)), n=10); 

surface backHemisphere = surface(myarc, angle1=0, angle2=180, c=O, axis=Z, n=10);
surface frontHemisphere = surface(myarc, angle1=180, angle2=360, c=O, axis=Z, n=10);

draw(backHemisphere, surfacepen=material(white+opacity(0.7), emissivepen=0.1*white), meshpen=gray(0.2));
draw(frontHemisphere, surfacepen=material(white+opacity(0.7), emissivepen=0.1*white), meshpen=gray(0.2));
draw(hole);
draw(rotate(180,Z)*hole);
draw(rotate(180,X)*hole);
draw(rotate(180,X)*rotate(180,Z)*hole);
