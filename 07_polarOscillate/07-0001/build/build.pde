import processing.pdf.*;
import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HPolarLayout;
import hype.extended.layout.HHexLayout;

// ENVIRONMENT VARIABLES *************************************************
// Screen: 1440×900; Dribbble: 800×600; HD: 1920×1080 or 960×540)

int           stageW     = 1440;
int           stageH     = 900;
color         clrBG      = #FFFFFF;
String        pathDATA   = "../../data/";

// LETS RENDER IMAGES ****************************************************

boolean       letsRender = false;
int           renderNum  = 0;
int           renderMax  = 1800; // how many frames to output
String        renderPATH = "../output/1080x1920/";

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

	canvas = H.add(new HCanvas()).autoClear(false).fade(30);

	colors = new HColorPool(#FFFFFF);
	// colors = new HColorPool(#c4ff00, #015872, #50ac2d, #1c4c08, #59c18c);

	pool = new HDrawablePool(50);
	pool.autoParent(canvas)
		.add(new HRect(20).noStroke().fill(#000000).anchorAt(H.CENTER))
		// .add(new HRect(20).noStroke().fill(#000000).anchorAt(H.CENTER_X|H.BOTTOM))
		.add(new HEllipse(10).noStroke().fill(#000000).anchorAt(H.CENTER))
		.layout(new HHexLayout().spacing(10).offsetX(20).offsetY(0))
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int       i = pool.currentIndex();
					HDrawable d = (HDrawable) obj;
					d
						.noFill()
						.stroke(#232323)
						.strokeWeight(1)
					;
					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(4,20)
						.speed(1)
						.freq(4)
						.waveform(H.SINE)
						.currentStep(i)
					;
					new HOscillator()
						.target(d)
						.property(H.ROTATION)
						.range(360,-360)
						.speed(0.5)
						.freq(2)
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
	tmp = beginRecord(PDF, "../output/render_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha 
	}

	endRecord();
}