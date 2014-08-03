#ifndef SCENE_H
#define SCENE_H

#include <vector>
#include "Color32.h"
#include "SceneObj.h"
#include "Ray.h"

class Color32;
class SceneObj;
class Ray;
enum class SceneObjType;

// A Scene is a list of SceneObjs, with a background
class Scene {
private:
	std::vector<SceneObj> scene_objs;
	Color32 background_color;
protected:
public:
	Scene(Color32 _background_color) : background_color(_background_color) { }
	~Scene();
	SceneObj* addSceneObj(const SceneObjType _sceneobj_type);
	bool doesRayIntersectObj(const Ray& _ray);
	Color32 getBackgroundColor();
}

#endif