// import processing.pdf.*;
import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HPolarLayout;

// MBPro: 1440×900, 800×600, 1920×1080…960×540;
int    stageW    = 800;
int    stageH    = 600;
color  clrBG     = #050514;
String pathDATA  = "../../data/";

HDrawablePool pool;
HCanvas       canvas;

void settings() {
	size(stageW,stageH);
}

void setup() {
	H.init(this).background(clrBG);

	canvas = H.add(new HCanvas()).autoClear(false).fade(4);

	pool = new HDrawablePool(600);
	pool.autoParent(canvas)
		.add(new HPath().star(2, 0.6, -90).size(24).anchor(0, 75).stroke(#00FF00).alpha(50).noFill())
		.add(new HPath().star(2, 0.6, -90).size(20).anchor(0, 75).stroke(#0072CE).alpha(50).noFill())
		.add(new HPath().star(3, 0.6, -90).size(32).anchor(0, 75).stroke(#FFFFFF).alpha(25).noFill())

		// .add(new HPath().star(2, 0.6, -90).size(24).anchor(0, 75).stroke(#50AF48).alpha(99).noFill())
		// .add(new HPath().star(2, 0.6, -90).size(20).anchor(0, 75).stroke(#266DC0).alpha(99).noFill())
		// .add(new HPath().star(2, 0.6, -90).size(16).anchor(0, 75).stroke(clrBG).alpha(50).noFill())

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
	// saveFrame("../output/800x600/#########.tiff"); if (frameCount == 900) exit();
}
