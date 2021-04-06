// SETUP
int MOVER_SIZE = 10;
int MOVER_MAX_SPEED = 15;
int MOVER_MIN_DISTANCE = MOVER_SIZE * 2;
float MOVER_DIR_SCALE = 50.0; // Making this higher prevents movers from orbiting around a targeted point, which they will do because of how fast they move.
// SETUP

class Mover
{
  PVector location;
  PVector acceleration;
  PVector velocity;
  Point target;
  
  Mover()
  {
    float x = random(MOVER_SIZE, width - MOVER_SIZE);
    float y = random(MOVER_SIZE, height - MOVER_SIZE);
    
    location = new PVector(x, y);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    target = null;
  }
  
  void draw()
  {
    fill(255, 0, 0);
    
    square(location.x, location.y, MOVER_SIZE);
  }
  
  void update(ArrayList<Point> points)
  {
    if(target == null)
    {
      target = find_closest();
    }
    
    action(points);
    move();
  }
  
  void move()
  {
    if(target == null)
    {
      return;
    }
    
    PVector direction = PVector.sub(target.location, location);
    direction.normalize();
    direction.mult(MOVER_DIR_SCALE);
    
    acceleration = direction;
    
    velocity.add(acceleration);
    velocity.limit(MOVER_MAX_SPEED);
    location.add(velocity);
  }
  
  Point find_closest()
  {
    float closest_distance = width;
    float dist = 0;
    Point p;
    Point closest = null;
    
    // Get closest point.
    for(int i = points.size() - 1; i >= 0; i--)
    {
      p = points.get(i);
      dist = dist(location.x, location.y, p.location.x, p.location.y);
      
      if(dist > closest_distance)
      {
        continue;
      }
      
      // Make sure it has not been targeted by any other mover.
      if(p.targeted_by != null && p.targeted_by != this)
      {
        continue;
      }
      
      closest = p;
      closest_distance = dist;
    }
    
    if(closest != null)
    {
      closest.targeted_by = this;
    }
    
    return closest;
  }
  
  void action(ArrayList<Point> points)
  {
    if(target == null)
    {
      return;
    }
    
    float distance = dist(location.x, location.y, target.location.x, target.location.y);
    
    // Remove the point we hit and add a new one.
    if(distance < MOVER_MIN_DISTANCE)
    {
      int id = target.get_array_id(points);
      
      points.remove(id);
      points.add(new Point());
      
      target = null;
    }
  }
}
