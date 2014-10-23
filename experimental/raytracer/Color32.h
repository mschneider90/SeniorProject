#ifndef COLOR_H
#define COLOR_H

typedef unsigned char byte;

enum class StdColor { White, Black };

class Color32
{
private:
protected:
public:
	char r;
	char g;
	char b;
	char a;

	Color32(StdColor _color) {
		setColor(_color);
	}
	Color32(byte _r, byte _g, byte _b, byte _a) : r(_r), g(_g), b(_b), a(_a) { }
	Color32() { }

    void setColor(StdColor _color);

	bool operator==(const Color32& _other) const;
	bool operator!=(const Color32& _other) const;
};

#endif