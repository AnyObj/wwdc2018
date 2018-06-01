import UIKit

public class ArcView: UIView{
    
    var value: Float = 0 //Value that will be shown on the arc
    public let label = UILabel() //Label that will show the value
    
    //Custom colors.
    let darkGreen = UIColor(red: 0, green: 130/255, blue: 0, alpha: 1)
    let darkRed = UIColor(red: 180/255, green: 0, blue: 0, alpha: 1)
    
    // MARK: init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.label.text = "\(value)"
        self.label.textColor = .black
        self.label.adjustsFontSizeToFitWidth = true
        self.label.textAlignment = .center 
        
        
        self.addSubview(label)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Additional setup
    public func setup(){
        
        if (!Values.shared.showMe){
            self.isHidden = true
        } else {
            self.isHidden = false
        }
        
        self.label.font = UIFont(name:  "AvenirNext-Bold", size: 15)
        
        let labelXCoord = (self.frame.height*6.2 - self.frame.width*0.3)/50
        /*Why are we using height for x coordinates?
         Because UIViews enclose every object in a CGRect frame, the height will be calculated in vertical coordinates, so since the nodes are equidistant from the output one on the y axis, using the height is the way to go for a scalable layout, if you are using relative coordinates.
         Since there was a discrepancy in the x coordinates for the label in the center, i adjusted them with the width to equalize the results.*/
        
        let labelYCoord = -label.intrinsicContentSize.height //A very useful property! You can see how it's easy to get the size of the label's content to manipulate it in the correct way. I am using that to raise the label just above the arc.
        
        
        self.label.frame = CGRect(x: labelXCoord , y: labelYCoord, width: self.frame.height/2, height: label.intrinsicContentSize.height)
        
        
    }
    
    // MARK: Arc updates
    public func update(input: Float){
        
            self.value = input
            
            //Show it as a truncated float by truncating the string. ("x " + first number + point + 2 decimals = 6). A minus occupies one place and so on...
            if (self.value >= 0){
                self.label.text = String("x \(self.value)".prefix(6))
                self.backgroundColor = (self.value > 0) ? self.darkGreen : .clear
                
            } else {
                self.label.text = String("x \(self.value)".prefix(7))
                self.backgroundColor = self.darkRed
            }
        
    }
    
}
