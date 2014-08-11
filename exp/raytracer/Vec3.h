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

	vec_t distanceFromOrigin() const {
		Vec3 origin(0, 0, 0);
		return distanceFromPoint(origin);
	}

	vec_t distanceFromPoint(const Vec3<vec_t>& _point) const {
		return std::sqrt(pow(pos.x - point.x, 2) + pow(pos.y - point.y, 2) + pow(pos.z - point.z, 2));
	}

	static vec_t dot(const Vec3<vec_t>& vec_a, const Vec3<vec_t>& vec_b) {
		return (vec_a.x * vec_b.x + vec_a.y * vec_b.y + vec_a.z * vec_b.z);
	}

	Vec3<vec_t>& operator=(const Vec3<vec_t>& _rhs) {
		if (this == &_rhs) { //Check for self assignment
			return *this;
		}

		this->x = _rhs.x;
		this->y = _rhs.y;
		this->z = _rhs.z;

		return *this;
	}

	bool operator==(const Vec3<vec_t>& _other) const {
		if (_other.x == x && _other.y == y && _other.z == z) {
			return true;
		}
		else {
			return false;
		}
	}

	bool operator!=(const Vec3<vec_t>& _other) const {
		if (_other == *this) {
			return false;
		}
		else {
			return true;
		}
	}

	Vec3<vec_t>& operator+=(const Vec3<vec_t>& _rhs) {
		this->x += _rhs.x;
		this->y += _rhs.y;
		this->z += _rhs.z;

		return *this;
	}

	Vec3<vec_t>& operator-=(const Vec3<vec_t>& _rhs) {
		this->x -= _rhs.x;
		this->y -= _rhs.y;
		this->z -= _rhs.z;

		return *this;
	}

	Vec3<vec_t> operator+(const Vec3<vec_t>& _other) const {
		Vec3<vec_t> result = *this;
		result += _other;
		return result;
	}

	Vec3<vec_t> operator-(const Vec3<vec_t>& _other) const {
		Vec3<vec_t> result = *this;
		result -= _other;
		return result;
	}
};

#endif