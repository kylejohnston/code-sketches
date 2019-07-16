import processing.pdf.*;
import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

// environment variables
int    stageW   = 1296;
int    stageH   = 864;
// 1440,900 - Mac screen resolution
color  clrBGD   = #252A2A;
color  clrBGL   = #F0F2ED;
color  clrBGB   = #4CC4D1;
String pathDATA = "../../data/72px/";

void settings() {
	size(stageW,stageH);
}

HColorPool    colors;
HDrawablePool pool;

void setup() {
	H.init(this).background(clrBGD);
//							SA-GR   SA-BL   SEA
	colors = new HColorPool(#C4C62F,#4CC4D1,#A1C8BB).fillOnly();

	pool = new HDrawablePool(200);
	pool.autoAddToStage()
		.add(new HShape(pathDATA + "angle.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "circle.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "bullseye.svg").enableStyle(true).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		// .add(new HShape(pathDATA + "sun-too.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))
		// .add(new HShape(pathDATA + "lines.svg").enableStyle(false).strokeJoin(CENTER).strokeCap(CENTER).anchorAt(H.CENTER))

		.layout(
			new HGridLayout()
			.startX(72)
			.startY(72)
			.spacing(96,96)
			.cols(13)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d.noStroke().fill(#000000).rotation( ((int)random(4)) * 90 ).scale( ((int)random(2)) * 1 );
					d.randomColors(colors);
				}
			}
		)
		.requestAll()
	;

	//H.drawStage();
	saveVector();
	noLoop();
}

void draw() {
	H.drawStage();
}

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "../######.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha 
	}

	endRecord();
}





