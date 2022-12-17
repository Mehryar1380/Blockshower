import processing.sound.*;

import camera3D.*;
import camera3D.generators.*;
import camera3D.generators.util.*;

import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;



import controlP5.*;
import peasy.*;
import java.util.Scanner;   

PeasyCam cam;
int x = 0;
int jump = 0;
int c =1;
int y =50;
float l =0;
float lo =0;
float spawnerX = random(100);
float spawnerY =500;
float spawnerZ = random(100);
boolean o =  false;
character c1;
canva  v ;
 house h;
 SoundFile file;
 PImage img;
 ArrayList <spawner>s;
 ArrayList<coins> tre;
 int score =0;
 
void setup(){
 img = loadImage("GameOver.png");
  size(1000,1000,P3D);

file = new SoundFile(this, "cameron.mp3");
  //background(0);
c1 = new character(x1,y1,z1);
 v = new canva();
 h = new house();
 s = new ArrayList<spawner>();
 tre = new ArrayList<coins>();
 file.play();
 
}
static float colisionground = 250/2 +5;
static float x1 = -50;
static float y1 =130;
static float z1 = 50;
int upd = 0;
void draw(){
  lights(); //adds some lighting to the cube
 fill(0, 408, 612, 816);
 float cameraY = height/3.0;
  
  float f = 500/float(width) * PI/2;

  float cameraZ = cameraY / tan(f / 2.0);
 
  float aspect = float(width)/float(height);
  perspective(f, aspect, cameraZ/10.0, cameraZ*10.0);
  translate(width/2+30, height/2, 0);
  rotateX(-PI/6);
  rotateZ(PI);
  rotateY(PI/3 + mouseX/float(height) * PI); //camera move
   rotateZ( mouseY/float(height) * PI); //camera move
 background(250);
 box(250);

int  p = 0;
  h = new house();
 pushMatrix();
   translate(c1.position.x,c1.position.y,c1.position.z);
   fill(180);
 box(25);
popMatrix();
   c1.update(upd,jump);
   spawnerX = random(500)-200; // spawner cordinates
   spawnerZ = random(500)-200; // spawn cordinates
 if(random(score+4.9) >4.8) s.add(new spawner(spawnerX,spawnerY,spawnerZ));
 
 
if(random(5.1) >4.6 && tre.size() < 500) { //only spawn less than 500 white blocks and at a certain chance
  tre.add(new coins(spawnerX,spawnerY,spawnerZ));

}


 for(int i = 0;i<s.size();i++){
    s.get(i).blockFall();
 pushMatrix();
    translate(s.get(i).position.x,s.get(i).position.y,s.get(i).position.z);
    fill(25);
    box(10);
   
    popMatrix();
     if(s.get(i).position.y <= -500){ // remove the black blocks once they pass the character to prevent lag
     s.remove(i);
   }
 
if(c1.position.y <= -500){
  file.stop();
    background(0);
 rotate(PI/6);
image(img,50,50);

textSize(128);
fill(0, 408, 612, 816);
text("score:" + score, -50, 150, 50);  // Specify a z-axis value

 println("Your Final score is: " +  score);
  
}
    
   // bottom if statement creates an event if the character collides witht he spawning white cubes
   if((s.get(i).position.y- c1.position.y  >= -14.5  && s.get(i).position.y- c1.position.y  <= 14.5)&& (s.get(i).position.x- c1.position.x  <= 14.5  && s.get(i).position.x- c1.position.x  >= -14.5) && (s.get(i).position.z- c1.position.z  <= 14.5  && s.get(i).position.z- c1.position.z  >= -14.5) ){
     
     c1.position.y =  -500;
     
   file.stop();
    background(0);
 // translate(width / 2, height / 2);
  beginShape();
  texture(img);
 rotate(PI/6);
  endShape();
  println("Your Final score is: " +  score);
   }
   
 }
for(int q =0; q< tre.size();q++){
  tre.get(q).move();
  pushMatrix();
    translate(tre.get(q).position.x,tre.get(q).position.y,tre.get(q).position.z);
    fill(180);
    box(10);
   
    popMatrix(); 
    // bottom if statement creates an event if the character collides witht he spawning white cubes
   if((tre.get(q).position.y- c1.position.y  >= -14.5  && tre.get(q).position.y- c1.position.y  <= 14.5)&& (tre.get(q).position.x- c1.position.x  <= 14.5  && tre.get(q).position.x- c1.position.x  >= -14.5) && (tre.get(q).position.z- c1.position.z  <= 14.5  && tre.get(q).position.z- c1.position.z  >= -14.5) ){
  score++;
  println("Your current score is: " +  score);
  tre.remove(q);
   }
   
   if(tre.get(q).position.y <= -500){ // removes the white blocks once they go too far down to prevent lag
     tre.remove(q);
     
   }
}

}

void keyPressed(){


  
   if(keyCode == UP ||keyCode == LEFT ){
 upd = 1;
 

  }
  else if(keyCode == DOWN || keyCode == RIGHT){
 upd = -1;
 
  }
  
}

void keyReleased(){


  
  if(keyCode == UP ||keyCode == RIGHT ){
 upd = 0;
 
  }
  else if(keyCode == DOWN || keyCode == LEFT){
 upd = 0;
  }


  
}


public class canva {
  canva(){
 
background(255);
rectMode(CENTER);
fill(51);
stroke(255);

  box(250);
 
 
  
  
 
 pushMatrix();

 rect(0,0,0,1000,1000);
 
  box(250);
  popMatrix();
 
  }
  
  
  
  
  
}
public class spawner{
 PVector vel = new PVector();
  PVector position = new PVector();
  
  spawner(float roughX,float roughY, float roughZ){
    position.x = roughX;
    position.y =  roughY;
    position.z = roughZ;
 
    
  }
 void blockFall(){
   position.add(vel);
 vel.y -= 1;
 if(random(10) > 1){
  vel.limit(1);
   position.add(vel);
   vel.x += sin(l) ;
   
   l+= PI/4;
 }

 
   
 }
  
  
  
}
public class coins{
 PVector vel = new PVector();
  PVector position = new PVector();
  
  coins(float roughX,float roughY, float roughZ){
    position.x = roughX;
    position.y =  roughY;
    position.z = roughZ;
 
    
  }
 void  move(){
   position.add(vel);
 vel.y -= 1;
 if(random(10) > 1){
  vel.limit(1);
   position.add(vel);
   vel.x += sin(lo)+ tan(lo) ;
   rotate(PI);
   lo+= PI/3;
 }

 
   
 }
  
  
  
}

public class house{
  
  house(){
   pushMatrix();
   translate(-50,130,-50);
      color(500,50,250);
   box(35);
popMatrix();
     pushMatrix();
   translate(50,130,-50);
      color(500,50,250);
   box(46);
 popMatrix();
  }
  
  
}


public class character{
  PShape b;
  PVector vel = new PVector();
  PVector position = new PVector();
  
  character(float x, float y, float z){
    position.x =x;
    position.z = z;
   position.y = y;
 
  
  
  }
  
   void  update(int pos,int acc){
       
    if(keyCode  == UP || keyCode == DOWN){
      if(position.x > colisionground || position.x < colisionground*-1){
         position.add(vel);
        vel.y -=1;
      }
    
    if(position.y ==colisionground && (position.x < colisionground || position.x > colisionground*-1)){
       if(pos == 0){
      vel.x = 0;
    }
       position.add(vel);
       vel.limit(1);
    vel.x += pos;
   
    }

    }  else if(keyCode == LEFT || keyCode == RIGHT){ 
       if(position.z > colisionground || position.z < colisionground*-1){
      position.add(vel);
        vel.y -=1;
        
      }
      
    if(pos == 0){
      vel.z = 0;
    }
     position.add(vel);
    vel.limit(1);
      vel.z += pos;
      
 
    } 
  }
  
}
