PImage box;
PImage bg;
PImage grid;
PImage mons1;
PImage pause1;
PFont pixel;
int health,enemyhealth=1;
int attack,enemyattack,deathtint=255;
boolean stop = false; // Pause state

void setup() {
  size(1024, 768);
  bg = loadImage("bg.jpg");
  grid = loadImage("ScreenGrid.png");
  mons1 = loadImage("mons1.jpg");
  pause1 = loadImage("Pause.png");
  imageMode(CORNER);
  pixel = createFont("FUSION-PIXEL-PROPORTIONAL .TTF", 12);
  textFont(pixel);
}

void draw() {
  if (!stop) {
    image(bg, 0, 0, 1024, 768);
    image(grid, 0, 0);
    fill(#979AF5);
    stroke(#1119EA);
    rect(50, 350, 400, 100);
    rect(600, 350, 400, 100);
    rect(0, 0, 100, 70);
    //image(mons1, 800, 150, 200, 200);
    textSize(30);
    fill(0, 408, 612);
    text("生命值:", 70, 390);
    text("攻擊力:", 70, 430);
    text("生命值:", 620, 390);
    text("攻擊力:", 620, 430);
    textSize(50);
    fill(245, 27, 93);
    text("ESC", 10, 50);
    fill(155,125,135);
    noStroke();
    rect(0,480,1200,400);
    fill(255,255,255);
    rect(50,150,200,200);
  }
  else
  {
    image(pause1, 0, 0);
    textSize(100);
    fill(255, 255, 255);
    text("暫停", 420, 300);
    textSize(80);
    text("Pause", 420, 400);
    fill(#979AF5);
    rect(0, 0, 100, 70);
    fill(245, 27, 93);
    textSize(40);
    text("繼續", 10, 50);
  }
  if(enemyhealth<=0) 
  {
  
  }
  else
  {
    
  }  
  if(stop)
  {
      
   if(deathtint>=10)
   {
     deathtint-=3;
     tint(255, 255, 255, deathtint);
      image(mons1, 800, 150, 200, 200);
     
   }
   
   
   else
   {
     tint(255,255,255,0);
     image(mons1, 800, 150, 200, 200);
     println(deathtint);
     deathtint =0;
  }
}}

void mousePressed() {
  if (mouseX > 0 && mouseX < 100 && mouseY > 0 && mouseY < 70 && mouseButton == LEFT) {
    stop = !stop; 
  }
  
}
