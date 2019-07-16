import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HPolarLayout;

// ENVIRONMENT VARIABLES *************************************************
// Screen: 1440×900; Dribbble: 800×600; HD: 1920×1080 or 960×540)

int           stageW     = 1340;
int           stageH     = 800;
color         clrBG      = #222034;
String        pathDATA   = "../../data/";

// LETS RENDER IMAGES ****************************************************

boolean       letsRender = false;
int           renderNum  = 0;
int           renderMax  = 990; // how many frames to output
String        renderPATH = "../output/1080x1920/";


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

	canvas = H.add(new HCanvas()).autoClear(false).fade(6);

	pool = new HDrawablePool(700);
	pool.autoParent(canvas)
		.add(new HEllipse().size(2).anchor(TWO_PI,PI).noFill().stroke(#462FE8).strokeWeight(2).alpha(100).loc(200,height/2))
		.add(new HEllipse().size(2).anchor(PI,TWO_PI).noFill().stroke(#FFFFFF).strokeWeight(2).alpha(100).loc(width/2,height/2))
		.add(new HEllipse().size(2).anchor(TWO_PI,PI).noFill().stroke(#694EFB).strokeWeight(2).alpha(100).loc(1240,height/2))

		// .layout(
		// 	new HPolarLayout(0.25, 10)
		// 	.offset(width/2, height/2) // stage placement
		// 	.scale(0.0025)
		// )
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int       i = pool.currentIndex();
					HDrawable d = (HDrawable) obj;
					ringScale = ringScale - ringSteps;
					new HOscillator().target(d).property(H.SIZE).range(ringScale,PI*PI).speed(1).freq(.5).waveform(H.SINE).currentStep( (int)random(333) );
					new HOscillator().target(d).property(H.SCALE).range(PI*TWO_PI,TWO_PI*TWO_PI).speed(2).freq(1).waveform(H.SINE).currentStep(i*4);
					new HOscillator().target(d).property(H.ROTATION).range(-360,360).speed(1).freq(.4).waveform(H.SINE).currentStep(i*1.5);
					// new HOscillator().target(d).property(H.ALPHA).range(-20,90).speed(4).freq(1).waveform(H.SINE).currentStep(i);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
	surface.setTitle( int(frameRate) + " FPS" );

	// saveFrame(renderPATH + "/#########.png"); if (frameCount == renderMax) exit();
}
