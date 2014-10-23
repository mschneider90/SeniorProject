#ifndef RAY_H
#define RAY_H

#include "Vec3.h"

class Ray
{
private:
	Vec3<float> pos;
	Vec3<float> angle;
protected:
public:
	Ray(Vec3<float> _pos, Vec3<float> _angle) : pos(_pos), angle(_angle) { }
    const Vec3<float>& getPos() const { return pos; };
    const Vec3<float>& getAngle() const { return angle; };
};

#endif