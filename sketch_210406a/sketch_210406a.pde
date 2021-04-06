// SETUP
int BACKGROUND_COLOR = 51;

int POINT_NUM = 25;
int MOVER_NUM = 5;
// SETUP

ArrayList<Mover> movers = new ArrayList<Mover>();
ArrayList<Point> points = new ArrayList<Point>();

void setup()
{
  size(1000, 350);

  make_movers();
  make_points();
}

void draw()
{
  background(BACKGROUND_COLOR);
  stroke(0, 0, 0);
  strokeWeight(1);
  
  for(Mover m : movers)
  {
    m.update(points);
    m.draw();
  }
  
  for(Point p : points)
  {
    p.draw();
  }
}

void make_points()
{
  for(int i = 0; i < POINT_NUM; i++)
  {
    Point p = new Point();
    points.add(p);
  }
}

void make_movers()
{
  for(int i = 0; i < MOVER_NUM; i++)
  {
    Mover m = new Mover();
    movers.add(m);
  }
}
