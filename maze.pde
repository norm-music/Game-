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

void setup() {
  size(1024, 768);
  startbotm = loadImage("startbotm.png");
  backbotm = loadImage("backbotm.png");
  creditbotm = loadImage("creditbotm.png");
  controlbotm = loadImage("controlbotm.png");
  mazebg = loadImage("wall.PNG");
  wall = loadImage("background.png");
  TCfont = createFont("NotoSansTC-Black.otf", 28);
  textFont(TCfont);
  cols = width / cellSize;
  rows = height / cellSize;
  maze = new int[rows][cols];
  mazecheck = new int[rows][cols];
  generateMaze();
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
void keyPressed() {
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
       image(wall, j * cellSize, i * cellSize, cellSize, cellSize); // 牆壁
      } else {
        image(mazebg, j * cellSize, i * cellSize, cellSize, cellSize); // 路徑
      }
    }
  }
  // 繪製起點與終點
  fill(#00FF00);
  rect(0, 0, cellSize, cellSize); // 起點
  fill(#FF0000);
  rect((cols - 1) * cellSize, (rows - 1) * cellSize, cellSize, cellSize); // 終點
}
