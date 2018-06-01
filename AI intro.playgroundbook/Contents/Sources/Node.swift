import UIKit

///Class used to handle the nodes present in the view
public class NodeView: UIView{
    
    //MARK: Variables and constants
    
    //Label that shows the answer given by the node
    public let answerLabel = UILabel()
    
    //Label that shows the value.
    public let valueLabel = UILabel()
    
    //Label that shows the identifier emoji for the node
    public let identifierLabel = UILabel()
    
    //View that shows the node image!
    public let nodeBackground = UIImageView()
    
    //If it's the output node, integer approximation has to be avoided
    public var isOutput: Bool = false
    
    //Tag to identify nodes through an enum.
    public var nodetag = Tags.other
    
    //The value that will be shown in the node.
    public var value: Float = 0.0
    
    //Custom colors.
    let darkGreen = UIColor(red: 0, green: 130/255, blue: 0, alpha: 1)
    let darkRed = UIColor(red: 180/255, green: 0, blue: 0, alpha: 1)
    
    
    
    // MARK: Init
    public init(frame: CGRect, tag: Tags) {
        super.init(frame: frame)
        
        self.nodetag = tag
        
        self.valueLabel.text = String("\(value)".prefix(1))
        self.valueLabel.textColor = .black
        self.valueLabel.adjustsFontSizeToFitWidth = true
        self.valueLabel.textAlignment = .center
        
        self.answerLabel.text = "Yes"
        self.answerLabel.textAlignment = .center
        
        self.identifierLabel.textAlignment = .center
        
        self.nodeBackground.layer.minificationFilter = kCAFilterTrilinear //Renders shrinked images in a better way, making them smoother. It might impact performances in heavy projects, but there are only 5 images that are rendered in the nodes.
        
        if(Values.shared.showMe){ //Setting images
            self.nodeBackground.image = UIImage(named: "NodeSprite.png")
            self.answerLabel.isHidden = true
        } else {
            switch self.nodetag{
            case .mark:
                self.nodeBackground.image = UIImage(named: "user.png")
            case .tRex:
                self.nodeBackground.image = UIImage(named: "Trex.png")
            case .macBook:
                self.nodeBackground.image = UIImage(named: "MacBook.png")
            case .clairvoyant:
                self.nodeBackground.image = UIImage(named: "Clairvoyant.png")
            default:
                break
            }
        }
        
        
        self.nodeBackground.contentMode = .scaleToFill //Fills the ImageView. Since the node is a square and the View will be squared there are no stretching problems.
        self.nodeBackground.backgroundColor = .clear //Transparent color.
        
        //Adding all the elements to the Node
        self.addSubview(nodeBackground)
        self.addSubview(valueLabel)
        self.addSubview(answerLabel)
        self.addSubview(identifierLabel)

        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: additional setup
    ///Updates mostly everything that depends on things not yet present in the init()
    public func setup(){
        
        let sizeUnit = self.frame.width
        let font = "AvenirNext-Bold" //Very readable font!
        
        self.nodeBackground.frame = CGRect(x: 0, y: 0, width: sizeUnit, height: sizeUnit)
        
        if(Values.shared.showMe){//Shows normal nodes with their relative emoji
            self.valueLabel.font = UIFont(name:font, size: sizeUnit-9)
            
            //Calculating the best point for the value label... the output one needs an adjustment
            let adj: CGFloat = self.isOutput ? -sizeUnit/11 : 0
            self.valueLabel.frame = CGRect(x: (sizeUnit) / 50, y: (sizeUnit - valueLabel.intrinsicContentSize.height) / 2 + adj, width: sizeUnit - 5, height: valueLabel.intrinsicContentSize.height)
            
            
            self.identifierLabel.font = UIFont.systemFont(ofSize: sizeUnit*0.3)
            
            switch self.nodetag{
            case .mark:
                self.identifierLabel.text = "🙇🏻‍♂️"
                self.identifierLabel.frame = CGRect(x: -sizeUnit*0.5 ,y: sizeUnit*0.25,width: sizeUnit*0.5,height:sizeUnit*0.5)
            case .tRex:
                self.identifierLabel.text = "🦖"
                self.identifierLabel.frame = CGRect(x: sizeUnit*0.25 ,y: -sizeUnit*0.5,width: sizeUnit*0.5,height:sizeUnit*0.5)
            case .clairvoyant:
                self.identifierLabel.text = "🔮"
                self.identifierLabel.frame = CGRect(x: sizeUnit*0.25 ,y: -sizeUnit*0.5,width: sizeUnit*0.5,height:sizeUnit*0.5)
            case .macBook:
                self.identifierLabel.text = "💻"
                self.identifierLabel.frame = CGRect(x: sizeUnit*0.25 ,y: -sizeUnit*0.5,width: sizeUnit*0.5,height:sizeUnit*0.5)
            default:
                break
            }
            
        } else { //Shows characters
            
            self.valueLabel.isHidden = true
            self.answerLabel.isHidden = false
            
            self.valueLabel.font = UIFont(name: font, size: sizeUnit-6)
            
            switch self.nodetag { //Modifies layout for the characters
                
            case .mark:
                self.nodeBackground.image = UIImage(named: "user.png")
                self.answerLabel.frame = CGRect(x: sizeUnit * 0.7, y: -sizeUnit * 0.7, width: sizeUnit - 5, height: valueLabel.intrinsicContentSize.height)
                
            case .tRex:
                self.nodeBackground.image = UIImage(named: "Trex.png")
                
                self.answerLabel.frame = CGRect(x: sizeUnit/5.5 , y: sizeUnit*1.2 , width: sizeUnit, height: sizeUnit/3.5)
                
                self.answerLabel.layer.backgroundColor = UIColor.white.cgColor
                self.answerLabel.layer.borderColor = UIColor.black.cgColor
                self.answerLabel.layer.borderWidth = 2
                self.nodeBackground.frame = CGRect(x: sizeUnit/7, y: 0, width: sizeUnit * 1.2, height: sizeUnit * 1.2)
                
            case .macBook:
                self.nodeBackground.image = UIImage(named: "MacBook.png")
                self.answerLabel.frame = CGRect(x: (sizeUnit) / 50, y: (sizeUnit - valueLabel.intrinsicContentSize.height) , width: sizeUnit - 5, height: valueLabel.intrinsicContentSize.height)
                self.valueLabel.font = UIFont(name: font, size: sizeUnit*2)
                
            case .clairvoyant:
                
                self.nodeBackground.image = UIImage(named: "Clairvoyant.png")
                self.nodeBackground.frame = CGRect(x: -sizeUnit/6, y: 0, width: sizeUnit * 1.2, height: sizeUnit * 1.2)
                
                
                //Label
                self.answerLabel.frame = CGRect(x: sizeUnit/10 - sizeUnit/6, y: sizeUnit*1.2 , width: sizeUnit, height: sizeUnit/3.5)
                self.answerLabel.layer.backgroundColor = UIColor.white.cgColor
                self.answerLabel.layer.borderColor = UIColor.black.cgColor
                self.answerLabel.layer.borderWidth = 2
                
                
            default:
                break
            }
        }
        
        
        
    }
    
    
    // MARK: Additional Updates
    public func update(input: Float){ //Updates the value on the node as a number or text
        //Checking if value is within the bounds
        if ((input >= 0 && input <= 1)){
            
            self.value = input
            
            //Checking if it's an integer or it has to be shown as an integer (Input nodes accept only integer values)
            if (!self.isOutput){
                //Shows it as an Integer
                self.valueLabel.text = String("\(round(input))".prefix(1))
                
            } else { //Shows it as a truncated float (first number + point + 2 decimals = 4).
                
                //Rounds the number to a displayable one and then shows it
                self.valueLabel.text = String("\(roundNumberForLabel(input))".prefix(4))
                
                //Saves it as a float!
                self.value = input
            }
            //Sets the answer based on the numerical answer!
            if (round(self.value) == 1 && (self.value != 0.5)){
                self.answerLabel.text = "Yes!"
                self.answerLabel.textColor = self.darkGreen
            } else {
                self.answerLabel.text = "No!"
                self.answerLabel.textColor = self.darkRed
            }
            //Adds an extra exclamation mark for Mark. 😏
            if (self.nodetag == .mark){
                self.answerLabel.text = self.answerLabel.text! + "!"
                self.valueLabel.textColor = self.answerLabel.textColor
            }
            
            
        }
    }
    
    //Avoids numbers being too long to be displayed in the label, and keeps them in their expected output bounds.
    func roundNumberForLabel(_ x: Float) -> Float{
        if(x < 0.01) {return 0.01}
        if(x > 0.99) {return 0.99}
        return x
    }
    
}
