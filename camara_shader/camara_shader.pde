//https://thndl.com/

import android.view.MotionEvent;

import ketai.camera.*;
import ketai.sensors.*;

import frames.core.*;
import frames.primitives.*;
import frames.primitives.Vector;
import frames.processing.*;
import frames.input.*;
import frames.input.event.*;


KetaiCamera cam;
KetaiSensor sensor;
PVector magneticField;

boolean enabled = true;
PShader edges;
PShader toon;
PShader p1;
float light = 9;

Cscene scene;
OrbitShape[] models;
PShape[] cubes;
int[] positions;
int countCubes = 0;

void setup() { 
  fullScreen( P3D, 1 );//size(displayWidth, displayHeight, P3D);
  scene = new Cscene(this);
  scene.setRadius(max(width/4, height/4));
  
  println("w:"+width+"h"+height);
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  magneticField = new PVector();
  cubes = new PShape[200];
  positions = new int[400];
  imageMode(CENTER);
  orientation(LANDSCAPE); 
  cam = new KetaiCamera(this, 854, 480, 30);
  //noStroke();
  edges = loadShader("camara.glsl");
  
  textAlign(CENTER, CENTER);
  textSize(displayDensity * 28);
  
  OrbitShape eye = new OrbitShape(scene);
  scene.setEye(eye);
  scene.setDefaultGrabber(eye);
  scene.setFieldOfView(PI / 3);
  scene.fitBallInterpolation();

}

void draw() {
  background(0);
  stroke(1);  
  //shader(p1);
  for (int i = 0; i < countCubes; i++) {    
    shape(cubes[i], positions[i], positions[(i*2)+1]);
    //println(i+"show"+positions[i]+"|"+positions[(i*2)+1]);
  }
  
  if(cam.isStarted())
    image(cam, width/2, height/2);
  else
    cam.start();
    
  edges.set("light", light);
  shader(edges);
  /*
  text("MagneticField :" + "\n" 
    + "x: " + nfp(magneticField.x, 1, 2) + "\n"
    + "y: " + nfp(magneticField.y, 1, 2) + "\n" 
    + "z: " + nfp(magneticField.z, 1, 2) + "\n"
    + "Light Sensor : " + light + "\n" , 20, 0, width, height);*/
  
  
}

void onMagneticFieldEvent(float x, float y, float z, long time, int accuracy)
{
  magneticField.set(x, y, z);
}

void onCameraPreviewEvent(){
  cam.read();
}

void mousePressed() {
  if (mouseY>430){
    light = (1 - (mouseX*1.0/width*1.0))*2 + 7;
  }
  
  println(light);
  println(mouseX+"|"+mouseY+"-"+width+"|"+height);
  if (mouseX<680 && mouseX>190){
      if (mouseY>0 && mouseY<430){
        PShape caja = createShape(RECT, 0, 0, 50, 50);
        caja.setStroke(color(0, 255, 0));
        caja.setFill(color(0, 0, 0));
        cubes[countCubes] = caja;
        positions[countCubes*2] = mouseX;
        positions[(countCubes*2)+1] = mouseY;
        countCubes = countCubes + 1;
      }
  }
  //shape(caja, mouseX, mouseY);
}

PShape caja() {
  PShape caja = createShape(BOX, random(60, 100));
  caja.setStrokeWeight(3);
  caja.setStroke(color(random(0, 255), random(0, 255), random(0, 255)));
  caja.setFill(color(random(0, 255), random(0, 255), random(0, 255), random(0, 255)));
  return caja;
}
