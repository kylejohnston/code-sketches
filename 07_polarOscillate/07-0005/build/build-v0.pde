import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HPolarLayout;

// ENVIRONMENT VARIABLES *************************************************
// Screen: 1440×900; Dribbble: 800×600; HD: 1920×1080 or 960×540)

int       stageW        = 800;
int       stageH        = 600;
color     clrBG         = #050514;
String    pathDATA      = "../../data/";

// LETS RENDER IMAGES ****************************************************

boolean   letsRender    = false;
int       renderNum     = 0;
int       renderMax     = 5;     // how many frames to output
int       renderModulo  = 20;    // stagger which frames are output
PGraphics renderCanvas;
String    renderPATH    = "../output/800x600/";

// ***********************************************************************

HDrawablePool pool;
HCanvas       canvas;

void settings() {
	size(stageW,stageH);
}

void setup() {
	background(clrBG);
	renderCanvas = createGraphics(stageW,stageH,P3D);
}

void draw() {
	PGraphics _whichCanvas;
	int       _w // width
	int       _h // height
	float     _s // scale

	_whichCanvas = renderCanvas
	_w           = stageW;
	_h           = stageH;
	_s           = 1.0;

	_whichCanvas.beginDraw();
	_whichCanvas.clear();

	// H.init(this).background(clrBG);

	canvas = H.add(new HCanvas()).autoClear(false).fade(4);

	pool = new HDrawablePool(600);
	pool.autoParent(canvas)
		.add(new HPath().star(2, 0.6, -90).size(24).anchor(0, 75).stroke(#00FF00).alpha(50).noFill())
		.add(new HPath().star(2, 0.6, -90).size(20).anchor(0, 75).stroke(#0072CE).alpha(50).noFill())
		.add(new HPath().star(3, 0.6, -90).size(32).anchor(0, 75).stroke(#FFFFFF).alpha(25).noFill())

		.layout(
			new HPolarLayout(0.5, 40)
			.offset(width/2, height/2) // stage placement
			.scale(0.005)
		)
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int       i = pool.currentIndex();
					HDrawable d = (HDrawable) obj;
					new HOscillator().target(d).property(H.SCALE).range(.1,8).speed(4).freq(.4).waveform(H.SINE).currentStep(i);
					new HOscillator().target(d).property(H.ROTATION).range(-360,360).speed(.5).freq(.4).waveform(H.SINE).currentStep(i);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();

	//if(frameCount%(renderModulo-1)==0 && letsRender) {
		// or
	if (letsRender) {
		// continue…
		save(renderPATH + renderNum + ".png");
		renderNum++;
		if (renderNum>=renderMax) {
			letsRender = false;
			exit();
		}
	}
}

void keyPressed() {
	switch (key) {
		case 'p':
			letsRender = true;
		break;
	}
}