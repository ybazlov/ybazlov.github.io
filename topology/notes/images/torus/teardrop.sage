# Teardrop with an outward-pointing cusp (SageMath)
# parameter s in [0,1)
var('s')
# we will use a piecewise parametrization with three pieces:
# 1) rising semicubical-parabola arm from cusp to top junction
# 2) circular arc from top junction to bottom junction
# 3) falling semicubical-parabola arm from bottom junction back to cusp

# scale parameters (adjust for overall size/shape)
A = 1.0      # horizontal scale of the cusp (tip at origin pointing right)
H = 1.0      # vertical half-height where parabola meets arc
R = 1.2      # radius of closing circular arc (centered at (cx,0))
cx = 1.0 + R # choose center to the right so the arc wraps round the bulge

def teardrop_param(u):
    # u in [0,1)
    if u < 1/4.0:
        # upper cusp arm: map u in [0,1/4) -> t in [0,1]
        t = (u/(1/4.0))
        # semicubical parabola scaled to connect (0,0) -> (x1,y1) = (A, H)
        x = A * t**2
        y = H * t**3
        return (x, y)
    elif u < 3/4.0:
        # circular arc: map u in [1/4,3/4) -> theta in [pi/4, -pi/4]
        v = (u - 1/4.0) / (1/2.0)
        theta = (1 - v)*(pi/4) + v*(-pi/4)
        # circle of radius R centered at (cx,0)
        x = cx + R * cos(theta)
        y = R * sin(theta)
        return (x, y)
    else:
        # lower cusp arm: map u in [3/4,1) -> t in [1,0]
        t = (1 - (u - 3/4.0)/(1/4.0))  # goes from 1 down to 0
        x = A * t**2
        y = -H * t**3
        return (x, y)

# build a parametric_plot using many sampled points
pts = [teardrop_param(i/400.0) for i in range(401)]
P = line(pts, thickness=2)
show(P, aspect_ratio=1, figsize=[6,6])
