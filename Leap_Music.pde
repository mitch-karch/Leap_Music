import beads.*;
import org.jaudiolibs.beads.*;

import de.voidplus.leapmotion.*;
import development.*;


LeapMotion leap;
AudioContext ac;
WavePlayer wp;
Glide gainGlide, frequencyGlide;

void setup(){
    size(1000,500,OPENGL);
    background(255);
    
    leap = new LeapMotion(this);
    
    //Audio
    ac = new AudioContext();
    frequencyGlide = new Glide(ac, 20, 50);
    wp = new WavePlayer(ac, frequencyGlide, Buffer.SINE);
    
    gainGlide = new Glide(ac, 0.0, 50);
    
    
    Gain g = new Gain(ac, 1, gainGlide);   
    g.addInput(wp);
    
    ac.out.addInput(wp);
    ac.out.addInput(g);
    ac.start();
}

void draw(){
  background(255);
  for( Hand hand: leap.getHands()){
    hand.draw();
    gainGlide.setValue(map(hand.getStabilizedPosition().y,0,500,0,.5));
    frequencyGlide.setValue(map(hand.getStabilizedPosition().x,0,1000,0,5000));
    println(hand.getStabilizedPosition().y);
  }
  text("Frequency:"+frequencyGlide.getValue(), 10,30);
  //gainGlide.setValue(mouseX / (float)width);
}
