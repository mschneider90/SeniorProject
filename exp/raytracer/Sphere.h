#ifndef SPHERE_H
#define SPHERE_H

#include "SceneObj.h"

class Ray;

class Sphere : public SceneObj {
private:
    float radius;
    Sphere() { }
    ~Sphere() { }
protected:
public:
	virtual bool doesRayIntersect(const Ray& _ray);
    void setRadius(float _radius) { radius = _radius; }
};

#endif