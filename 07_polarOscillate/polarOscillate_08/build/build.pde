import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HPolarLayout;

// ENVIRONMENT VARIABLES *************************************************
// Screen: 1440×900; Dribbble: 800×600; HD: 1920×1080 or 960×540)

int           stageW     = 1080;
int           stageH     = 1920;
color         clrBG      = #222034;
String        pathDATA   = "../../data/";

// LETS RENDER IMAGES ****************************************************

boolean       letsRender = false;
int           renderNum  = 0;
int           renderMax  = 1200; // how many frames to output
String        renderPATH = "../output/1080x1920-b/";


float         ringScale = 800;
int           ringSteps = 10;
boolean       recording = false;

// ***********************************************************************

HDrawablePool pool;
HCanvas       canvas;

void settings() {
	size(stageW,stageH);
}

void setup() {
	H.init(this).background(clrBG);
	smooth();

	// canvas = H.add(new HCanvas()).autoClear(false).fade(3);
	canvas = H.add(new HCanvas()).autoClear(false).fade(2);

	pool = new HDrawablePool(700);
	pool.autoParent(canvas)
		// .add(new HPath().star(2, 0.6, -90).size(24).anchor(0, 75).stroke(#00FF00).alpha(60).noFill())
		// .add(new HPath().star(2, 0.6, -90).size(20).anchor(0, 75).stroke(#0072CE).alpha(60).noFill())
		// .add(new HPath().star(1, 0.6, -90).size(32).anchor(0, 75).stroke(#FFFFFF).alpha(60).noFill())

		.add(new HEllipse().size(PI).anchor(PI*TWO_PI,PI*TWO_PI).fill(#462FE8).noStroke().alpha(100))
		.add(new HEllipse().size(PI).anchor(PI*TWO_PI,PI*TWO_PI).fill(#694EFB).noStroke().alpha(100))
		.add(new HEllipse().size(PI).anchor(PI*TWO_PI,PI*TWO_PI).fill(#FFFFFF).noStroke().alpha(100))

		.layout(
			new HPolarLayout(0.25, 10)
			.offset(width/2, height/2) // stage placement
			.scale(0.0025)
		)
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int       i = pool.currentIndex();
					HDrawable d = (HDrawable) obj;
					ringScale = ringScale - ringSteps;
					new HOscillator().target(d).property(H.SIZE).range(ringScale,PI*PI).speed(1).freq(.5).waveform(H.SINE).currentStep(i);
					new HOscillator().target(d).property(H.SCALE).range(PI*TWO_PI,TWO_PI*TWO_PI).speed(2).freq(1).waveform(H.SINE).currentStep(i);
					new HOscillator().target(d).property(H.ROTATION).range(-360,360).speed(1).freq(.4).waveform(H.SINE).currentStep(i);
					new HOscillator().target(d).property(H.ALPHA).range(-20,90).speed(4).freq(.06).waveform(H.SINE).currentStep(i);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
	saveFrame(renderPATH + "/#########.tiff"); if (frameCount == renderMax) exit();
}
