ArrayList<Particle> list; // da list
int n, dx, gBestx, gBesty;
double gBest, worst;

void setup(){
  
  size(1000, 1000);
  n = 10; // the amount of particles in one axis 
  dx = width/n; // dx 
  list = new ArrayList<Particle>(n*n); // list of particles
  createParticles(list);
  gBestx = 0;
  gBesty = 0;
  gBest = calculateFunc(gBestx,gBesty);
  frameRate(30);
  
}

void draw(){
  
  // creates white background
  background(255);
  
  // draws lines
  stroke (230);
  for (int i = 0; i < width; i+= 50){
    line(i, 0, i, height);
    line(0, i, width, i);
  }
  
  
  // draw main lines
  stroke(0);
  line(0, height/2, height, height/2);
  line(width/2, 0, width/2, width);
  
  for (Particle l : list){
    l.display();
  }
  
}

// Creates the list of particles
void createParticles(ArrayList<Particle> list){
  
  for(int i = 0; i <= n; i++){
    for (int j = 0; j <= n; j++){
      list.add(new Particle(i*dx, j*dx));
    }
  }
}

double calculateFunc(int x, int y){
  if (x > 1000 || x < 0 || y > 1000 || y < 0){
    return 10000;
  } 
  int px = x - 500;
  int py = y - 500;
  
  // return ((sin(px/100) + cos(py/100))*100000)+(px*px)+(py*py);
  return cos(px/20)*10000 * (py*py);
}

public class Particle{
  double pb, vx, vy;
  int x, y, pbx, pby, c;
  
  public Particle(int x, int y){
    this.x = x;
    this.y = y;
    pbx = x;
    pby = y;
    c = 255;
    
    // best known position is here
    pb = calculateFunc(x,y);
    if (pb <= gBest){ // best known global solution
      gBest = pb;
      gBestx = pbx;
      gBesty = pby;
    }
    
    // worst
    if (pb > worst){
      worst = pb;
    }
    
    // random starting velocity
    vx = random(-20, 20);
    vy = random(-20, 20);
    
  }
  
  void display(){
    update();
    fill(255-c,255-c,255-c);
    stroke(0,0,0);
    ellipse(x, y, 10, 10);
  }
  
  void update(){
    this.vx = ((1-(1/(abs(gBestx-x)+1)))*vx)+((.0*random(0,1)*(gBestx - x)) + (.1*random(0,1)*(pbx - x)));
    this.vy = ((1-(1/(abs(gBesty-y)+1)))*vy)+((.0*random(0,1)*(gBesty - y)) + (.1*random(0,1)*(pby - y)));
    x += vx;
    y += vy;
    double temp = calculateFunc(x,y);
    
    if (temp > worst){
      worst = pb;
    }
    
    if (temp <= pb){
      pb = temp;
      pbx = x;
      pby = y;
    }
    
    if (pb <= gBest){
      gBest = pb;
      gBestx = pbx;
      gBesty = pby;
    }
    
    c = (int)(255*(temp-gBest)/(worst-gBest));
    
    System.out.println(pb + " " + pbx + " " + pby);
    System.out.println(c);
  }
  
}