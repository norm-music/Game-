PImage box;
PImage bg;
PImage grid;
PImage mons1;
PImage pause1;
PFont pixel;
int enemyHp=10,enemyATK=3;
int HP=10;
int ATK=0;
int[] skillarray={0,-1,-1,-1};
int[] skillplus={5,0,0,0};
int[] skillmult={3,1,1,1};
int[] skillready={1,1,1,1};
int skill1;
int skill2;
int skill22;
int skill3;
int skill2type;
int levelfix;
int atkdelay;
int atkdelay2;
int atking;
int skillline;
int skillxtap=215;
int skillytap=65;
int skillrow =0;
int awardtemp=0;
int skillchoose =0;
int finalatk = ATK;
int skillnum;
boolean stop = false,battleset=true,Turn=true,battle=true,Alive=true,skillchoosetemp=false; // Pause state


void setup() {
  size(1024, 768);
  bg = loadImage("bg.jpg");
  grid = loadImage("ScreenGrid.png");
  mons1 = loadImage("mons1.jpg");
  pause1 = loadImage("Pause.png");
  imageMode(CORNER);
  pixel = createFont("FUSION-PIXEL-PROPORTIONAL.TTF", 12);
  textFont(pixel);
}

void draw() {
  if(battle){
  if (!stop&&Alive) {
    
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
    text(enemyHp,720,390);//enemy show
    text(enemyATK,720,430);
    text(HP,170,390);//main show
    text(finalatk,170,430);
    text("生命值:", 70, 390);
    text("攻擊力:", 70, 430);
    text("生命值:", 620, 390);
    text("攻擊力:", 620, 430);
    textSize(50);
    fill(245, 27, 93);
    text("ESC", 10, 50);
    fill(155,125,135);
    noStroke();
    rect(0,480,1200,400);//atk skill bg
    fill(255,255,0);//main
    rect(50,150,200,200);
    if(enemyHp<=0||HP<=0){
    Alive = false;
    }
    if(!Turn&&millis()-atkdelay>1800)
     {
              
       if((millis()-atkdelay)<2700){
      text("-",300,300);
      text(enemyATK,340,300);
    }
    if((millis()-atkdelay)>2700){
    Turn = !Turn;
    HP = HP - enemyATK;
    }
     }
    if((millis()-atkdelay)<1500&&atking==1){
      text("-",600,300);
      text(finalatk,640,300);
      
    }
    else
  {
  atking = 0;
  }
    if(battleset)
    {
    fill(80,90,100);
    rect(75,550,400,150);//atk
    rect(525,550,400,150);//skill
    fill(99,50,99);
    textSize(100);
    text("攻擊",175,650);
    text("技能",625,650);
    }
    else
    {
      rect(15,510,75,60);
      fill(255,0,0);
      textSize(30);
      text("返回",25,550);
      fill(80,90,100);
      rect(15,680,75,60);
      fill(0,255,0);
      textSize(30);
      text("確定",25,720);
      fill(80,90,100);
      rect(1-115+(1*skillxtap),500+(0*skillytap),200+skillxtap,50+skillytap);
      rect(1-115+(1*skillxtap),500+(2*skillytap),200+skillxtap,50+skillytap);
      rect(1-115+(3*skillxtap),500+(0*skillytap),200+skillxtap,50+skillytap);
      rect(1-115+(3*skillxtap),500+(2*skillytap),200+skillxtap,50+skillytap);
      fill(255,255,255);
      for(int i=0;i<2;i+=2){
      for(int j=0;j<2;j++){
      if(skillarray[i+j]==1)
    {
      text("x"+skillmult[i+j]+"+"+skillplus[i+j],1-115+(2*j+1)*skillxtap+150,500+(i*skillytap)+70);
  
    }
    if(skillarray[i+j]==0)
    {
      text("+"+skillplus[i+j]+"x"+skillmult[i+j],1-115+(2*j+1)*skillxtap+150,500+(i*skillytap)+70);
    }
      }
      }
      fill(80,90,100);
    }
  }
  if(stop&&enemyHp>0) 
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
  if(enemyHp>0&&!stop) 
  {
  image(mons1, 800, 150, 200, 200);
  }
  else
  {
    
  }  
  if(battle&&!Alive)
  {
      if(enemyHp<=0)
      {
        
        background(100,149,237);
        image(grid,0,0);
        text("勝利",512,150);
        if(awardtemp==0)
        {
          award();
          awardtemp=1;
      }
      if(skillchoose==0){
      fill(0,0,0);
      rect(350,250,330,120);
      rect(350,400,330,120);
      rect(350,550,330,120);
      textAlign(CENTER, CENTER);
      textSize(80);
      fill(255,255,255);
      if(skill1>=0)
      text("+"+skill1,515,310);
      if(skill1<0)
      text(skill1,515,310);
      if(skill2type==1){
        text("x"+skill2,350+70,460);
        if(skill22>=0)
        text("+"+skill22,550,460);
        else
        text(skill22,550,460);
      }
       if(skill2type==0){
        text("x"+skill2,550,460);
        if(skill22>=0)
        text("+"+skill22,420,460);
        else
        text(skill22,420,460);
      }
      if(skill3>=0)
        text("+"+skill3+"",515,610);
        else
        text(skill3,510,610);
    }
    if(skillchoose>0)
    {
    background(100,149,237);
        image(grid,0,0);
      rect(15,510,75,60);
      fill(255,0,0);
      textSize(30);
      text("返回",50,540);
      
      
      fill(80,90,100);
      rect(1-115+(1*skillxtap),500+(0*skillytap),200+skillxtap,50+skillytap);
      rect(1-115+(1*skillxtap),500+(2*skillytap),200+skillxtap,50+skillytap);
      rect(1-115+(3*skillxtap),500+(0*skillytap),200+skillxtap,50+skillytap);
      rect(1-115+(3*skillxtap),500+(2*skillytap),200+skillxtap,50+skillytap);
      fill(255,255,255);
      for(int i=0;i<3;i+=2){
      for(int j=0;j<2;j++){
      if(skillarray[i+j]==1)
    {
      text("x("+skillmult[i+j]+")+("+skillplus[i+j]+")",1-115+(2*j+1)*skillxtap+150,500+(i*skillytap)+70);
  
    }
    if(skillarray[i+j]==0)
    {
      text("+("+skillplus[i+j]+")x("+skillmult[i+j]+")",1-115+(2*j+1)*skillxtap+150,500+(i*skillytap)+70);
    }
      }
      }
    }
      }
      if(HP<=0)
      {
         background(0,0,0);
         fill(255,0,0);
         text("GAME OVER",250,150);
      }
      if(skillchoosetemp)
      {
      battle = !battle;
    }
  }
}
}
void mousePressed() {
  if (mouseX > 0 && mouseX < 100 && mouseY > 0 && mouseY < 70 && mouseButton == LEFT) {
    stop = !stop; 
  }
  if(mouseX > 75 && mouseX < 475 && mouseY > 550 && mouseY < 700 && mouseButton == LEFT&&battleset&&Turn)
  {
    atking=1;
    atkdelay = millis();
    println(atkdelay);
    enemyHp = enemyHp - finalatk;
    Turn = !Turn;
  }
  if(mouseX > 525 && mouseX < 925 && mouseY > 550 && mouseY < 700 && mouseButton == LEFT&&battleset)
  {
    battleset = !battleset;
    
  }
   if(mouseX > 15 && mouseX < 90 && mouseY > 510 && mouseY < 570 && mouseButton == LEFT&&!battleset)
   {
     battleset=!battleset;
     finalatk = ATK;
     skillready[0]=1;
     skillready[1]=1;
     skillready[2]=1;
     skillready[3]=1;
   }//返回
   
   if(mouseX > 15 && mouseX < 90 && mouseY > 680 && mouseY < 740 && mouseButton == LEFT&&!battleset)
   {
     battleset=!battleset;
   }//確定
   
 
  if(mouseX > 15 && mouseX < 90 && mouseY > 510 && mouseY < 570 && mouseButton == LEFT&&enemyHp<=0&&!Alive&&battle&&skillchoose>0)
  {
   skillchoose=0;
  }
  
  if(mouseX >1-115+(1*skillxtap) && mouseX < 1-115+(1*skillxtap)+200+skillxtap && mouseY > 500+(0*skillytap) && mouseY < 500+(0*skillytap)+50+skillytap && mouseButton == LEFT&&enemyHp<=0&&!Alive&&battle&&skillchoose>0)
   {
     if(skillchoose==1)
   {
      skillarray[0]=0;
      skillplus[0]=skill1;
      skillmult[0]=1;
   }
   if(skillchoose==2)
   {
      skillarray[0]=skill2type;
      skillplus[0]=skill22;
      skillmult[0]=skill2;
   }
   if(skillchoose==3)
   {
      skillarray[0]=0;
      skillplus[0]=skill3;
      skillmult[0]=1;
   }
   skillchoosetemp = true;
   }
    if(mouseX >1-115+(3*skillxtap) && mouseX < 1-115+(3*skillxtap)+200+skillxtap && mouseY > 500+(0*skillytap) && mouseY < 500+(0*skillytap)+50+skillytap && mouseButton == LEFT&&enemyHp<=0&&!Alive&&battle&&skillchoose>0)
   {
     if(skillchoose==1)
   {
      skillarray[1]=0;
      skillplus[1]=skill1;
      skillmult[1]=1;
   }
   if(skillchoose==2)
   {
      skillarray[1]=skill2type;
      skillplus[1]=skill22;
      skillmult[1]=skill2;
   }
   if(skillchoose==3)
   {
      skillarray[1]=0;
      skillplus[1]=skill3;
      skillmult[1]=1;
   }
   skillchoosetemp = true;
   }
     if(mouseX >1-115+(1*skillxtap) && mouseX < 1-115+(1*skillxtap)+200+skillxtap && mouseY > 500+(2*skillytap) && mouseY < 500+(2*skillytap)+50+skillytap && mouseButton == LEFT&&enemyHp<=0&&!Alive&&battle&&skillchoose>0)
   {
     if(skillchoose==1)
   {
      skillarray[2]=0;
      skillplus[2]=skill1;
      skillmult[2]=1;
   }
   if(skillchoose==2)
   {
      skillarray[2]=skill2type;
      skillplus[2]=skill22;
      skillmult[2]=skill2;
   }
   if(skillchoose==3)
   {
      skillarray[2]=0;
      skillplus[2]=skill3;
      skillmult[2]=1;
   }
   skillchoosetemp = true;
   }
     if(mouseX >1-115+(3*skillxtap) && mouseX < 1-115+(3*skillxtap)+200+skillxtap && mouseY > 500+(2*skillytap) && mouseY < 500+(2*skillytap)+50+skillytap && mouseButton == LEFT&&enemyHp<=0&&!Alive&&battle&&skillchoose>0)
   {
     if(skillchoose==1)
   {
      skillarray[3]=0;
      skillplus[3]=skill1;
      skillmult[3]=1;
   }
   if(skillchoose==2)
   {
      skillarray[3]=skill2type;
      skillplus[3]=skill22;
      skillmult[3]=skill2;
   }
   if(skillchoose==3)
   {
      skillarray[3]=0;
      skillplus[3]=skill3;
      skillmult[3]=1;
   }
   skillchoosetemp = true;
   }
      if(mouseX > 350 && mouseX < 680 && mouseY > 250 && mouseY < 370 && mouseButton == LEFT&&enemyHp<=0&&!Alive&&battle&&skillchoose==0)
  {
    skillchoose=1;
  }
   if(mouseX > 350 && mouseX < 680 && mouseY > 400 && mouseY < 520 && mouseButton == LEFT&&enemyHp<=0&&!Alive&&battle&skillchoose==0)
 {
   skillchoose=2;
 }
    if(mouseX > 350 && mouseX < 680 && mouseY > 550 && mouseY < 670 && mouseButton == LEFT&&enemyHp<=0&&!Alive&&battle&&skillchoose==0)
  {
   skillchoose=3;
  }
  
   if(mouseX >1-115+(1*skillxtap) && mouseX < 1-115+(1*skillxtap)+200+skillxtap && mouseY > 500+(0*skillytap) && mouseY < 500+(0*skillytap)+50+skillytap && mouseButton == LEFT&&!battleset&&skillready[0]==1&&Alive)
 {
   skillready[0]=0;
   skilluse(0);
  println("1");
 }
 if(mouseX >1-115+(3*skillxtap) && mouseX < 1-115+(3*skillxtap)+200+skillxtap && mouseY > 500+(0*skillytap) && mouseY < 500+(0*skillytap)+50+skillytap && mouseButton == LEFT&&!battleset&&skillready[1]==1&&Alive)
 {
   skillready[1]=0;
   skilluse(1);
  println("1");
 }
 if(mouseX >1-115+(1*skillxtap) && mouseX < 1-115+(1*skillxtap)+200+skillxtap && mouseY > 500+(2*skillytap) && mouseY < 500+(2*skillytap)+50+skillytap && mouseButton == LEFT&&!battleset&&skillready[2]==1&&Alive)
 {
   skillready[2]=0;
   skilluse(2);
  println("1");
 }
 if(mouseX >1-115+(3*skillxtap) && mouseX < 1-115+(3*skillxtap)+200+skillxtap && mouseY > 500+(2*skillytap) && mouseY < 500+(2*skillytap)+50+skillytap && mouseButton == LEFT&&!battleset&&skillready[3]==1&&Alive)
 {
   skillready[3]=0;
   skilluse(3);
  println("1");
 }
   
   
}
  
  
    void award(){
    while(skill1==0) 
    {
    if((int)random(10)%3==0)
  skill1 = (int)random(-levelfix-20,-levelfix);
  else
  skill1 = (int)random(levelfix,levelfix+10);
    }
    while(skill2==0)
    {
  if(random(10)%2==0)
  skill2 = (int)random(-levelfix/3-3,-levelfix/4-1);
  else
  skill2 = (int)random(levelfix/5+1,levelfix/4+3);
    }
  if((int)random(10)%2==0)
  skill22 = (int)random(-levelfix-10,-levelfix);
  else
  skill22 = (int)random(levelfix,levelfix+7);
  if(random(10)%2==0)
  skill3 = (int)random(-levelfix*levelfix+20,-levelfix);
  else
  skill3 = (int)random(levelfix,levelfix*(levelfix-1)+10);
  skill2type = (int)random(10)%2;
  }
  
  void skilluse(int num)
  {
  if(skillarray[num]==0){
  finalatk = (finalatk + skillplus[num])*skillmult[num];
  }
  
  if(skillarray[num]==1){
  finalatk = (finalatk * skillmult[num])+skillplus[num];
  }
  }
