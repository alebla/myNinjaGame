
import SpriteKit

public extension SKNode {
  
  /**
  Position this node relative to the visible area of the screen as a percentage float
  from 0.0 to 1.0.
  */
  
  public func posByScreen(x: CGFloat, y: CGFloat) {
    self.position = CGPoint(x: CGFloat((SKMUIRect!.width * x) + SKMUIRect!.origin.x), y: CGFloat((SKMUIRect!.height * y) + SKMUIRect!.origin.y))
  }
  
  /**
  Position this node releative to the total size of the scene as a percentage float
  from 0.0 to 1.0.
  */
  
  public func posByCanvas(x: CGFloat, y: CGFloat) {
    self.position = CGPoint(x: CGFloat(SKMSceneSize!.width * x), y: CGFloat(SKMSceneSize!.height * y))
  }
  
}

public extension CGSize {
  
  /**
  Set size of object based on current screen size and scale for different screen
  sizes while maintaining aspect ratio.
  */
  
  public init(screenWidth: CGFloat, screenHeight: CGFloat) {
    if (SKMSceneSize != nil && SKMViewSize != nil) {
      self.init(width: screenWidth * (SKMViewSize!.height / SKMSceneSize!.height), height: screenHeight * (SKMViewSize!.height / SKMSceneSize!.height))
    } else {
      self.init(width: screenWidth, height: screenHeight)
    }
  }
  
  /**
  Set size of object based size of scene alone, does not scale and for now it only
  passes value to the regular init with size function. Left in for possible future
  enhancements and uniformity.
  */
  
  public init(canvasWidth: CGFloat, canvasHeight: CGFloat) {
    self.init(width: canvasWidth, height: canvasHeight)
  }
  
}

public extension CGPoint {
  
  /**
  Position this point relative to the visible area of the screen as a percentage float
  from 0.0 to 1.0.
  */
  
  public init(screenX: CGFloat, screenY: CGFloat) {
    self.init(x: CGFloat((SKMUIRect!.width * screenX) + SKMUIRect!.origin.x), y: CGFloat((SKMUIRect!.height * screenY) + SKMUIRect!.origin.y))
  }
  
  /**
  Position this point releative to the total size of the scene as a percentage float
  from 0.0 to 1.0.
  */
  
  public init(canvasX: CGFloat, canvasY: CGFloat) {
    self.init(x: CGFloat(SKMSceneSize!.width * canvasX), y: CGFloat(SKMSceneSize!.height * canvasY))
  }
  
  /**
  Position this point at a specific radius and degrees from CGPointZero.
  */
  
  public init(radius:CGFloat, degrees:CGFloat) {
    self.init(x: radius * cos(degrees),y: radius * sin(degrees))
  }
  
  /**
  Position this point at a specific radius and degrees from another CGPoint.
  */
  
  public init(point:CGPoint, radius:CGFloat, degrees:CGFloat) {
    let newPoint = point + CGPoint(radius: radius, degrees: degrees)
    self.init(x:newPoint.x,y:newPoint.y)
  }
  
}

public extension CGFloat {
  
  /**
  Returns the float as a string limited to a set number of decimal points.
  */
  
  public func string(fractionDigits:Int) -> String {
    let formatter = NSNumberFormatter()
    formatter.minimumFractionDigits = fractionDigits
    formatter.maximumFractionDigits = fractionDigits
    return formatter.stringFromNumber(self)!
  }
  
}

