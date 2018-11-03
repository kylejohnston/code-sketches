import processing.pdf.*;
import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HPolarLayout;
import hype.extended.layout.HHexLayout;

// ENVIRONMENT VARIABLES *************************************************
// Screen: 1440×900; Dribbble: 800×600; HD: 1920×1080 or 960×540)

int           stageW     = 1920; //1440
int           stageH     = 1080;  // 900
color         clrBG      = #EFEFEF;
String        pathDATA   = "../../data/";

// LETS RENDER IMAGES ****************************************************
int           numAssets  = 100;
int           renderNum  = 0;
int           renderMax  = 900;                   // how many frames to output
String        renderPATH = "../output/1920x1080/";


// ***********************************************************************

HDrawablePool pool;
HCanvas       canvas;
HColorPool    colors;

void settings() {
	size(stageW,stageH);
}

// ^ draw light grey square in background, smaller than overall stage
void setup() {
	H.init(this).background(clrBG);

	canvas = H.add(new HCanvas()).autoClear(false).fade(10);

	colors = new HColorPool(#FFFFFF);
	// colors = new HColorPool(#c4ff00, #015872, #50ac2d, #1c4c08, #59c18c);

	pool = new HDrawablePool(50);
	pool.autoParent(canvas)
		// .add(new HRect(20).noStroke().fill(#000000).alpha(20).anchorAt(H.CENTER))
		.add(new HEllipse(20).stroke(#333333).strokeWeight(4).fill(#000000).alpha(20).anchorAt(H.CENTER))
		// .add(new HRect(20).noStroke().fill(#000000).anchorAt(H.CENTER_X|H.BOTTOM))
		.add(new HEllipse(10).stroke(#000000).strokeWeight(2).noFill().anchorAt(H.CENTER))
		.layout(new HHexLayout().spacing(10).offsetX(20).offsetY(0))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int       i = pool.currentIndex();
					HDrawable d = (HDrawable) obj;
					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(0,(int)random(64))
						.speed(1)
						.freq((int)random(8))
						.waveform(H.SINE)
						.currentStep(i)
					;
					new HOscillator()
						.target(d)
						.property(H.X)
						.range(200,1720)
						.speed(1)
						.freq(1)
						.waveform(H.SINE)
						.currentStep(i*3)
					;
					new HOscillator()
						.target(d)
						.property(H.Y)
						.range(0,1080)
						.speed(1)
						.freq(1)
						.waveform(H.SINE)
						.currentStep(i*2)
					;
					// new HOscillator()
					// 	.target(d)
					// 	.property(H.ROTATION)
					// 	.range(360,-360)
					// 	.speed(0.5)
					// 	.freq(2)
					// 	.currentStep(i)
					// ;
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