import ddf.minim.*;
Minim Ambitious;
AudioPlayer at;
void play()
{
  Ambitious = new Minim(this);
  at = Ambitious.loadFile("Alea.mp3");
  at.play();
}
void stop()
{
  at.close();
  Ambitious.stop();
}
void replay()
{
  at.pause();
  at = Ambitious.loadFile("ambitious  (short).mp3");
  at.play();
}
  
