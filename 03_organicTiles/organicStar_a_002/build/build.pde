//import processing.pdf.*;
import hype.*;
import hype.extended.behavior.HTimer;
import hype.extended.layout.HGridLayout;
import hype.extended.colorist.HColorPool;
import hype.extended.behavior.HRotate;
import hype.extended.behavior.HOscillator;

// environment variables
int    stageW   = 1440;
int    stageH   = 900;
// 1440,900 - Mac screen resolution
color  clrBG    = #242424;
String pathDATA = "../../data/";

void settings() {
	size(stageW,stageH);
}

HCanvas c1;
HDrawablePool pool;
HTimer timer;


void setup() {
	H.init(this).background(clrBG);
	smooth();

	c1 = new HCanvas().autoClear(false).fade(5);
	H.add(c1);

	pool = new HDrawablePool(64);
	pool.autoParent(c1)
		.add(new HShape(pathDATA + "star.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		//.add(new HShape(pathDATA + "slant-right.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						//.stroke(#999999)
						.fill(#cecece)
						.loc( (int)random(width), (int)random(height) )
						.size( 25+((int)random(5)*25) )
						.rotation( ((int)random(45)) * 15 )
					;
					new HRotate(d, random(-2,2) );
					new HOscillator().target(d).property(H.SCALE).range(-1, 2).speed(0.5).freq(5).currentStep(pool.currentIndex());
				}
			}
		)
		//.requestAll()
	;
		timer = new HTimer()
		.numCycles( pool.numActive() )
		.interval(100)
		.callback(
			new HCallback() { 
				public void run(Object obj) {
					pool.request();
				}
			}
		)
	;
}

	//H.drawStage();
	//saveVector();
	//noLoop();


void draw() {
	H.drawStage();
	saveFrame("../output_#########.tif"); if (frameCount == 300) exit();
}

