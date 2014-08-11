#ifndef SCENE_H
#define SCENE_H

#include <vector>
#include "Color32.h"
#include "SceneObj.h"
#include "Ray.h"
#include "Vec3.h"

//Forward declarations
class Color32;
class SceneObj;
class Sphere;
class Ray;
enum class SceneObjType;

// A Scene is a list of SceneObjs, with a background
class Scene {
private:
	std::vector<SceneObj*> scene_objs;
	Color32 background_color;
protected:
public:
	Scene(Color32 _background_color) : background_color(_background_color) { }
	~Scene();
	Sphere* addSphere(const Vec3<float>& _pos, const float _radius);
	bool doesRayIntersectObj(const Ray& _ray) const;
	Color32 getBackgroundColor();
};

#endif