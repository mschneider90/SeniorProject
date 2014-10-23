#include "Sphere.h"
#include "Ray.h"
#include "Vec3.h"

#include <cmath>

bool Sphere::doesRayIntersect(const Ray& _ray) const {
    //See: https://www.cs.unc.edu/~rademach/xroads-RT/RTarticle.html, "Intersecting a Sphere"
    //Find the vector from the initial point of the vector to the center of the sphere ("ic" = "initial, center")
    Vec3<float> ic = pos - _ray.getPos();
	float v = Vec3<float>::dot(ic, _ray.getAngle());
	float d = std::pow(radius, 2) - (Vec3<float>::dot(ic, ic) - std::pow(v, 2));
	if (d < 0) {
		return false;
	}
	else {
		return true;
	}
}