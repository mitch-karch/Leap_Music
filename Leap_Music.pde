import beads.*;
import org.jaudiolibs.beads.*;

import de.voidplus.leapmotion.*;
import development.*;


LeapMotion leap;
AudioContext ac;
WavePlayer wp1, wp2;
Glide gainGlide, frequencyGlide1, frequencyGlide2;
int upperLimit=500;
void setup(){
    size(1000,500,OPENGL);
    background(255);
    
    leap = new LeapMotion(this);
    
    //Audio
    ac = new AudioContext();
    frequencyGlide1 = new Glide(ac, 20, 50);
    frequencyGlide2 = new Glide(ac, 20, 50);
    wp1 = new WavePlayer(ac, frequencyGlide1, Buffer.SINE);
    wp2 = new WavePlayer(ac, frequencyGlide2, Buffer.SINE);
    
    gainGlide = new Glide(ac, 0.0, 100);
    
    
    Gain g = new Gain(ac, 1, gainGlide);
    
    g.addInput(wp1);
    g.addInput(wp2);
    
    ac.out.addInput(g);
    ac.start();
}

void draw(){
  background(255);
  for( Hand hand: leap.getHands()){
    if(hand.isLeft()){
      hand.draw();
      gainGlide.setValue(map(hand.getStabilizedPosition().y,0,500,0,0.5));
      frequencyGlide1.setValue(map(hand.getStabilizedPosition().x,0,1000,0,upperLimit));
      println(hand.getStabilizedPosition().y);
    }
    else if(hand.isRight()){
      hand.draw();
      gainGlide.setValue(map(hand.getStabilizedPosition().y,0,500,0,0.5));
      frequencyGlide2.setValue(map(hand.getStabilizedPosition().x,0,1000,0,upperLimit));
    }
  }
  if(leap.getHands().size() == 0){
     frequencyGlide1.setValue(0);
     frequencyGlide2.setValue(0); 
    }
  text("Frequency1:"+frequencyGlide1.getValue(), 10,30);
  text("Frequency2:"+frequencyGlide2.getValue(), 10,50);
  //gainGlide.setValue(mouseX / (float)width);
}
