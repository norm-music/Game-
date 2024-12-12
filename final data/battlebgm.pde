import ddf.minim.*;
Minim file;
Minim Ambitious;
Minim Maze;
AudioPlayer at;
AudioPlayer in;
void setup2(){
  
}
void playbattle()
{
 
  at.loop();
}
void playmaze()
{
  
  in.loop();
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
  
