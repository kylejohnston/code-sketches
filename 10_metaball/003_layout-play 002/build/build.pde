import processing.pdf.*;
import hype.*;
import dawesometoolkit.*;
import hype.extended.layout.HGridLayout;

// ENVIRONMENT VARIABLES *************************************************
// Screen: 1440×900; Dribbble: 800×600; HD: 1920×1080 or 960×540)

int             stageW     = 800;
int             stageH     = 600;
color           clrBG      = #94BD00;
String          pathDATA   = "../../data/";

// LETS RENDER IMAGES ****************************************************

int             renderMax  = 1800; // for animations, how many frames to output
String          renderPATH = "../output/";

// ***********************************************************************

HCanvas         canvas;
HDrawablePool   pool;
DawesomeToolkit dawesome;

void settings() {
	size(stageW,stageH);
}

void setup() {
	H.init(this).background(clrBG);
	smooth();
	canvas = H.add(new HCanvas()); // additions for animations: .autoClear(true).fade(100)
	dawesome = new DawesomeToolkit(this);
	dawesome.enableLazySave('s',".png");
}

void draw() {
	pool = new HDrawablePool(999);
	pool.autoParent(canvas)
		.add(new HShape(pathDATA + "metaball--56.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "metaball--64.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "metaball--72.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "metaball--80.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.layout(new HGridLayout().startX(50).startY(50).spacing(160,160).cols(16))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.stroke(#94BD00)
						.strokeWeight(0)
						.fill(#242424)
						// .alpha(100)
						.rotation( ((int)random(4)) * 90 )
						.scale( ((int)random(6)) * .6 )
					;
				}
			}
		)
		.requestAll()
	;
	// saveVector();
	noLoop();
	H.drawStage();
}

void keyReleased() {
	if (key == 'd'){
		background(clrBG);
		redraw();
		// updatePixels();
	}
}
