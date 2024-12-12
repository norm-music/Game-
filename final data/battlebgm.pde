import ddf.minim.*;
Minim file;
Minim Ambitious;
Minim Maze;
AudioPlayer at;
AudioPlayer in;

void playbattle()
{
  Ambitious = new Minim(this);
  at = Ambitious.loadFile("Alea.mp3");
  at.play();
}
void playmaze()
{
  file =new Minim(this);
  in = file.loadFile("ambitious.mp3");
  in.play();
}
void Mazestop()
{
  in.pause();
}
void Battlestop(){
 at.pause();  
}
void replay()
{
  at.pause();
  at = Ambitious.loadFile("Alea.mp3");
  at.play();
}
  
