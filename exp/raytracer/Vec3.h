#ifndef VEC3_H
#define VEC3_H

template <class vec_t>
class Vec3 {
private:
protected:
public:
    vec_t x;
	vec_t y;
	vec_t z;

	Vec3 origin(0,0,0);

	Vec3(const vec_t _x, const vec_t _y, const vec_t _z) : x(_x), y(_z), z(_z) { }
	~Vec3() { }

	float distanceFromOrigin() const;
	float distanceFromPoint(const Vec3<vec_t>& _point) const;

	bool operator==(const vec_t& _other) const;
	bool operator!=(const vect_t& _other) const;
}
#endif