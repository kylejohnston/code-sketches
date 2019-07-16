// import processing.pdf.*;
import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HPolarLayout;

int    stageW    = 1440;
int    stageH    = 900;
color  clrBG     = #242424;
String pathDATA  = "../../data/";

HDrawablePool pool;
HColorPool    colors;

void settings() {
	size(stageW,stageH);
}

void setup() {
	// H.init(this).background(clrBG).use3D(true);
	H.init(this).background(clrBG).autoClear(false);
	smooth();

	colors = new HColorPool(#FFFFFF);
	// colors = new HColorPool(#c4ff00, #015872, #50ac2d, #1c4c08, #59c18c);

	pool = new HDrawablePool(900);
	pool.autoAddToStage()
		
		// .add(new HEllipse(8).strokeWeight(2).stroke(#000000).noFill().anchorAt(H.CENTER))
		// .add(new HEllipse(4).strokeWeight(1).stroke(#FF3300).noFill().anchorAt(H.CENTER))
		.add(new HPath().star(5, 0.4, -90).size(24).anchor(0, 75).stroke(#FFFFFF).alpha(10).noFill().anchorAt(H.CENTER))
		.add(new HPath().star(5, 0.4, -90).size(16).anchor(0, 75).stroke(#FF3300).alpha(10).noFill().anchorAt(H.CENTER))
		.add(new HPath().star(5, 0.4, -90).size(8).anchor(0, 75).stroke(clrBG).alpha(10).noFill().anchorAt(H.CENTER))

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

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(.1,8)
						.speed(1)
						.freq(.4)
						.waveform(H.SINE)
						.currentStep(i)
					;
					new HOscillator()
						.target(d)
						.property(H.ROTATION)
						.range(-360,360)
						.speed(4)
						.freq(.2)
						.waveform(H.SINE)
						.currentStep(i)
					;
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	H.drawStage();
}
void saveVector() {
	PGraphics tmp = null;
	// tmp = beginRecord(PDF, "../output/render_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha 
	}

	endRecord();
}