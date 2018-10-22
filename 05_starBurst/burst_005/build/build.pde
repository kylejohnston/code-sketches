import hype.*;
import hype.extended.behavior.HTimer;
import hype.extended.layout.HGridLayout;
import hype.extended.colorist.HColorPool;
// import hype.extended.behavior.HRotate;
import hype.extended.behavior.HOscillator;
// import hype.extended.colorist.HPixelColorist;

int           stageW    = 1440;
int           stageH    = 900;
color         clrBG     = #520001;
String        pathDATA  = "../../data/";

HColorPool    colors;
HDrawablePool pool;

float         ringScale = 600;
int           ringSteps = 5;
boolean       recording = false;

void settings() {
	size(stageW,stageH,P3D);
}

void setup() {
	H.init(this).background(clrBG).use3D(true);
	smooth();

	//colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #ff3300, #ff3300, #242424, #333333, #666666);
	// colors = new HColorPool(#580301, #014636, #A30100, #D00000, #008980, #95421B);
	colors = new HColorPool(#8E0002, #FF5D00, #FD2900);
	//final HPixelColorist colors = new HPixelColorist("color.jpg")
	// .fillOnly()
	// .strokeOnly()
	// .fillAndStroke()
	// ;


	pool = new HDrawablePool(128);
	pool.autoAddToStage()
		.add (
			new HShape(pathDATA + "star.svg")
		)

		.layout (
			new HGridLayout()
			.startX(width/2)
			.startY(height/2)
			.spacing(0,0)
			.cols(10)
		)

		.onCreate (
			 new HCallback() {
				public void run(Object obj) {
					int    i = pool.currentIndex();
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						// .noStroke()
						.strokeWeight(2)
						.stroke(#520001)
						// .noFill()
						.fill( colors.getColor(i*250) )
						.size( ringScale )
						.anchorAt(H.CENTER)
						.z(100)
					;

					ringScale = ringScale - ringSteps;
// VARIATION 1 - Rotate X, Y, Z, SCALE
					new HOscillator().target(d).property(H.ROTATIONX).range(-360, 360).speed(0.125).freq(1).waveform(H.SINE).currentStep(i);
					new HOscillator().target(d).property(H.ROTATIONY).range(-360, 360).speed(0.25).freq(1).waveform(H.SINE).currentStep(i);
					new HOscillator().target(d).property(H.ROTATIONZ).range(-360, 360).speed(0.125).freq(1).waveform(H.SINE).currentStep(i);
					new HOscillator().target(d).property(H.SCALE).range(0.25, 1.0).speed(0.25).freq(1).waveform(H.SINE).currentStep(i);

// VARIATION 2 - Rotate Z, SCALE
					// new HOscillator().target(d).property(H.ROTATIONZ).range(-540, 540).speed(0.05).freq(PI/2).currentStep(i);
					// new HOscillator().target(d).property(H.SCALE).range(0.25, 4.0).speed(0.5).freq(5).currentStep(i);
				}
			}
		)

		.requestAll()
	;
}

void draw() {
	H.drawStage();
// }

  // If we are recording call saveFrame!
  // The number signs (#) indicate to Processing to 
  // number the files automatically
  if (recording) {
    saveFrame("output/frames####.png");
  }
  // Let's draw some stuff to tell us what is happening
  // It's important to note that none of this will show up in the
  // rendered files b/c it is drawn *after* saveFrame()
  textAlign(CENTER);
  fill(255);
  if (!recording) {
    text("Press r to start recording.", width/2, height-100);
  } 
  else {
    text("Press r to stop recording.", width/2, height-100);
  }
  
  // A red dot for when we are recording
  stroke(255);
  if (recording) {
    fill(255, 0, 0);
  } else { 
    noFill();
  }
  ellipse(width/2, height-150, 16, 16);
}

void keyPressed() {
  // If we press r, start or stop recording!
  if (key == 'r' || key == 'R') {
    recording = !recording;
  }
}
