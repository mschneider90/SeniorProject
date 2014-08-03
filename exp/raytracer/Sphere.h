#ifndef SPHERE_H
#define SPHERE_H

#include "SceneObj.h"

class Ray;

class Sphere : public SceneObj {
private:
protected:
	float radius;
public:
	Sphere() { }
	~Sphere() { }
	virtual bool doesRayIntersect(const Ray& _ray);
}

#endif