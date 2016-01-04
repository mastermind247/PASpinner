//
//  CustomView.swift
//
//  Code generated using QuartzCode 1.37.3 on 12/29/15.
//  www.quartzcodeapp.com
//

import UIKit

@IBDesignable
class CustomView: UIView {
	
	var layers : Dictionary<String, AnyObject> = [:]
	var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
	var updateLayerValueForCompletedAnimation : Bool = false
	
	
	
	//MARK: - Life Cycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupProperties()
		setupLayers()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		setupProperties()
		setupLayers()
	}
	
	override var frame: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	override var bounds: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	func setupProperties(){
		
	}
	
	func setupLayers(){
		let replicator = CAReplicatorLayer()
		self.layer.addSublayer(replicator)
		layers["replicator"] = replicator
		let roundedRect = CAShapeLayer()
		let roundedRectGradient = CAGradientLayer()
		roundedRect.addSublayer(roundedRectGradient)
		replicator.addSublayer(roundedRect)
		layers["roundedRect"] = roundedRect
		layers["roundedRectGradient"] = roundedRectGradient
		
		resetLayerPropertiesForLayerIdentifiers(nil)
		setupLayerFrames()
	}
	
	func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if layerIds == nil || layerIds.contains("replicator"){
			let replicator = layers["replicator"] as! CAReplicatorLayer
			replicator.instanceCount     = 12
			replicator.instanceDelay     = 0.1
			replicator.instanceColor     = UIColor.whiteColor().CGColor
			replicator.instanceTransform = CATransform3DMakeRotation(30 * CGFloat(M_PI/180), 0, 0, -1)
		}
		if layerIds == nil || layerIds.contains("roundedRect"){
			let roundedRect = layers["roundedRect"] as! CAShapeLayer
			roundedRect.fillColor        = nil
			roundedRect.strokeColor      = UIColor(red:0.329, green: 0.329, blue:0.329, alpha:1).CGColor
			
			let roundedRectGradient = layers["roundedRectGradient"] as! CAGradientLayer
			let roundedRectMask          = CAShapeLayer()
			roundedRectMask.path         = roundedRect.path
			roundedRectGradient.mask     = roundedRectMask
			roundedRectGradient.frame    = roundedRect.bounds
			let roundedRectGradientColors : Array <AnyObject> = [UIColor(red:0, green: 0.502, blue:1, alpha:1).CGColor, UIColor(red:0.8, green: 0.4, blue:1, alpha:1).CGColor]
			roundedRectGradient.colors = roundedRectGradientColors
			roundedRectGradient.endPoint = CGPointMake(0.5, 1)
		}
		
		CATransaction.commit()
	}
	
	func setupLayerFrames(){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if let replicator : CAReplicatorLayer = layers["replicator"] as? CAReplicatorLayer{
			replicator.frame = CGRectMake(0.41767 * replicator.superlayer!.bounds.width, 0.43769 * replicator.superlayer!.bounds.height, 0.16467 * replicator.superlayer!.bounds.width, 0.12463 * replicator.superlayer!.bounds.height)
		}
		
		if let roundedRect : CAShapeLayer = layers["roundedRect"] as? CAShapeLayer{
			roundedRect.frame = CGRectMake(0.62623 * roundedRect.superlayer!.bounds.width, 0.1321 * roundedRect.superlayer!.bounds.height, 0.17241 * roundedRect.superlayer!.bounds.width, 0.27724 * roundedRect.superlayer!.bounds.height)
			roundedRect.path  = roundedRectPathWithBounds((layers["roundedRect"] as! CAShapeLayer).bounds).CGPath;
			let roundedRectGradient = layers["roundedRectGradient"] as! CAGradientLayer
			roundedRectGradient.frame = roundedRect.bounds
			(roundedRectGradient.mask as! CAShapeLayer).path = roundedRect.path
		}
		
		CATransaction.commit()
	}
	
	//MARK: - Animation Setup
	
	func addUntitled1Animation(){
		let fillMode : String = kCAFillModeForwards
		
		////An infinity animation
		
		////RoundedRect animation
		let roundedRectOpacityAnim            = CABasicAnimation(keyPath:"opacity")
		roundedRectOpacityAnim.fromValue      = 1;
		roundedRectOpacityAnim.toValue        = 0;
		roundedRectOpacityAnim.duration       = 1.2
		roundedRectOpacityAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		roundedRectOpacityAnim.repeatCount    = Float.infinity
		
		let roundedRectUntitled1Anim : CAAnimationGroup = QCMethod.groupAnimations([roundedRectOpacityAnim], fillMode:fillMode)
		layers["roundedRect"]?.addAnimation(roundedRectUntitled1Anim, forKey:"roundedRectUntitled1Anim")
	}
	
	//MARK: - Animation Cleanup
	
	override func animationDidStop(anim: CAAnimation, finished flag: Bool){
		if let completionBlock = completionBlocks[anim]{
			completionBlocks.removeValueForKey(anim)
			if (flag && updateLayerValueForCompletedAnimation) || anim.valueForKey("needEndAnim") as! Bool{
				updateLayerValuesForAnimationId(anim.valueForKey("animId") as! String)
				removeAnimationsForAnimationId(anim.valueForKey("animId") as! String)
			}
			completionBlock(flag)
		}
	}
	
	func updateLayerValuesForAnimationId(identifier: String){
		if identifier == "Untitled1"{
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["roundedRect"] as! CALayer).animationForKey("roundedRectUntitled1Anim"), theLayer:(layers["roundedRect"] as! CALayer))
		}
	}
	
	func removeAnimationsForAnimationId(identifier: String){
		if identifier == "Untitled1"{
			(layers["roundedRect"] as! CALayer).removeAnimationForKey("roundedRectUntitled1Anim")
		}
	}
	
	func removeAllAnimations(){
		for layer in layers.values{
			(layer as! CALayer).removeAllAnimations()
		}
	}
	
	//MARK: - Bezier Path
	
	func roundedRectPathWithBounds(bound: CGRect) -> UIBezierPath{
		let roundedRectPath = UIBezierPath(roundedRect:bound, cornerRadius:20)
		return roundedRectPath;
	}
	
	
}
