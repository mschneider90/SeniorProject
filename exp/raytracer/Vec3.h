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

    Vec3() : x(0), y(0), z(0) { }
	Vec3(const vec_t _x, const vec_t _y, const vec_t _z) : x(_x), y(_z), z(_z) { }
	~Vec3() { }

	vec_t distanceFromOrigin() const;
	vec_t distanceFromPoint(const Vec3<vec_t>& _point) const;
    static vec_t dot(const Vec3<vec_t>& vec_a, const Vec3<vec_t>& vec_b);

    Vec3<vec_t>& operator=(const Vec3<vec_t>& rhs);
	bool operator==(const vec_t& _rhs) const;
	bool operator!=(const vec_t& _rhs) const;
    Vec3<vec_t>& operator+=(const Vec3<vec_t>& _rhs);
    Vec3<vec_t>& operator-=(const Vec3<vec_t>& _rhs);
    const Vec3<vec_t> operator+(const Vec3<vec_t>& _rhs);
    const Vec3<vec_t> operator-(const Vec3<vec_t>& _rhs);
};

#endif