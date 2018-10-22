import processing.pdf.*;

import hype.*;
import hype.extended.layout.HGridLayout;
import hype.extended.colorist.HColorPool;

int    stageW   = 1000;
int    stageH   = 1000;
color  clrBG    = #FFFFFF;
String pathDATA = "../../data/";

HColorPool    colors;
HDrawablePool pool;

void settings() {
	size(stageW,stageH);
}

void setup() {
	H.init(this).background(clrBG);

	colors = new HColorPool(#000000,#1563ff, #191A1C, #4C4F54, #7F858D, #B4B8BC).fillOnly();

	pool = new HDrawablePool(1000);
	pool.autoAddToStage()
		.add(new HShape(pathDATA + "d-50.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER), 5)
		.add(new HShape(pathDATA + "d-75.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER), 5)
		.add(new HShape(pathDATA + "d-50.02.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "d-75.02.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "d-50.03.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "d-75.03.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add(new HShape(pathDATA + "slant-right.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER),4)
		//.add(new HShape(pathDATA + "chevron.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		//.add(new HShape(pathDATA + "seeds.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		//.add(new HShape(pathDATA + "star.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		//.add(new HShape(pathDATA + "target.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		//.add(new HShape(pathDATA + "x-seed.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))

		.layout( new HGridLayout().startX(50).startY(50).spacing(100,100).cols(10) )

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

	//H.drawStage();
	saveVector();
	noLoop();
}

void draw() {
	H.drawStage();
}

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "output/render_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha 
	}

	endRecord();
}