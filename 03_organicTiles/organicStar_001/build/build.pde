import processing.pdf.*;
import hype.*;
import hype.extended.layout.HGridLayout;

// environment variables
int    stageW   = 1040;
int    stageH   = 640;
// 1440,900 - Mac screen resolution
color  clrBG    = #242424;
String pathDATA = "../../data/";

void settings() {
	size(stageW,stageH);
}

HDrawablePool pool;

void setup() {
	H.init(this).background(clrBG);

	pool = new HDrawablePool(55);
	pool.autoAddToStage()
		.add(
			new HShape(pathDATA + "star.svg")
			.enableStyle(false)
			.strokeJoin(CENTER)
			.strokeCap(CENTER)
			.anchorAt(H.CENTER)
		)

		.layout(
			new HGridLayout()
			.startX(70)
			.startY(70)
			.spacing(90,90)
			.cols(11)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.stroke(#999999)
						.fill(#999999)
						.rotation( ((int)random(45)) * 15 )
					;
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





