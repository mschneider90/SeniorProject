`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////

module trigen8bit(	base_freq,
	triangle_out
    );

	
input base_freq;
reg [8:0] count; //max value 
output reg [7:0] triangle_out;

initial
begin
count = 0;
triangle_out = 0;
end

always@(posedge base_freq)
begin

case (count)
0: triangle_out = 0;
1: triangle_out = 1;
2: triangle_out = 2;
3: triangle_out = 3;
4: triangle_out = 4;
5: triangle_out = 5;
6: triangle_out = 6;
7: triangle_out = 7;
8: triangle_out = 8;
9: triangle_out = 9;
10: triangle_out = 10;
11: triangle_out = 11;
12: triangle_out = 12;
13: triangle_out = 13;
14: triangle_out = 14;
15: triangle_out = 15;
16: triangle_out = 16;
17: triangle_out = 17;
18: triangle_out = 18;
19: triangle_out = 19;
20: triangle_out = 20;
21: triangle_out = 21;
22: triangle_out = 22;
23: triangle_out = 23;
24: triangle_out = 24;
25: triangle_out = 25;
26: triangle_out = 26;
27: triangle_out = 27;
28: triangle_out = 28;
29: triangle_out = 29;
30: triangle_out = 30;
31: triangle_out = 31;
32: triangle_out = 32;
33: triangle_out = 33;
34: triangle_out = 34;
35: triangle_out = 35;
36: triangle_out = 36;
37: triangle_out = 37;
38: triangle_out = 38;
39: triangle_out = 39;
40: triangle_out = 40;
41: triangle_out = 41;
42: triangle_out = 42;
43: triangle_out = 43;
44: triangle_out = 44;
45: triangle_out = 45;
46: triangle_out = 46;
47: triangle_out = 47;
48: triangle_out = 48;
49: triangle_out = 49;
50: triangle_out = 50;
51: triangle_out = 51;
52: triangle_out = 52;
53: triangle_out = 53;
54: triangle_out = 54;
55: triangle_out = 55;
56: triangle_out = 56;
57: triangle_out = 57;
58: triangle_out = 58;
59: triangle_out = 59;
60: triangle_out = 60;
61: triangle_out = 61;
62: triangle_out = 62;
63: triangle_out = 63;
64: triangle_out = 64;
65: triangle_out = 65;
66: triangle_out = 66;
67: triangle_out = 67;
68: triangle_out = 68;
69: triangle_out = 69;
70: triangle_out = 70;
71: triangle_out = 71;
72: triangle_out = 72;
73: triangle_out = 73;
74: triangle_out = 74;
75: triangle_out = 75;
76: triangle_out = 76;
77: triangle_out = 77;
78: triangle_out = 78;
79: triangle_out = 79;
80: triangle_out = 80;
81: triangle_out = 81;
82: triangle_out = 82;
83: triangle_out = 83;
84: triangle_out = 84;
85: triangle_out = 85;
86: triangle_out = 86;
87: triangle_out = 87;
88: triangle_out = 88;
89: triangle_out = 89;
90: triangle_out = 90;
91: triangle_out = 91;
92: triangle_out = 92;
93: triangle_out = 93;
94: triangle_out = 94;
95: triangle_out = 95;
96: triangle_out = 96;
97: triangle_out = 97;
98: triangle_out = 98;
99: triangle_out = 99;
100: triangle_out = 100;
101: triangle_out = 101;
102: triangle_out = 102;
103: triangle_out = 103;
104: triangle_out = 104;
105: triangle_out = 105;
106: triangle_out = 106;
107: triangle_out = 107;
108: triangle_out = 108;
109: triangle_out = 109;
110: triangle_out = 110;
111: triangle_out = 111;
112: triangle_out = 112;
113: triangle_out = 113;
114: triangle_out = 114;
115: triangle_out = 115;
116: triangle_out = 116;
117: triangle_out = 117;
118: triangle_out = 118;
119: triangle_out = 119;
120: triangle_out = 120;
121: triangle_out = 121;
122: triangle_out = 122;
123: triangle_out = 123;
124: triangle_out = 124;
125: triangle_out = 125;
126: triangle_out = 126;
127: triangle_out = 127;
128: triangle_out = 128;
129: triangle_out = 129;
130: triangle_out = 130;
131: triangle_out = 131;
132: triangle_out = 132;
133: triangle_out = 133;
134: triangle_out = 134;
135: triangle_out = 135;
136: triangle_out = 136;
137: triangle_out = 137;
138: triangle_out = 138;
139: triangle_out = 139;
140: triangle_out = 140;
141: triangle_out = 141;
142: triangle_out = 142;
143: triangle_out = 143;
144: triangle_out = 144;
145: triangle_out = 145;
146: triangle_out = 146;
147: triangle_out = 147;
148: triangle_out = 148;
149: triangle_out = 149;
150: triangle_out = 150;
151: triangle_out = 151;
152: triangle_out = 152;
153: triangle_out = 153;
154: triangle_out = 154;
155: triangle_out = 155;
156: triangle_out = 156;
157: triangle_out = 157;
158: triangle_out = 158;
159: triangle_out = 159;
160: triangle_out = 160;
161: triangle_out = 161;
162: triangle_out = 162;
163: triangle_out = 163;
164: triangle_out = 164;
165: triangle_out = 165;
166: triangle_out = 166;
167: triangle_out = 167;
168: triangle_out = 168;
169: triangle_out = 169;
170: triangle_out = 170;
171: triangle_out = 171;
172: triangle_out = 172;
173: triangle_out = 173;
174: triangle_out = 174;
175: triangle_out = 175;
176: triangle_out = 176;
177: triangle_out = 177;
178: triangle_out = 178;
179: triangle_out = 179;
180: triangle_out = 180;
181: triangle_out = 181;
182: triangle_out = 182;
183: triangle_out = 183;
184: triangle_out = 184;
185: triangle_out = 185;
186: triangle_out = 186;
187: triangle_out = 187;
188: triangle_out = 188;
189: triangle_out = 189;
190: triangle_out = 190;
191: triangle_out = 191;
192: triangle_out = 192;
193: triangle_out = 193;
194: triangle_out = 194;
195: triangle_out = 195;
196: triangle_out = 196;
197: triangle_out = 197;
198: triangle_out = 198;
199: triangle_out = 199;
200: triangle_out = 200;
201: triangle_out = 201;
202: triangle_out = 202;
203: triangle_out = 203;
204: triangle_out = 204;
205: triangle_out = 205;
206: triangle_out = 206;
207: triangle_out = 207;
208: triangle_out = 208;
209: triangle_out = 209;
210: triangle_out = 210;
211: triangle_out = 211;
212: triangle_out = 212;
213: triangle_out = 213;
214: triangle_out = 214;
215: triangle_out = 215;
216: triangle_out = 216;
217: triangle_out = 217;
218: triangle_out = 218;
219: triangle_out = 219;
220: triangle_out = 220;
221: triangle_out = 221;
222: triangle_out = 222;
223: triangle_out = 223;
224: triangle_out = 224;
225: triangle_out = 225;
226: triangle_out = 226;
227: triangle_out = 227;
228: triangle_out = 228;
229: triangle_out = 229;
230: triangle_out = 230;
231: triangle_out = 231;
232: triangle_out = 232;
233: triangle_out = 233;
234: triangle_out = 234;
235: triangle_out = 235;
236: triangle_out = 236;
237: triangle_out = 237;
238: triangle_out = 238;
239: triangle_out = 239;
240: triangle_out = 240;
241: triangle_out = 241;
242: triangle_out = 242;
243: triangle_out = 243;
244: triangle_out = 244;
245: triangle_out = 245;
246: triangle_out = 246;
247: triangle_out = 247;
248: triangle_out = 248;
249: triangle_out = 249;
250: triangle_out = 250;
251: triangle_out = 251;
252: triangle_out = 252;
253: triangle_out = 253;
254: triangle_out = 254;
255: triangle_out = 255;
256: triangle_out = 255;
257: triangle_out = 254;
258: triangle_out = 253;
259: triangle_out = 252;
260: triangle_out = 251;
261: triangle_out = 250;
262: triangle_out = 249;
263: triangle_out = 248;
264: triangle_out = 247;
265: triangle_out = 246;
266: triangle_out = 245;
267: triangle_out = 244;
268: triangle_out = 243;
269: triangle_out = 242;
270: triangle_out = 241;
271: triangle_out = 240;
272: triangle_out = 239;
273: triangle_out = 238;
274: triangle_out = 237;
275: triangle_out = 236;
276: triangle_out = 235;
277: triangle_out = 234;
278: triangle_out = 233;
279: triangle_out = 232;
280: triangle_out = 231;
281: triangle_out = 230;
282: triangle_out = 229;
283: triangle_out = 228;
284: triangle_out = 227;
285: triangle_out = 226;
286: triangle_out = 225;
287: triangle_out = 224;
288: triangle_out = 223;
289: triangle_out = 222;
290: triangle_out = 221;
291: triangle_out = 220;
292: triangle_out = 219;
293: triangle_out = 218;
294: triangle_out = 217;
295: triangle_out = 216;
296: triangle_out = 215;
297: triangle_out = 214;
298: triangle_out = 213;
299: triangle_out = 212;
300: triangle_out = 211;
301: triangle_out = 210;
302: triangle_out = 209;
303: triangle_out = 208;
304: triangle_out = 207;
305: triangle_out = 206;
306: triangle_out = 205;
307: triangle_out = 204;
308: triangle_out = 203;
309: triangle_out = 202;
310: triangle_out = 201;
311: triangle_out = 200;
312: triangle_out = 199;
313: triangle_out = 198;
314: triangle_out = 197;
315: triangle_out = 196;
316: triangle_out = 195;
317: triangle_out = 194;
318: triangle_out = 193;
319: triangle_out = 192;
320: triangle_out = 191;
321: triangle_out = 190;
322: triangle_out = 189;
323: triangle_out = 188;
324: triangle_out = 187;
325: triangle_out = 186;
326: triangle_out = 185;
327: triangle_out = 184;
328: triangle_out = 183;
329: triangle_out = 182;
330: triangle_out = 181;
331: triangle_out = 180;
332: triangle_out = 179;
333: triangle_out = 178;
334: triangle_out = 177;
335: triangle_out = 176;
336: triangle_out = 175;
337: triangle_out = 174;
338: triangle_out = 173;
339: triangle_out = 172;
340: triangle_out = 171;
341: triangle_out = 170;
342: triangle_out = 169;
343: triangle_out = 168;
344: triangle_out = 167;
345: triangle_out = 166;
346: triangle_out = 165;
347: triangle_out = 164;
348: triangle_out = 163;
349: triangle_out = 162;
350: triangle_out = 161;
351: triangle_out = 160;
352: triangle_out = 159;
353: triangle_out = 158;
354: triangle_out = 157;
355: triangle_out = 156;
356: triangle_out = 155;
357: triangle_out = 154;
358: triangle_out = 153;
359: triangle_out = 152;
360: triangle_out = 151;
361: triangle_out = 150;
362: triangle_out = 149;
363: triangle_out = 148;
364: triangle_out = 147;
365: triangle_out = 146;
366: triangle_out = 145;
367: triangle_out = 144;
368: triangle_out = 143;
369: triangle_out = 142;
370: triangle_out = 141;
371: triangle_out = 140;
372: triangle_out = 139;
373: triangle_out = 138;
374: triangle_out = 137;
375: triangle_out = 136;
376: triangle_out = 135;
377: triangle_out = 134;
378: triangle_out = 133;
379: triangle_out = 132;
380: triangle_out = 131;
381: triangle_out = 130;
382: triangle_out = 129;
383: triangle_out = 128;
384: triangle_out = 127;
385: triangle_out = 126;
386: triangle_out = 125;
387: triangle_out = 124;
388: triangle_out = 123;
389: triangle_out = 122;
390: triangle_out = 121;
391: triangle_out = 120;
392: triangle_out = 119;
393: triangle_out = 118;
394: triangle_out = 117;
395: triangle_out = 116;
396: triangle_out = 115;
397: triangle_out = 114;
398: triangle_out = 113;
399: triangle_out = 112;
400: triangle_out = 111;
401: triangle_out = 110;
402: triangle_out = 109;
403: triangle_out = 108;
404: triangle_out = 107;
405: triangle_out = 106;
406: triangle_out = 105;
407: triangle_out = 104;
408: triangle_out = 103;
409: triangle_out = 102;
410: triangle_out = 101;
411: triangle_out = 100;
412: triangle_out = 99;
413: triangle_out = 98;
414: triangle_out = 97;
415: triangle_out = 96;
416: triangle_out = 95;
417: triangle_out = 94;
418: triangle_out = 93;
419: triangle_out = 92;
420: triangle_out = 91;
421: triangle_out = 90;
422: triangle_out = 89;
423: triangle_out = 88;
424: triangle_out = 87;
425: triangle_out = 86;
426: triangle_out = 85;
427: triangle_out = 84;
428: triangle_out = 83;
429: triangle_out = 82;
430: triangle_out = 81;
431: triangle_out = 80;
432: triangle_out = 79;
433: triangle_out = 78;
434: triangle_out = 77;
435: triangle_out = 76;
436: triangle_out = 75;
437: triangle_out = 74;
438: triangle_out = 73;
439: triangle_out = 72;
440: triangle_out = 71;
441: triangle_out = 70;
442: triangle_out = 69;
443: triangle_out = 68;
444: triangle_out = 67;
445: triangle_out = 66;
446: triangle_out = 65;
447: triangle_out = 64;
448: triangle_out = 63;
449: triangle_out = 62;
450: triangle_out = 61;
451: triangle_out = 60;
452: triangle_out = 59;
453: triangle_out = 58;
454: triangle_out = 57;
455: triangle_out = 56;
456: triangle_out = 55;
457: triangle_out = 54;
458: triangle_out = 53;
459: triangle_out = 52;
460: triangle_out = 51;
461: triangle_out = 50;
462: triangle_out = 49;
463: triangle_out = 48;
464: triangle_out = 47;
465: triangle_out = 46;
466: triangle_out = 45;
467: triangle_out = 44;
468: triangle_out = 43;
469: triangle_out = 42;
470: triangle_out = 41;
471: triangle_out = 40;
472: triangle_out = 39;
473: triangle_out = 38;
474: triangle_out = 37;
475: triangle_out = 36;
476: triangle_out = 35;
477: triangle_out = 34;
478: triangle_out = 33;
479: triangle_out = 32;
480: triangle_out = 31;
481: triangle_out = 30;
482: triangle_out = 29;
483: triangle_out = 28;
484: triangle_out = 27;
485: triangle_out = 26;
486: triangle_out = 25;
487: triangle_out = 24;
488: triangle_out = 23;
489: triangle_out = 22;
490: triangle_out = 21;
491: triangle_out = 20;
492: triangle_out = 19;
493: triangle_out = 18;
494: triangle_out = 17;
495: triangle_out = 16;
496: triangle_out = 15;
497: triangle_out = 14;
498: triangle_out = 13;
499: triangle_out = 12;
500: triangle_out = 11;
501: triangle_out = 10;
502: triangle_out = 9;
503: triangle_out = 8;
504: triangle_out = 7;
505: triangle_out = 6;
506: triangle_out = 5;
507: triangle_out = 4;
508: triangle_out = 3;
509: triangle_out = 2;
510: triangle_out = 1;
511: triangle_out = 0;
default: triangle_out = 0;
endcase

count= count + 1;

if (count >= 512)
begin
count = 0;
end




end


endmodule