PFont TCfont;
PImage startbotm;
PImage backbotm;
PImage creditbotm;
PImage controlbotm;
PImage mazebg;
PImage wall;
PImage fp;
int mode = 0;
int[][] monsterpoint = new int[4][2];
int[][] maze = new int[32][24]; // 迷宮陣列
int cellSize = 48; // 單格大小
int rows, cols;
int[][] mazecheck;
int playerX = 0, playerY = 0; // 角色起始位置
int moveX = 0, moveY = 0;     // 角色移動方向
int moveDelay = 50;          // 移動延遲（毫秒）
int lastMoveTime = 0;         // 上次移動的時間記錄
int nowmap = 1; // 當前地圖
int allmap = 3;  // 總地圖數量
boolean canMove=true,outofcheck=false;
//battle define start
PImage box;
PImage bg;
PImage grid;
PImage mons1;
PImage mons2;
PImage mons3;
PImage mons4;
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
int monsterfix=0;
boolean stop = false,battleset=true,Turn=true,battle=false,Alive=true,skillchoosetemp=false,restart=false,back=false,draw=false,plays=false,randmon=false,battlemusic=false; // Pause state
//battle define end

void setup() {
  file =new Minim(this);
  in = file.loadFile("ambitious.mp3");
  Ambitious = new Minim(this);
  at = Ambitious.loadFile("Alea.mp3");size(1024, 768);
  startbotm = loadImage("startbotm.png");
  backbotm = loadImage("backbotm.png");
  creditbotm = loadImage("creditbotm.png");
  controlbotm = loadImage("controlbotm.png");
  wall = loadImage("wall.PNG");
  mazebg = loadImage("background.png");
  TCfont = createFont("FUSION-PIXEL-PROPORTIONAL.TTF", 28);
  textFont(TCfont);
  cols = width / cellSize;
  rows = height / cellSize;
  maze = new int[rows][cols];
  mazecheck = new int[rows][cols];
  generateMaze();
  fp = loadImage("first.png");
  bg = loadImage("bg.jpg");
  grid = loadImage("ScreenGrid.png");
  mons1 = loadImage("mons1.jpg");
  pause1 = loadImage("Pause.png");
  mons2 = loadImage("mons2.jpg");
  mons3 = loadImage("mons3.jpg");
  mons4 = loadImage("mons4.jpg");
  randomSeed(0);
  
  imageMode(CORNER);
}
  
  void draw () {
  background(fp);
  if (mode == 0) {
    background(fp);
    fill(#42E9FA);
    textAlign(CENTER, BOTTOM);
    textSize(120); 
    text("數學地下城", 512, 260);
    imageMode(CORNER);
    image(startbotm, 403, 330);
    image(controlbotm, 403, 440);
    image(creditbotm, 403, 550);
    stroke(#0000FF);
    strokeWeight(6);
    textSize(28);
    if (mousePressed&&mouseX>=403 && mouseX <= 620 &&mouseY >= 330&&mouseY <= 430&&mode==0) 
        mode = 1;
        else if (mousePressed&&mouseX>=403 && mouseX <= 620 &&mouseY >= 440&&mouseY <= 540) 
        mode = 2;//打遊戲操作
       else if (mousePressed&&mouseX>=403 && mouseX <= 620 &&mouseY >= 550&&mouseY <= 650) 
        mode = 3;//打遊戲介紹
        //battle click end.
        else{
            println("點擊未命中任何按鈕");
            }
  }else if (mode == 1) {
    // 迷宮模式
    if (plays == false){
              playmaze();
              plays = true;
    }
    drawMaze();
        if(!randmon){
    randmoster();
    randmon = true;  
  }
  drawmonster();
    

    drawPlayer(); // 繪製角色
    movePlayer(); // 處理角色移動
    
  }else if (mode == 2){
    fill(#F00000);
    textSize(50);
    textAlign(TOP,LEFT);
    text("按向上鍵往上移動",300,200);
    text("按向下鍵往下移動",300,300);
    text("按向右鍵往右移動",300,400);
    text("按向左鍵往左移動",300,500);
    fill(0,0,0);
    rect(0,0,150,60);
    fill(#F00000);  
    text("返回",30,50);
    if (mousePressed&&mouseX>=0 && mouseX <= 150 &&mouseY >= 0&&mouseY <= 60&&mode==2){
    mode =0;
    }
 }
 else if (mode == 3){
    fill(0,0,0);
    rect(0,0,150,60);
    fill(#F00000);  
    textAlign(TOP,LEFT);
      textSize(50);
    text("返回",30,50);
    if (mousePressed&&mouseX>=0 && mouseX <= 150 &&mouseY >= 0&&mouseY <= 60&&mode==3){
    mode =0;
    }
 }
  else if (mode == 4) {
    // 遊戲結束畫面
    background(#000000);
    fill(#FFFFFF);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("遊戲結束！恭喜通關！", width / 2, height / 2);
  }else if (mode == 5){
    battle_start();
    mousePressed();
  }
       
  }

      
void drawPlayer() {
  fill(#00EAFF); // 角色顏色
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
    outofcheck=false;
    // 確保角色不移出迷宮邊界，並檢查是否撞牆
    for(int i=0;i<4;i++){
    if(monsterpoint[i][0]==newX&&monsterpoint[i][1]==newY){
    outofcheck = true;
    break;
    }
    }
    if (newX >= 0 && newX < cols && newY >= 0 && newY < rows && (maze[newY][newX]==0||outofcheck)) {
      playerX = newX;
      playerY = newY;
    }  
    if (playerX == cols - 1 && playerY == rows - 1) {
        nextLevel(); // 切換到下一張地圖
    }
    
    // 更新最後移動時間
    lastMoveTime = millis();
  }
  if(playerX==monsterpoint[0][0]&&playerY==monsterpoint[0][1]){
    
    mode =5;
    }
    if(playerX==monsterpoint[1][0]&&playerY==monsterpoint[1][1]){
    mode =5;
    }
    if(playerX==monsterpoint[2][0]&&playerY==monsterpoint[2][1]){
    mode =5;
    }
    if(playerX==monsterpoint[3][0]&&playerY==monsterpoint[3][1]){
    mode =5;
    }
}

void nextLevel() {
  if (nowmap < allmap) {
    nowmap++;  // 切換到下一張地圖
    levelfix++;
    generateMaze();
    // 生成新的迷宮
    drawMaze();
    playerX = 0;     // 重置角色位置
    playerY = 0;
    randmon = false;  
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
  if (keyCode == UP || key == 'w') {
    moveX = 0;
    moveY = -1;
    
  } else if (keyCode == DOWN||key == 's') {
    moveX = 0;
    moveY = 1;
  } else if (keyCode == LEFT||key == 'a') {
    moveX = -1;
    moveY = 0;
  } else if (keyCode == RIGHT||key == 'd') {
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
  int j = i+(int)random(4 - i);  // 隨機選擇索引 i 到 i+1 之間的值
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
       image(mazebg, j * cellSize, i * cellSize, cellSize, cellSize);// 路徑
      } else {
        image(wall,j* cellSize, i * cellSize, cellSize, cellSize);
        
        }
      }
    
  }
   fill(#00FF00);
  rect(0, 0, cellSize, cellSize); // 起點
fill(#FF0000);
  rect((cols - 1) * cellSize, (rows - 1) * cellSize, cellSize, cellSize); // 終點
  
}
  // 繪製起點與終點
void randmoster(){
  //路徑上生成怪物
  int r;
  int c;
      r =int(random(rows));
     c = int(random(cols));
    
    monsterpoint[0][0] = r;
    monsterpoint[0][1] = c;//判斷玩家是否觸碰怪物
    maze[r][c]=0;
    r =int(random(rows));
     c = int(random(cols));
     maze[r][c]=0;
     monsterpoint[1][0] = r;
     monsterpoint[1][1] = c;
     r =int(random(rows));
     c = int(random(cols));
    maze[r][c]=0;
     monsterpoint[2][0] = r;
     monsterpoint[2][1] = c;
   r =int(random(rows));
     c = int(random(cols));
     monsterpoint[3][0] = r;
     monsterpoint[3][1] = c;
   maze[r][c]=0;
  println(playerX ,playerY);
  println(r ,c);
  
}
void drawmonster(){
  image(mons1,monsterpoint[0][0]*cellSize,monsterpoint[0][1]*cellSize, cellSize, cellSize);
  image(mons2,monsterpoint[1][0]*cellSize,monsterpoint[1][1]*cellSize, cellSize, cellSize);
  image(mons3,monsterpoint[2][0]*cellSize,monsterpoint[2][1]*cellSize, cellSize, cellSize);
  image(mons4,monsterpoint[3][0]*cellSize,monsterpoint[3][1]*cellSize, cellSize, cellSize);
}
