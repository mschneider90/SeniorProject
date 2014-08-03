#ifndef COLOR_H
#define COLOR_H

typedef char byte;

enum class StandardColor { White, Black };

class Color32
{
private:
protected:
public:
	char r;
	char g;
	char b;
	char a;

	Color32(StandardColor _color) {
		setColor(_color);
	}
	Color32(byte _r, byte _g, byte_b, byte_a) : r(_r), g(_g), b(_b), a(_a) { }
	Color32() { }

	void setColor(StandardColor _color) {
		if (_color == StandardColor::White) {
			r = 0xFF;
			g = 0xFF;
			b = 0xFF;
			a = 0xFF;
		}
	}

	bool operator==(const Color32& _other) const;
	bool operator!=(const Color32& _other) const;
}

#endif