#ifndef SCENEOBJ_H
#define SCENEOBJ_H

//Forward Declarations
class Ray;

//This should be kept up to date with all of the SceneObj children
//Used by Scene to create SceneObjs
enum class SceneObjType {Sphere};

class SceneObj {
private:
protected:
	Vec3<float> pos;
public:
	SceneObj() {};
	virtual bool doesRayIntersect(const Ray& _ray) const = 0;
};

#endif