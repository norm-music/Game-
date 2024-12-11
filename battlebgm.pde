import ddf.minim.*;
import processing.sound.*;
SoundFile file;
Minim Ambitious;
Minim Maze;
AudioPlayer at;

void playbattle()
{
  Ambitious = new Minim(this);
  at = Ambitious.loadFile("Alea.mp3");
  at.play();
}
void playmaze()
{
  file =new SoundFile(this,"ambitious.mp3");
  file.play();
}
void Mazestop()
{
  file.pause();
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
  
