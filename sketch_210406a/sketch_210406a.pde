// SETUP
int BACKGROUND_COLOR = 51;

int POINT_NUM = 25;
int MOVER_NUM = 5;

int POINT_DISTRIBUTION_DISTANCE = 15;
// SETUP

ArrayList<Mover> movers = new ArrayList<Mover>();
ArrayList<Point> points = new ArrayList<Point>();

void setup()
{
  size(1000, 350);

  for (int i = 0; i < POINT_NUM; i++) points.add(new Point());
  for (int i = 0; i < MOVER_NUM; i++) movers.add(new Mover());
}

void draw()
{
  background(BACKGROUND_COLOR);
  stroke(0, 0, 0);
  strokeWeight(1);

  for (Mover m : movers)
  {
    m.update(points);
    m.draw();
  }

  for (Point p : points)
    p.draw();
}

void mousePressed()
{
  if (mouseButton == LEFT)
  {
    make_point(mouseX, mouseY);
  } else if (mouseButton == RIGHT)
  {
    for (Mover m : movers)
      m.toggle_frozen();
  }
}

void mouseDragged()
{
  Point closest = get_closest_point(mouseX, mouseY);

  if (closest == null)
  {
    return;
  }

  float distance = dist(mouseX, mouseY, closest.location.x, closest.location.y);

  if (distance > POINT_DISTRIBUTION_DISTANCE)
    make_point(mouseX, mouseY);
}

Point get_closest_point(float x, float y)
{
  float distance;
  float closest_distance = width;
  Point point = null;

  for (Point p : points)
  {
    distance = dist(x, y, p.location.x, p.location.y);

    if (distance < closest_distance)
    {
      closest_distance = distance;
      point = p;
    }
  }

  return point;
}

void make_point(float x, float y)
{
  Point p = new Point();

  p.location.x = x;
  p.location.y = y;

  points.add(p);
}
