import UIKit

/*
 As you'll see in the code, every layout element is based on the node size, calculated from the shortest size of the screen, so that everything can fit in.
 Apart from that and some adjustments, the code should be pretty straightforward.
 
 showMe value indicates that there has to be shown the network
 questionTime value indicates that the initial scene has to be shown
 
 */



public class MainViewController: UIViewController {
    
    // MARK: Variables and constants
    
    ///View used to display the backgorund of the ViewController.
    var backgroundView = UIImageView()
    
    //classes used to represent nodes and their behaviors.
    var node1: NodeView?
    var node2: NodeView?
    var node3: NodeView?
    var outputNode: NodeView?
    
    //classes used to represent arcs.
    var arc1: ArcView?
    var arc2: ArcView?
    var arc3: ArcView?
    
    //Buttons that overlay nodes.
    var nodeButton1 = UIButton()
    var nodeButton2 = UIButton()
    var nodeButton3 = UIButton()
    var outputNodeButton = UIButton()
    
    //Array of questions that mark asks.
    let questions: [String] = ["Are whales fish?", "2+2=4?", "Can a magic sphere give homework answers?", "Was the T-Rex the biggest dinosaur?"]
    //Array of answers that are given to mark.
    let answers: [[Float]] = [[1,0,1], [0,1,1], [0,0,1], [1,0,0]]
    
    //Counter that is used to go through the questions.
    var questionCounter: Int = 0
    
    //ImageView used to show mark's balloon.
    let balloonView = UIImageView()
    
    //Label that shows the question
    let questionLabel = UILabel()
    
    //Instance of the NeuralNetwork class. Used to calculate the sigmoid for the output node.
    public let neuralNetwork = NeuralNetwork()
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrided methods from superclass
    //The code that is executed right after loading
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.translatesAutoresizingMaskIntoConstraints = false
        //Avoids the addition of unwanted autoconstraints
        
        setBackground()
        
        if(Values.shared.questionTime){ //Force values on input nodes and show the question label
            setQuestionLabel()
            Values.shared.node1 = answers[questionCounter][0]
            Values.shared.node2 = answers[questionCounter][1]
            Values.shared.node3 = answers[questionCounter][2]
        }
        
        setupNodes()
        
        if(!Values.shared.showMe){
            setBalloon()
        }
        
        setupArcs()
        
        setupButtons()
        
        
        //The output is equal to the sum of all the inputs in the sigmoid function!
        Values.shared.outputNode = neuralNetwork.sigmoid(Values.shared.node1 * Values.shared.arc1  + Values.shared.node2 * Values.shared.arc2 + Values.shared.node3 * Values.shared.arc3)
        
        self.refreshNetwork()
        
        
    }
    
    override public func viewDidLayoutSubviews() {
        backgroundView.frame = view.frame
        self.viewDidLoad()
        
    }
    
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    
    // MARK: Custom methods
    // MARK: Setup
    func setBackground(){
        backgroundView.image = UIImage(named: "MainBackground.png")
        view.addSubview(backgroundView)
        backgroundView.frame = view.frame
        backgroundView.contentMode = .scaleToFill
        //The gradient background has no elements that will look abnormal if stretched, so the scale to fill is a good choice
    }
    
    
    func setupNodes(){ //Setting up nodes
        
        var nodeSize: CGFloat = (self.view.frame.width > self.view.frame.height) ? self.view.frame.height/12 : self.view.frame.width/12
        nodeSize *= 2.2
        let heightUnit: CGFloat = self.view.frame.height*(1/9)
        let widthUnit: CGFloat = self.view.frame.width*(1/8)
        
        
        
        node2 = NodeView(frame: CGRect(x: self.view.center.x - nodeSize/2, y: self.view.frame.height*(1/5) - 30, width: nodeSize, height: nodeSize), tag: .macBook)
        node2!.setup()
        self.view.addSubview(node2!)
        
        node1 = NodeView(frame: CGRect(x: node2!.frame.minX - nodeSize*2, y: node2!.frame.minY, width: nodeSize, height: nodeSize), tag: .tRex)
        node1!.setup()
        self.view.addSubview(node1!)
        
        node3 = NodeView(frame: CGRect(x: node2!.frame.minX + nodeSize*2, y: node2!.frame.minY, width: nodeSize, height: nodeSize), tag: .clairvoyant)
        node3!.setup()
        self.view.addSubview(node3!)
        
        outputNode = NodeView(frame: CGRect(x: node2!.frame.minX + 9, y: heightUnit + nodeSize*4 - 25, width: nodeSize, height: nodeSize), tag: .mark)
        outputNode!.isOutput = true
        outputNode!.setup()
        self.view.addSubview(outputNode!)
    }
    
    func setupArcs(){ // Just setting up the arcs
        arc1=setArcBetween(n1: node1! , n2: outputNode!)
        arc2=setArcBetween(n1: node2! , n2: outputNode!)
        arc3=setArcBetween(n1: node3! , n2: outputNode!)
        
        arc1!.setup()
        arc2!.setup()
        arc3!.setup()
        
        self.view.insertSubview(arc1!, aboveSubview: backgroundView)
        self.view.insertSubview(arc2!, aboveSubview: backgroundView)
        self.view.insertSubview(arc3!, aboveSubview: backgroundView)
    }
    
    func setArcBetween(n1: NodeView, n2: NodeView) -> ArcView { //Calculates the resultin connection arc given two nodes.
        let dx = n2.frame.minX - n1.frame.minX
        let dy = n2.frame.minY - n1.frame.minY
        let dist = sqrt(pow(dx, 2)+pow(dy, 2))//Distance calculated using pythagorean theorem
        
        let xAdjustment = n1.frame.minX - node1!.frame.minX + n1.frame.width*(-0.5)
        //Altough the formula should work for every arc, it seems like if dx is negative the y coordinate for the frame is set to a value that cannot be derived from the calculations we are making here. Just fixing up some issues derived from the rotation!
        // remember: in an assignment you can use the following syntax to choose between two values
        /*
         var a = (condition) ? ValueIfTrue : ValueIfFalse
         */
        var xCoord = (dx>=0) ?
            n1.center.x - dx*0.5 - xAdjustment :
            n1.center.x - dx*0.30 - xAdjustment
        
        if (dx == 0){
            xCoord *= 1.01
        }
        
        let yCoord = (dx>=0) ?
            n1.center.y + dy/2 :
            n1.center.y + (dy * 0.445)
        
        
        //The width of the arc will be based on its weight! So we will multiply it for this factor
        var scaleFactor: CGFloat = 1
        
        switch n1.nodetag{
        case .tRex:
            //The scale factor cannot be bigger than one, otherwise arcs could just cover the intire screen with their width. So i'm checking if it's bigger than one. If it is, the scale factor is one, the max value.
            scaleFactor = CGFloat(fabs(Values.shared.arc1)) > CGFloat(1) ? CGFloat(1) : CGFloat(fabs(Values.shared.arc1))
        case .macBook:
            scaleFactor = CGFloat(fabs(Values.shared.arc2)) > CGFloat(1) ? CGFloat(1) : CGFloat(fabs(Values.shared.arc2))
        case .clairvoyant:
            scaleFactor = CGFloat(fabs(Values.shared.arc3)) > CGFloat(1) ? CGFloat(1) : CGFloat(fabs(Values.shared.arc3))
        default:
            break
        }
        
        
        
        let arcView = ArcView(frame: CGRect(x: xCoord, y:yCoord, width: dist, height: n1.frame.width/5*scaleFactor))
        
        arcView.backgroundColor = .clear
        arcView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        let rotationAngle = atan2(dy,dx)
        arcView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        
        arcView.tag = n1.nodetag.rawValue * -1 //Assigning tag to the arcs
        
        return arcView
    }
    
    func setupButtons(){ //Setting up buttons for interaction
        
        let sizeUnit: CGFloat = (self.view.frame.width > self.view.frame.height) ? self.view.frame.height/12 : self.view.frame.width/12
        
        nodeButton1.tag = Tags.tRex.rawValue
        nodeButton2.tag = Tags.macBook.rawValue
        nodeButton3.tag = Tags.clairvoyant.rawValue
        outputNodeButton.tag = Tags.mark.rawValue
        
        nodeButton1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        nodeButton2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        nodeButton3.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        outputNodeButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        

        let frame1 = node1!.nodeBackground.frame
        let newFrame1 = CGRect(x:node1!.frame.minX, y:node1!.frame.minY ,width: frame1.width*1.1, height:frame1.height*1.3) //Enlarging buttons to overlay node+label
        nodeButton1.frame = newFrame1
        self.view.insertSubview(nodeButton1, aboveSubview: node1!)
        
        nodeButton2.frame = node2!.frame
        self.view.insertSubview(nodeButton2, aboveSubview: node2!)
        
        let frame3 = node3!.nodeBackground.frame
        let newFrame3 = CGRect(x:node3!.frame.minX - sizeUnit/1.5, y:node3!.frame.minY ,width: frame3.width*1.2, height:frame3.height*1.3)
        nodeButton3.frame = newFrame3
        self.view.insertSubview(nodeButton3, aboveSubview: node3!)
        
        outputNodeButton.frame = outputNode!.frame
        if(Values.shared.questionTime){
            self.view.insertSubview(outputNodeButton, aboveSubview: outputNode!)
        }
        
        
        
    }
    
    func setQuestionLabel(){ //Sets the label that displays questions
        let nodeSize: CGFloat = (self.view.frame.width > self.view.frame.height) ? self.view.frame.height/12 : self.view.frame.width/12
        questionLabel.text = self.questions[questionCounter]
        questionLabel.frame = CGRect(x:self.view.center.x - nodeSize*4, y: nodeSize/2, width: nodeSize*8, height:nodeSize)
        self.questionLabel.textAlignment = .center
        self.questionLabel.adjustsFontSizeToFitWidth = true
        self.questionLabel.font = UIFont(name: "AvenirNext-Bold", size: nodeSize-6)
        self.view.addSubview(questionLabel)
    }
    
    func setBalloon(){ //Sets the view for the balloon
        let userFrame = self.outputNode!.frame
        
        self.balloonView.image = UIImage(named: "Balloon.png")
        self.balloonView.layer.minificationFilter = kCAFilterTrilinear
        self.balloonView.frame = CGRect(x: userFrame.minX + userFrame.width * 0.7 ,y: userFrame.minY - userFrame.height / 3 ,width: userFrame.width,height: userFrame.width*0.75)
        self.view.insertSubview(balloonView, aboveSubview: backgroundView)
    }
    
    
    // MARK: Actions
    @objc func buttonAction(sender: UIButton!){//Updates input node values/Updates question label
        
            switch sender.tag {
            case Tags.tRex.rawValue:
                if (node1!.value == 0){
                    node1!.update(input: 1)
                } else {
                    node1!.update(input: 0)
                }
                Values.shared.node1 = node1!.value
                
            case Tags.macBook.rawValue:
                if (node2!.value == 0){
                    node2!.update(input: 1)
                } else {
                    node2!.update(input: 0)
                }
                Values.shared.node2 = node2!.value
                
            case Tags.clairvoyant.rawValue:
                if (node3!.value == 0){
                    node3!.update(input: 1)
                } else {
                    node3!.update(input: 0)
                }
                Values.shared.node3 = node3!.value
            case Tags.mark.rawValue:
                    questionCounter = (questionCounter + 1)%questions.count
                    Values.shared.node1 = answers[questionCounter][0]
                    Values.shared.node2 = answers[questionCounter][1]
                    Values.shared.node3 = answers[questionCounter][2]
            default:
                break
            
        }
        
        Values.shared.outputNode = neuralNetwork.sigmoid(Values.shared.node1 * Values.shared.arc1  + Values.shared.node2 * Values.shared.arc2 + Values.shared.node3 * Values.shared.arc3)
        
        self.viewDidLoad()
    }
    
    func refreshNetwork(){ //Refreshes the values for every node and arc from the singleton
        node1!.update(input: Values.shared.node1)
        node2!.update(input: Values.shared.node2)
        node3!.update(input: Values.shared.node3)
        outputNode!.update(input: Values.shared.outputNode)
        arc1!.update(input: Values.shared.arc1)
        arc2!.update(input: Values.shared.arc2)
        arc3!.update(input: Values.shared.arc3)
        
        
    }
    
    
    
    
    
}

