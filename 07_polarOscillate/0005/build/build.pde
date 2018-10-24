import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HPolarLayout;

// ENVIRONMENT VARIABLES *************************************************
// Screen: 1440×900; Dribbble: 800×600; HD: 1920×1080 or 960×540)

int           stageW     = 540;
int           stageH     = 960;
color         clrBG      = #050514;
String        pathDATA   = "../../data/";

// LETS RENDER IMAGES ****************************************************

boolean       letsRender = false;
int           renderNum  = 0;
int           renderMax  = 1800; // how many frames to output
String        renderPATH = "../output/1080x1920/";

// ***********************************************************************

HDrawablePool pool;
HCanvas       canvas;

void settings() {
	size(stageW,stageH);
}

void setup() {
	H.init(this).background(clrBG);

	canvas = H.add(new HCanvas()).autoClear(false).fade(10);

	pool = new HDrawablePool(700);
	pool.autoParent(canvas)
		.add(new HPath().star(2, 0.6, -90).size(24).anchor(0, 75).stroke(#00FF00).alpha(60).noFill())
		.add(new HPath().star(2, 0.6, -90).size(20).anchor(0, 75).stroke(#0072CE).alpha(60).noFill())
		.add(new HPath().star(1, 0.6, -90).size(32).anchor(0, 75).stroke(#FFFFFF).alpha(60).noFill())

		.layout(
			new HPolarLayout(0.5, 40)
			.offset(width/2, height/2) // stage placement
			.scale(0.008)
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
	saveFrame(renderPATH + "/#########.tiff"); if (frameCount == renderMax) exit();
}
