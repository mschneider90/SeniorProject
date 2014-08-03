#include "Sphere.h"
#include "Ray.h"

bool Sphere::doesRayIntersect(const Ray& _ray) const {
    //See: https://www.cs.unc.edu/~rademach/xroads-RT/RTarticle.html, "Intersecting a Sphere"
    //Find the vector from the initial point of the vector to the center of the sphere ("ic" = "initial, center")
    Vec3<float> ic = pos - _ray.getPos();
    //float v = Vec3<float>::dot(,_ray.angle)
}