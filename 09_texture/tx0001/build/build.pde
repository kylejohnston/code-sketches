import hype.*;
import hype.extended.behavior.HOscillator;

int       stageW      = 1340;
int       stageH      = 800;

color     clrBG       = #CCCCCC;

String    pathDATA    = "../../data/";

// ********************************************************************************************************************

int    numAssets  = 100;
int    renderNum  = 0;
int    renderMax  = 2580;                    // how many frames to output
String renderPATH = "../output/1080x1920/";


// ********************************************************************************************************************

// TEXTURES

String[]  texNames    = {
"organics/star.png",    // 0
"organics/seeds.png",   // 1
"organics/slant.png",   // 2
"organics/chevron.png", // 3
};

int       texNamesLen = texNames.length;
PImage[]  texLoaded   = new PImage[texNamesLen];

// ********************************************************************************************************************

// COLOR FLOWS

String[]  clr_Strings = { "color_0_001.png", "color_0_002.png", "color_0_003.png" };
int[]     clr_Max     = {               300,               500,               700 };
int       clr_Len     = clr_Strings.length;

color[][] clr_Colors  = new color[clr_Len][];
int       clr_IntLen  = numAssets;
int[][]   clr_Int     = new int[clr_Len][clr_IntLen];

PImage[]  clr_PImage  = new PImage[clr_Len];

int       whichClr    = 2;

// ********************************************************************************************************************

// XYZ screen positions 

PVector[] pickedXYZ   = new PVector[numAssets];

PVector[] data1       = new PVector[numAssets]; // texture, scale, rotation

HOscillator[] oscR = new HOscillator[numAssets];
HOscillator[] oscZ = new HOscillator[numAssets];

// ********************************************************************************************************************

void settings() {
	size(stageW, stageH, P3D);
}

void setup(){
	H.init(this).background(clrBG).autoClear(true).use3D(true);
	textureMode(NORMAL);

	setupTEX(); // TEXTURES
	setupART(); // setup all properties for each visual asset
	setupColorFlow();  // COLOR FLOWS
}
 
void draw(){
	// background(clrBG);

	hint(DISABLE_DEPTH_TEST);
	hint(ENABLE_DEPTH_SORT);

	for (int i = 0; i < numAssets; ++i) {
		PVector pt = pickedXYZ[i];
		PVector _data1 = data1[i];

		HOscillator _oscR = oscR[i];
		_oscR.nextRaw();

		HOscillator _oscZ = oscZ[i];
		_oscZ.nextRaw();

		pushMatrix();
			translate(stageW/2, stageH/2, 0);

			pushMatrix();
				translate( pt.x, pt.y, pt.z + _oscZ.curr() );
				scale( (int)_data1.y );
				rotate(radians( (int)_data1.z + _oscR.curr() ));

				strokeWeight(0);
				noStroke();
				noFill();

				switch ((int)_data1.x) {
					case 0 :
						switch (whichClr) {
							case 0 : tint(#00FFFF, 225); break; // key press 1
							case 1 : tint(#FF3300, 225); break; // key press 2
							case 2 : 
								color c2 = clr_Colors[0][clr_Int[0][0]];
								tint(c2, 225);
							break; // key press 3
						}
						
					break;

					default :
						color c = clr_Colors[whichClr][clr_Int[whichClr][i%clr_Max[whichClr]]];
						tint(c, 225);
					break;
				}


				beginShape(QUADS);
					texture( texLoaded[ (int)_data1.x ] );
					vertex( -(0.5), -(0.5), 0,   0,0 );
					vertex(  (0.5), -(0.5), 0,   1,0 );
					vertex(  (0.5),  (0.5), 0,   1,1 );
					vertex( -(0.5),  (0.5), 0,   0,1 );
				endShape(CLOSE);

			popMatrix();

		popMatrix();
	}

	noTint();
	updateColorFlow(); // COLOR FLOWS
	surface.setTitle( int(frameRate) + " FPS" );

	// saveFrame(renderPATH + "/#########.tiff"); if (frameCount == renderMax) exit();

}

// ********************************************************************************************************************

// TEXTURES

void setupTEX() {
	for (int i = 0; i < texNamesLen; ++i) {
		PImage _temp = loadImage(pathDATA + texNames[i]);
		texLoaded[i] = _temp;
	}
}

// ********************************************************************************************************************

// setup all properties for each visual asset

void setupART() {
	for (int i = 0; i < numAssets; ++i) {
		PVector pt = new PVector();
		pt.x = (int)random( -(stageW/2), (stageW/2) );
		pt.y = (int)random( -(stageH/2), (stageH/2) );
		pt.z = (int)random( -300, 300 );
		pickedXYZ[i] = pt;

		PVector d1 = new PVector();
		d1.x = (int)random(texNamesLen); // which texture to use ?
		d1.y = (int)random( 100, 300 );  // which scale to use ?
		d1.z = (int)random( 360 );       // which rotation to use ?
		data1[i] = d1;

		oscR[i] = new HOscillator().range(-180, 180).speed( 0.1 + random(0.5) ).freq(1).currentStep(i);
		oscZ[i] = new HOscillator().range(-19000, 250).speed( 0.3 + random(0.2) ).freq(0.2).currentStep(i*0.1);
	}
}

// ********************************************************************************************************************

// COLOR FLOWS

void setupColorFlow() {
	for (int i = 0; i < clr_Len; ++i) {
		clr_PImage[i] = new PImage();
		clr_PImage[i] = loadImage(pathDATA + clr_Strings[i]);

		color[] tmpArray = new color[clr_Max[i]];
		clr_Colors[i] = tmpArray;

		for (int j = 0; j < clr_Max[i]; j++) {
			float tempPos = ((float)clr_PImage[i].width / clr_Max[i]) * j;
			clr_Colors[i][j] = clr_PImage[i].get( Math.round(tempPos), 1 );
		}

		for (int j = 0; j < clr_IntLen; j++) {
			clr_Int[i][j] = j%clr_Max[i];
		}
	}
}

void updateColorFlow() {
	for (int i = 0; i < clr_Len; ++i) {
		for (int j = 0; j < clr_IntLen; ++j) {
			int _tempNum = clr_Int[i][j];
			_tempNum++;
			if(_tempNum >= clr_Max[i]) _tempNum = 0;
			clr_Int[i][j] = _tempNum;
		}
	}
}

// ********************************************************************************************************************

void keyPressed() {
	switch (key) {
		case ' ': setupART(); break;
		case '1': whichClr = 0; break;
		case '2': whichClr = 1; break;
		case '3': whichClr = 2; break;
	}
}

// ********************************************************************************************************************


