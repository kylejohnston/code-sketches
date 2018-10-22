//import processing.svg.*;
import hype.*;
import hype.extended.behavior.HTimer;
import hype.extended.layout.HGridLayout;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HRotate;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HPixelColorist;

int    stageW   = 1440;
int    stageH   = 900;
color  clrBG    = #202020;
String pathDATA = "../../data/";

//HColorPool colors;
HDrawablePool pool;

float ringScale = 600;
int   ringSteps = 5;

void settings() {
	size(stageW,stageH,P3D);
}

void setup() {
	H.init(this).background(clrBG).use3D(true);
	smooth();

	//colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #ff3300, #ff3300, #242424, #333333, #666666);
	final HPixelColorist colors = new HPixelColorist(pathDATA + "color.jpg")
	.fillOnly()
	// .strokeOnly()
	// .fillAndStroke()
	;


	pool = new HDrawablePool(128);
	pool.autoAddToStage()
		.add (
			new HShape(pathDATA + "star.svg")
		)

		.layout (
			new HGridLayout()
			.startX(width/2)
			.startY(height/2)
			.spacing(0,0)
			.cols(10)
		)

		.onCreate (
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						//.noStroke()
						.strokeWeight(1)
						.stroke(#202020)
						.noFill()
						//.fill( colors.getColor(i*250) )
						.size( ringScale )
						//.anchorAt(H.CENTER)
						// .anchorAt(H.TOP|H.LEFT)
						.anchorAt(H.TOP|H.RIGHT) // nice
						// .anchorAt(H.BOTTOM|H.RIGHT)
						// .anchorAt(H.BOTTOM|H.LEFT)
						// .anchorAt(H.LEFT|H.CENTER_Y)
						// .anchorAt(H.CENTER_X|H.TOP)
						// .anchorAt(H.RIGHT|H.CENTER_Y)
						// .anchorAt(H.CENTER_X|H.BOTTOM)
						.z(0)
					;
					colors.applyColor(d);


					ringScale = ringScale - ringSteps;
// VARIATION 1 - Rotate X, Y, Z, SCALE
					// new HOscillator().target(d).property(H.ROTATIONX).range(-360, 360).speed(0.1).freq(PI).waveform(H.SINE).currentStep(i);
					// new HOscillator().target(d).property(H.ROTATIONY).range(-360, 360).speed(0.125).freq(1).waveform(H.SINE).currentStep(i);
					// new HOscillator().target(d).property(H.ROTATIONZ).range(-360, 360).speed(0.05).freq(1).waveform(H.SINE).currentStep(i);
					// new HOscillator().target(d).property(H.SCALE).range(0.5, 2.0).speed(0.3).freq(5).waveform(H.SINE).currentStep(i);

// VARIATION 2 - Rotate Z, SCALE
					new HOscillator().target(d).property(H.ROTATIONZ).range(-540, 540).speed(0.05).freq(PI/2).currentStep(i);
					new HOscillator().target(d).property(H.SCALE).range(0.25, 4.0).speed(0.5).freq(5).currentStep(i);
				}
			}
		)

		.requestAll()
	;
}

void draw() {
	pointLight(50, 50, 50, 0, height/2, 500);
	pointLight(150, 150, 150, width/2, height/2, 500);

	H.drawStage();
	if (frameCount == 900) exit();
	//saveFrame("../frames/#########.svg"); if (frameCount == 300) exit();
}