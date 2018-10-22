import processing.pdf.*;
import hype.*;
import hype.extended.behavior.HOscillator;
import hype.extended.colorist.HColorPool;
import hype.extended.layout.HPolarLayout;

int    stageW   = 1440;
int    stageH   = 900;
color  clrBG    = #242424;
String pathDATA = "../../data/";

HDrawablePool pool;
HColorPool    colors;

void settings() {
	size(stageW,stageH,P3D);
}

void setup() {
	H.init(this).background(clrBG).use3D(true);

	colors = new HColorPool(#FFFFFF);
	// colors = new HColorPool(#c4ff00, #015872, #50ac2d, #1c4c08, #59c18c);

	pool = new HDrawablePool(600);
	pool.autoAddToStage()
		.add(new HEllipse(8).anchorAt(H.CENTER))
		.add(new HRect(8).anchorAt(H.CENTER))

		.layout(
			new HPolarLayout(0.5, 40)
			.offset(width/2, height/2) // stage placement
			.scale(0.008)
		)
		.onCreate(
			 new HCallback() {
				public void run(Object obj) {
					int       i = pool.currentIndex();
					HDrawable d1 = (HDrawable) obj;
					HDrawable d2 = (HDrawable) obj;
					d1
						.noStroke()
						.fill(clrBG)
						// .stroke(#A88AB2)
						// .strokeWeight(2)
						// .fill(#ffffff)
						// .loc( (int)random(width), (int)random(height) )
						// .size( 256 + ((int)random(16)*4) )
						// .rotation( ((int)random(4)) * 45 )
						// .alpha(99)
					;
					d2
						// .noStroke()
						.stroke(#ff3300)
						// .fill(#ffffff)
						// .loc( (int)random(width), (int)random(height) )
						.size( 4+((int)random(4)*8) )
						// .rotation( ((int)random(2)) * 45 )
						// .alpha(60)
					;


					new HOscillator()
						.target(d1)
						.property(H.SCALE)
						.range(0,4)
						.speed(1)
						.freq(1)
						.waveform(H.SINE)
						.currentStep(i)
					;
					new HOscillator()
						.target(d2)
						.property(H.SCALE)
						.range(0,3)
						.speed(8)
						.freq(2)
						.waveform(H.SINE)
						.currentStep(i)
					;
					// new HOscillator()
					// 	.target(d1)
					// 	.property(H.ROTATION)
					// 	.range(180,-180)
					// 	.speed(1)
					// 	.freq(1)
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