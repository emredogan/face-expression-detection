//
//  Emotion.swift
//  FaceExpressionsARKit
//
//  Created by Emre Dogan on 19/07/2023.
//

import Foundation
import UIKit
import ARKit

protocol Emotion {
	// The range between 0-1 where the emotion is considered active or not
	var threshold: Double { get }
	var moodText: String { get }
	
	// Calculated from the the blendshapes to see if that face has the given emotion (for example smile is calculated from '.mouthSmileLeft' or '.mouthSmileRight' being over the threshold amount)
	func isActive(for face: ARFaceAnchor) -> Bool
}

extension Emotion {
	// Set default threshold to 0.3, can be overriden by class to change value.
	var threshold: Double {
		return 0.4
	}
}

struct NeutralEmotion: Emotion {
	var moodText: String = "😐"
	
	func isActive(for face: ARFaceAnchor) -> Bool {
		for blendshape in face.blendShapes {
			if blendshape.value.doubleValue > self.threshold {
				return false
			}
		}
		return true
	}
}

struct DisgustedEmotion: Emotion {
	var moodText: String = "🤢"

	func isActive(for face: ARFaceAnchor) -> Bool {
		return face.blendShapes[.mouthUpperUpLeft]?.doubleValue ?? 0 > self.threshold || face.blendShapes[.mouthUpperUpRight]?.doubleValue ?? 0 > self.threshold
	}
}

struct HappyEmotion: Emotion {
	var moodText: String = "😂"

	
	func isActive(for face: ARFaceAnchor) -> Bool {
		return face.blendShapes[.mouthSmileLeft]?.doubleValue ?? 0 > self.threshold || face.blendShapes[.mouthSmileRight]?.doubleValue ?? 0 > self.threshold
	}
}

struct SadEmotion: Emotion {
	var moodText: String = "😢"

	func isActive(for face: ARFaceAnchor) -> Bool {
		return face.blendShapes[.mouthFrownLeft]?.doubleValue ?? 0 > self.threshold || face.blendShapes[.mouthFrownRight]?.doubleValue ?? 0 > self.threshold
	}
}

struct AngryEmotion: Emotion {
	var moodText: String = "😡"

	func isActive(for face: ARFaceAnchor) -> Bool {
		
		return face.blendShapes[.browDownRight]?.doubleValue ?? 0 > self.threshold || face.blendShapes[.browDownLeft]?.doubleValue ?? 0 > self.threshold
	}
}

struct BlinkEmotion: Emotion {
	var moodText: String = "😉"
	
	func isActive(for face: ARFaceAnchor) -> Bool {
		let leftEyeBlink = face.blendShapes[.eyeBlinkLeft]?.doubleValue ?? 0
		let rightEyeBlink = face.blendShapes[.eyeBlinkRight]?.doubleValue ?? 0
		
		return leftEyeBlink > self.threshold || rightEyeBlink > self.threshold
	}
}

struct KissEmotion: Emotion {
	var moodText: String = "😘"

	func isActive(for face: ARFaceAnchor) -> Bool {
		return face.blendShapes[.mouthPucker]?.doubleValue ?? 0 > self.threshold
	}
}

struct LookRightEmotion: Emotion {
	var moodText: String = "😏"

	func isActive(for face: ARFaceAnchor) -> Bool {
		return face.blendShapes[.eyeLookInRight]?.doubleValue ?? 0 > self.threshold
	}
}

struct CloseEyeKissEmotion: Emotion {
	var moodText: String = "😚"
	
	func isActive(for face: ARFaceAnchor) -> Bool {
		let isKiss = face.blendShapes[.mouthPucker]?.doubleValue ?? 0 > self.threshold
		let leftEyeBlink = face.blendShapes[.eyeBlinkLeft]?.doubleValue ?? 0 > self.threshold
		let rightEyeBlink = face.blendShapes[.eyeBlinkRight]?.doubleValue ?? 0  > self.threshold
		
		return isKiss && leftEyeBlink && rightEyeBlink
	}
}



struct TongueEmotion: Emotion {
	var moodText: String = "😛"
	
	func isActive(for face: ARFaceAnchor) -> Bool {
		let tongueout = face.blendShapes[.tongueOut]?.doubleValue ?? 0

		
		return tongueout > self.threshold
	}
}

struct SurprisedEmotion: Emotion {
	var moodText: String = "😲"
	
	func isActive(for face: ARFaceAnchor) -> Bool {
		// Detecting surprise based on blend shapes representing a surprised expression
		let mouthOpenThreshold: Double = 0.4
		let eyebrowRaisedThreshold: Double = 0.6
		
		let isMouthOpen = (face.blendShapes[.jawOpen]?.doubleValue ?? 0) > mouthOpenThreshold
		let areEyebrowsRaised = (face.blendShapes[.browInnerUp]?.doubleValue ?? 0) > eyebrowRaisedThreshold
		
		return isMouthOpen && areEyebrowsRaised
	}
}
