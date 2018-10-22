import hype.*;

// ENVIRONMENT VARIABLES *************************************************
// Screen: 1440×900; Dribbble: 800×600; HD: 1920×1080 or 960×540)

int           stageW     = 800;
int           stageH     = 600;
color         clrBG      = #242424;
String        pathDATA   = "../data/";

// LETS RENDER IMAGES ****************************************************

int           renderMax  = 1800; // for animations, how many frames to output
String        renderPATH = "../output/";

// ***********************************************************************

HCanvas       canvas;

void settings() {
	size(stageW,stageH);
}

void setup() {
	H.init(this).background(clrBG);

	canvas = H.add(new HCanvas()); // additions for animations: .autoClear(true).fade(100)

	HRect s1 = new HRect(120);
	s1.rounding(10).strokeWeight(6).stroke(#686868).fill(#FF9900).loc(width/2,height/2).anchorAt(H.CENTER);
	H.add(s1);

	HShape svg1 = new HShape(pathDATA + "six.svg");
	svg1.enableStyle(false).noStroke().fill(#686868).anchorAt(H.CENTER).loc(width/2,height/2);
	H.add(svg1);

	noLoop();
}

void draw() {
	H.drawStage();
}