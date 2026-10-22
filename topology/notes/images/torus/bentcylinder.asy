settings.render = 8;
import graph3;
import three;


size(14cm,0);
currentprojection = perspective(3,-6,-2);  // Set the viewing angle
// currentprojection = orthographic(2,-4,4);  // Set the viewing angle

real R2 = 0.4;

void drawbc(real R, real sh) { 
	real r = 1/pi;
	real varphi = 180/pi*2/(R-r);
	triple P = (R, 0, 0);
	real[][] s = shift((sh, 0, 0));

	triple Q0 = P + (-r)*Y;
	path3 myarc = shift(-P)*arc(P, Q0, Q0, normal=-Z);
	path3 myarc2 = shift(-P)*rotate(varphi, -Y)*arc(P, Q0, Q0, normal=-Z);
	path3 bigarc = shift(-P)*arc(O+(-r)*Y, Q0, rotate(varphi, -Y)*Q0, normal=-Y);

	surface semitorus = surface(myarc, angle1=0, angle2=varphi, c=-P, axis=-Y, n=9);
	draw(s*semitorus, surfacepen=material(white+opacity(0.7), emissivepen=0.1*white), meshpen=gray(0.2));

	draw(s*bigarc, red+0.75bp);
	draw(s*myarc, blue+0.75bp);
	draw(s*myarc2, blue+0.75bp);
}

drawbc(10, 0);
drawbc(3/pi-0.1, 3);
drawbc(2/pi+0.005, 5.6);
