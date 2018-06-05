/**
 * OrbitShape.
 * by Jean Pierre Charalambos.
 * 
 * This class implements a shape behavior which requires
 * overriding the interact(Event) method.
 *
 * Feel free to copy paste it.
 */

public class OrbitShape extends Shape {
  public OrbitShape(Scene scene) {
    super(scene);
  }
  
  public OrbitShape(Node node) {
    super(node);
  }

  // this one gotta be overridden because we want a copied node
  // to have the same behavior as its original.
  protected OrbitShape(Scene otherScene, OrbitShape otherShape) {
    super(otherScene, otherShape);
  }

  @Override
  public OrbitShape get() {
    return new OrbitShape(this.graph(), this);
  }

  // behavior is here :P
  @Override
  public void interact(frames.input.Event event) {
    
  }
}
