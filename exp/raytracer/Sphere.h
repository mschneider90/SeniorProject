#ifndef SPHERE_H
#define SPHERE_H

#include "SceneObj.h"

//Forward declarations
class Ray;

class Sphere : public SceneObj {

    //SceneObj creation/deletion happens in Scene class
    friend class Scene;

private:
    float radius;
    Sphere() : radius(0) { }
    Sphere(Vec3<float> _pos, float _radius) : radius(_radius) { pos = _pos; }
    ~Sphere() { }
protected:
public:
	virtual bool doesRayIntersect(const Ray& _ray) const;
    void setRadius(float _radius) { radius = _radius; }
};

#endif