PFont TCfont;
PImage startbotm;
PImage backbotm;
PImage creditbotm;
PImage controlbotm;
PImage mazebg;
PImage wall;
int mode = 0;
int[][] maze = new int[32][24]; // 迷宮陣列
int cellSize = 48; // 單格大小
int rows, cols;
int[][] mazecheck;
int playerX = 0, playerY = 0; // 角色起始位置
int moveX = 0, moveY = 0;     // 角色移動方向
int moveDelay = 200;          // 移動延遲（毫秒）
int lastMoveTime = 0;         // 上次移動的時間記錄
int nowmap = 1; // 當前地圖
int allmap = 3;  // 總地圖數量
boolean canMove=true;
//battle define start
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
boolean stop = false,battleset=true,Turn=true,battle=false,Alive=true,skillchoosetemp=false,restart=false,back=false; // Pause state
//battle define end

void setup() {
  size(1024, 768);
  startbotm = loadImage("startbotm.png");
  backbotm = loadImage("backbotm.png");
  creditbotm = loadImage("creditbotm.png");
  controlbotm = loadImage("controlbotm.png");
  wall = loadImage("wall.PNG");
  mazebg = loadImage("background.png");
  TCfont = createFont("NotoSansTC-Black.otf", 28);
  textFont(TCfont);
  cols = width / cellSize;
  rows = height / cellSize;
  maze = new int[rows][cols];
  mazecheck = new int[rows][cols];
  generateMaze();
  bg = loadImage("bg.jpg");
  grid = loadImage("ScreenGrid.png");
  mons1 = loadImage("mons1.jpg");
  pause1 = loadImage("Pause.png");
  imageMode(CORNER);
}
  
  void draw () {
  background(#FFFFFF);
  if (mode == 0) {
    background(#FFFFFF);
    fill(#0000FF);
    imageMode(CORNER);
    image(startbotm, 403, 330);
    image(controlbotm, 403, 440);
    image(creditbotm, 403, 550);
    stroke(#0000FF);
    strokeWeight(6);
    textSize(28);
  }else if (mode == 1) {
    // 迷宮模式
    drawMaze();
    drawPlayer(); // 繪製角色
    movePlayer(); // 處理角色移動
    
    if(battle){ //battle start
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
    fill(#161FF2);//攻擊跟技能的方塊顏色
    rect(75,550,400,150);//atk
    rect(525,550,400,150);//skill
    fill(#B8BBFA);
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
   // if (at.isPlaying())
  //        at.pause();
 //       else
  //        at.loop();
    image(pause1, 0, 0);
    textSize(100);
    fill(255, 255, 255);
    text("暫停", 420, 300);
    textSize(80);
    text("Pause", 420, 400);
    fill(#979AF5);
    rect(0, 0, 100, 70);
    rect(400, 0, 200, 70);
    rect(810, 0, 100, 70);
    fill(245, 27, 93);
    textSize(40);
    text("繼續", 10, 50);
    text("重新開始", 420, 50);
    text("放棄", 820, 50);
    
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
      fill(#161FF2);
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
  }
}//battle end


    
  }else if (mode == 4) {
    // 遊戲結束畫面
    background(#000000);
    fill(#FFFFFF);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("遊戲結束！恭喜通關！", width / 2, height / 2);
  }
}
    
  void mousePressed(){
        if (mouseX>=403 && mouseX <= 620 &&mouseY >= 330&&mouseY <= 430) 
        mode = 1;
        else if (mouseX>=403 && mouseX <= 620 &&mouseY >= 440&&mouseY <= 540) 
        mode = 2;//打遊戲操作
       else if (mouseX>=403 && mouseX <= 620 &&mouseY >= 550&&mouseY <= 650) 
        mode = 3;//打遊戲介紹
        if(battle){ //battle click start
          if (mouseX > 0 && mouseX < 100 && mouseY > 0 && mouseY < 70 && mouseButton == LEFT) {
    stop = !stop; 
  }
  if (stop==true){
     if (mouseX > 420 && mouseX < 520 && mouseY > 0 && mouseY < 70 && mouseButton == LEFT){
       stop = !stop;
       enemyHp=10;
       enemyATK=3;
       HP=10;
       ATK=0;
       //replay();
     }
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
   battle = false;
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
   
   
        }//battle click end
      }
      
void drawPlayer() {
  fill(#0000FF); // 角色顏色
  noStroke();
  rect(playerX * cellSize, playerY * cellSize, cellSize, cellSize);
}      

void movePlayer() {
  // 檢查是否達到移動延遲時間
  if (millis() - lastMoveTime >= moveDelay) {
    int newX = playerX + moveX;
    int newY = playerY + moveY;
    moveX=0;
    moveY=0;
    // 確保角色不移出迷宮邊界，並檢查是否撞牆
    if (newX >= 0 && newX < cols && newY >= 0 && newY < rows && maze[newY][newX] == 0) {
      playerX = newX;
      playerY = newY;
    }  
    if (playerX == cols - 1 && playerY == rows - 1) {
        nextLevel(); // 切換到下一張地圖
    }
    
    // 更新最後移動時間
    lastMoveTime = millis();
  }
}

void nextLevel() {
  if (nowmap < allmap) {
    nowmap++;  // 切換到下一張地圖
    generateMaze();  // 生成新的迷宮
    playerX = 0;     // 重置角色位置
    playerY = 0;
  } else {
    mode = 4; // 遊戲結束模式
  }
}
void keyReleased() {
  canMove = true;
}
void keyPressed() {
  if(canMove){
    canMove = false;
  if (keyCode == UP) {
    moveX = 0;
    moveY = -1;
    
  } else if (keyCode == DOWN) {
    moveX = 0;
    moveY = 1;
  } else if (keyCode == LEFT) {
    moveX = -1;
    moveY = 0;
  } else if (keyCode == RIGHT) {
    moveX = 1;
    moveY = 0;
  }
  
  }
}



void generateMaze() {
  // 初始化迷宮為牆壁
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      maze[i][j] = 1; // 設為牆
      mazecheck[i][j] = 1;
    }
  }
  
  // 生成迷宮路徑
  carvePath(0, 0);
  
  // 確保起點與終點是路徑
  maze[0][0] = 0;
  mazecheck[0][0] = 0;
  maze[rows - 1][cols - 1] = 0;
  mazecheck[rows - 1][cols - 1] = 0;
  // 檢查並修復終點是否被牆包圍
  ensureExitConnectivity();
}

// 檢查並修復終點是否可達
void ensureExitConnectivity() {
  int exitX = cols - 1;
  int exitY = rows - 1;

  // 終點周圍四個方向
  int[] dx = {-1, 1, 0, 0};
  int[] dy = {0, 0, -1, 1};

  boolean hasPath = false;

  // 檢查終點四周是否有通路
  for (int i = 0; i < 4; i++) {
    int nx = exitX + dx[i];
    int ny = exitY + dy[i];
    if (nx >= 0 && nx < cols && ny >= 0 && ny < rows && maze[ny][nx] == 0) {
      hasPath = true;
      break;
    }
  }

  // 如果沒有通路，挖通一條路
  if (!hasPath) {
    // 隨機選擇一個方向挖通
    for (int i = 0; i < 4; i++) {
      int nx = exitX + dx[i];
      int ny = exitY + dy[i];
      if (nx >= 0 && nx < cols && ny >= 0 && ny < rows) {
        maze[ny][nx] = 0; // 挖通路徑
        break;
      }
    }
  }
}

// 使用深度優先搜尋(DFS)來開闢迷宮
void carvePath(int x, int y) {
  maze[x][y] = 0; // 設定當前格子為通路
  mazecheck[x][y] = 0;
  
  int[] directions = {0, 1, 2, 3}; // 上、下、左、右
  int[] dx = {-1, 1, 0, 0};
  int[] dy = {0, 0, -1, 1};
  
  // 隨機打亂四個方向
 for (int i = 0; i < 4; i++) {
  int j = (int)random(i + 1);  // 隨機選擇索引 i 到 i+1 之間的值
  // 交換方向
  int temp = directions[i];
  directions[i] = directions[j];
  directions[j] = temp;
}

  // 深度優先搜尋
  for (int i = 0; i < 4; i++) {
    int nx = x + dx[directions[i]];
    int ny = y + dy[directions[i]];
    
    // 確保新位置在迷宮範圍內
    if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && maze[nx][ny] == 1) {
      if (countNeighbors(nx, ny) == 1) {
        carvePath(nx, ny); // 進一步遞歸
      }
    }
  }
}

// 計算相鄰格子的牆壁數量
int countNeighbors(int x, int y) {
  int count = 0;
  int[] dx = {-1, 1, 0, 0};
  int[] dy = {0, 0, -1, 1};
  for (int i = 0; i < 4; i++) {
    int nx = x + dx[i];
    int ny = y + dy[i];
    if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && maze[nx][ny] == 0) {
      count++;
    }
  }
  return count;
}

// 繪製迷宮
void drawMaze() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (maze[i][j] == 1) {
       image(mazebg, j * cellSize, i * cellSize, cellSize, cellSize); // 路徑
      } else {
        image(wall, j * cellSize, i * cellSize, cellSize, cellSize); // 牆壁
      }
    }
  }
  // 繪製起點與終點
  fill(#00FF00);
  rect(0, 0, cellSize, cellSize); // 起點
  fill(#FF0000);
  rect((cols - 1) * cellSize, (rows - 1) * cellSize, cellSize, cellSize); // 終點
}

//battle function
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
