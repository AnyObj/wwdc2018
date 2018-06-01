import Foundation

///Shows what's behind Mark and his friends.
public func letMeSee(){
    Values.shared.showMe = true
}

///Sets values for the arcs. It works only if they are between -1 and 1.
public func setArcWeights(left: Float, center: Float, right: Float){
    Values.shared.arc1 = left
    Values.shared.arc2 = center
    Values.shared.arc3 = right

}
///Same as above, but with an array
public func setArcWeights(weightsArray w: [Float]){
    Values.shared.arc1 = w[0]
    Values.shared.arc2 = w[1]
    Values.shared.arc3 = w[2]
    
    
}
