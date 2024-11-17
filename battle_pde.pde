PImage box;
PImage bg;
PImage grid;
PImage mons1;
PFont pixel;
int health;
int attack,esccheck=0;
boolean esc = boolean(esccheck);

void  setup(){
size(1024,768);
bg = loadImage("bg.jpg");
grid = loadImage("ScreenGrid.png");
mons1 = loadImage("mons1.jpg");
imageMode(CORNER);
pixel = createFont("FUSION-PIXEL-PROPORTIONAL.TTF",12);
textFont(pixel);
}

void draw(){
image(bg,0,0,1024,768);
image(grid,0,0);
image(mons1,800,400,200,200);
fill(#979AF5);
stroke(#1119EA);
rect(50,600,400,100);
rect(600,600,400,100);
rect(0,0,100,70);
textSize(30);
fill(0, 408, 612);
text("生命值:",70,650);
text("攻擊力:",250,650);
text("生命值:",620,650);
text("攻擊力:",800,650);
textSize(50);
fill(245,27,93);
text("ESC",10,50);

if (mouseX>0&&mouseX<100&&mouseY>0&&mouseY<70&&esccheck==0&&mouseButton == LEFT){
    mouseClicked();
  }
}
void mouseClicked(){
   filter(BLUR,6);
    textSize(100);
    fill(0,0,0);
    text("暫停",300,300);
    textSize(80);
    text("Pause",300,400);

}
