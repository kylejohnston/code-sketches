import processing.pdf.*;
import hype.*;
import hype.extended.layout.HGridLayout;

// ENVIRONMENT VARIABLES *************************************************
// Screen: 1440×900; Dribbble: 800×600; HD: 1920×1080 or 960×540)

int           stageW     = 800;
int           stageH     = 600;
color         clrBG      = #242424;
String        pathDATA   = "../../data/";

// LETS RENDER IMAGES ****************************************************

int           renderMax  = 1800; // for animations, how many frames to output
String        renderPATH = "../output/";

// ***********************************************************************

HCanvas       canvas;
HDrawablePool pool;

void settings() {
	size(stageW,stageH);
}

void setup() {
	H.init(this).background(clrBG).use3D(false).autoClear(false);
	canvas = H.add(new HCanvas()); // additions for animations: .autoClear(true).fade(100)

	pool = new HDrawablePool(384);

	pool.autoAddToStage()
		.add(new HShape(pathDATA + "metaball-001.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "metaball-002.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "metaball-003.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "metaball-004.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.layout(new HGridLayout().startX(50).startY(50).spacing(76,96).cols(16))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.stroke(#242424)
						.strokeWeight(0)
						.fill(#94BD00)
						.alpha(96)
						.rotation( ((int)random(4)) * 90 )
					;
				}
			}
		)
		.requestAll()
	;
	// H.drawStage();
	// saveVector();
	noLoop();
}

void draw() {
	H.drawStage();

	saveFrame(renderPATH + "frames/#########.tif"); if (frameCount == 1) exit();
}
