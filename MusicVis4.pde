import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

int R = 0;
int G = 0;
int trail = 30;

AudioPlayer song;
BeatDetect beat;
Minim minim;

void setup()
{
  size(1000, 1000, P3D);
  background(0);
  smooth();  

  minim = new Minim(this);
  song = minim.loadFile("Breathing.mp3", 1024);
  song.loop();
  beat = new BeatDetect();
}

void draw()
{
   noStroke();
   fill(0, 0, 0, trail);
   rect(0, 0, width, height);
  float time = millis()/1000.0;

  beat.detectMode(BeatDetect.FREQ_ENERGY);
  beat.detect(song.mix);

  translate(500, 500, 0);
  rotateX(cos(time / 2));
  rotateY(sin(time / 2));
  rotateZ(cos(time / 2) + sin(time / 2));

  if (beat.isKick())
  {
    stroke(255, 0, 0);
    noFill();
    pushMatrix();
    rotateX(sin(time) + cos(time));
    rotateY(cos(time));
    rotateZ(atan(time));
    box(300);
    popMatrix();
    
    trail = 1;
  }

  if (beat.isSnare())
  {
    stroke(0, 255, 0);
    noFill();
    pushMatrix();
    rotateX(tan(time));
    rotateY(time);
    rotateZ(cos(time));
    box(100);
    popMatrix();
  }
  stroke(R, G, 255);
  noFill();
  box(400);
  
  trail = 30;
}

