import UIKit

public class Values{ //Current values of nodes and arcs.
    
    public init() {} //There's no need to initialize
    
    public static let shared = Values()
    //Those variables should belong to the ViewController, but a singleton makes them accessible from every class that needs to access them. Also that allowed me to use pure functions and not ViewController methods.
    //Plus, they are easily accessible from anywhere for debugging purposes, so if a user wants to act directly without digging into the code, he can do that right away.
    
    public var node1: Float = 0
    public var node2: Float = 0
    public var node3: Float = 0
    public var outputNode: Float = 0
    public var arc1: Float = 0
    public var arc2: Float = 0
    public var arc3: Float = 0
    
    //Special values
    
    public var showMe: Bool = false //Activates the "Neural network view"
    public var questionTime: Bool = false //Activates the "Mark makes questions" mode.
    
    
    
}


