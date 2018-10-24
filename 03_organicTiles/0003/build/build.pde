import processing.pdf.*;
import hype.*;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HGridLayout;

// environment variables
int    stageW   = 960;
int    stageH   = 960;
// 1440,900 - Mac screen resolution
color  clrBG    = #CCCCCC;
String pathDATA = "../../data/";

void settings() {
	size(stageW,stageH);
}

HColorPool    colors;
HDrawablePool pool;

void setup() {
	H.init(this).background(clrBG);

	colors = new HColorPool(#000000,#1563ff, #191A1C, #4C4F54, #7F858D, #B4B8BC).fillOnly();

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		//.add(new HShape(pathDATA + "star.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "target.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "x-seed.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		//.add(new HShape(pathDATA + "slant-right.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		/*.add(new HShape(pathDATA + "pointthin.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "polygon.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "polygonthin.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))*/
		//.add(new HShape(pathDATA + "art5.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		//.add(new HShape(pathDATA + "art6.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))

		.layout( new HGridLayout().startX(25).startY(25).spacing(100,100).cols(10) )

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d.strokeWeight(0).stroke(#000000).rotation( ((int)random(4)) * 90 );
					d.randomColors(colors);
				}
			}
		)
		.requestAll()
	;

	saveVector();
	noLoop();
}

void draw() {
	H.drawStage();
}

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "../output_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha 
	}

	endRecord();
}





