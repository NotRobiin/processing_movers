// SETUP
float POINT_SIZE = 5;
// SETUP

class Point
{
  PVector location;
  Mover targeted_by = null;
  
  Point()
  {
    float x = random(POINT_SIZE, width - POINT_SIZE);
    float y = random(POINT_SIZE, height - POINT_SIZE);
    
    location = new PVector(x, y);
  }
  
  void draw()
  {
    fill(0, 255, 0);
    
    square(location.x, location.y, POINT_SIZE);
  }
  
  int get_array_id(ArrayList<Point> points)
  {
    for(int i = 0 ; i < points.size(); i++)
    {
      if(points.get(i) == this)
      {
        return i;
      }
    }

    return -1;
  }
}
