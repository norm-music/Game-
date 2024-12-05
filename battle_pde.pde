PImage box;
PImage bg;
PImage grid;
PImage mons1;
PImage pause1;
PFont pixel;
int enemyHp=0,enemyATK=1;
int HP=10,enemyhealth=1;
int ATK=5,enemyattack;
int[] skill={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
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
boolean stop = false,battleset=true,Turn=true,battle=true,Alive=true; // Pause state


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
    text(ATK,170,430);
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
    if(enemyHp<=0){
    Alive = false;
    }
    if(!Turn&&millis()-atkdelay>1800)
     {
              
       if((millis()-atkdelay)<4000){
      text("-",300,300);
      text(enemyATK,340,300);
    }
    if((millis()-atkdelay)>4000){
    Turn = !Turn;
    HP = HP - enemyATK;
    }
     }
    if((millis()-atkdelay)<1500&&atking==1){
      text("-",600,300);
      text(ATK,640,300);
      
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
      for(int i=1; i< skillrow;i++)
      {
        for(int j = 0; j< 4 ;j++)
        rect(1-115+(i*skillxtap),500+(j*skillytap),200,50);
      }
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
      fill(0,0,0);
      rect(350,250,330,120);
      rect(350,400,330,120);
      rect(350,550,330,120);
      textAlign(CENTER, CENTER);
      println(skill1);
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
        text("+"+skill3,515,610);
        else
        text(skill3,510,610);
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
    enemyHp = enemyHp - ATK;
    Turn = !Turn;
  }
  if(mouseX > 525 && mouseX < 925 && mouseY > 550 && mouseY < 700 && mouseButton == LEFT&&battleset)
  {
    battleset = !battleset;
    skillline = skill.length;
    skillrow =0;
    while(skillline >= 0)
    {
      skillline -=4;
      skillrow++;
    }
    skillline +=4;
  }
   if(mouseX > 15 && mouseX < 90 && mouseY > 510 && mouseY < 570 && mouseButton == LEFT&&!battleset){
     battleset=!battleset;
   }
    if(mouseX > 350 && mouseX < 680 && mouseY > 330 && mouseY < 450 && mouseButton == LEFT&&enemyHp>=0&&!Alive&&battle)
  { rect(350,250,330,120);
      rect(350,400,330,120);
      rect(350,550,330,120);
  }
   if(mouseX > 350 && mouseX < 680 && mouseY > 400 && mouseY < 520 && mouseButton == LEFT&&enemyHp>=0&&!Alive&&battle)
 {
   
 }
    if(mouseX > 350 && mouseX < 680 && mouseY > 550 && mouseY < 670 && mouseButton == LEFT&&enemyHp>=0&&!Alive&&battle)
  {
    
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
