import processing.pdf.*;
import hype.*;
import hype.extended.layout.HGridLayout;

// ENVIRONMENT VARIABLES *************************************************
// Screen: 1440×900; Dribbble: 800×600; HD: 1920×1080 or 960×540)

int           stageW     = 800;
int           stageH     = 600;
color         clrBG      = #94BD00;
String        pathDATA   = "../../data/";

// LETS RENDER IMAGES ****************************************************

PGraphics hires;
int w = 600;
int h = 600;
int scaler = 6;

// ***********************************************************************

HCanvas       canvas;
HDrawablePool pool;

void settings() {
  size(w,h,P3D);
}

void setup() {
	hires = createGraphics(w*scaler,h*scaler,P3D);
	// H.init(this).background(clrBG).use3D(false).autoClear(false);
	//canvas = H.add(new HCanvas()); // additions for animations: .autoClear(true).fade(100)
	pool = new HDrawablePool(999);
}

void draw() {
  background(0);
  // insert all drawing code between beginDraw() and endDraw()
  hires.beginDraw(); // draw to off screen, HiRes canvas
  hires.clear();


	pool.autoAddToStage()
		.add(new HShape(pathDATA + "metaball--56.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "metaball--64.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "metaball--72.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "metaball--80.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.layout(new HGridLayout().startX(50).startY(50).spacing(100,100).cols(8))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d.stroke(#94BD00).strokeWeight(0).fill(#242424).alpha(98).rotation( ((int)random(4)) * 90 ).scale( ((int)random(6)) * .6 );
				}
			}
		)
		.requestAll()
	;


  hires.endDraw();
  image(hires,0,0,hires.width/scaler,hires.height/scaler); // scale HiRes canvas and draw to screen
}

void keyReleased() {
    if (key == 's'){
      hires.save("hires.png");
    }
}
