#ifndef SCENEOBJ_H
#define SCENEOBJ_H

#include "Vec3.h"

//Forward Declarations
class Ray;

//This should be kept up to date with all of the SceneObj children
//Used by Scene to create SceneObjs
enum class SceneObjType { Sphere };

class SceneObj {
    //All SceneObj creation/deletion should happen thru the Scene class
    friend class Scene;

private:
protected:
	Vec3<float> pos;

    SceneObj() {};
    SceneObj(Vec3<float> _pos) : pos(_pos) { }
public:
	virtual bool doesRayIntersect(const Ray& _ray) const = 0;
    virtual void setPosition(const Vec3<float> _pos) { pos = _pos; }
    virtual const Vec3<float>& getPosition() { return pos; }
};

#endif