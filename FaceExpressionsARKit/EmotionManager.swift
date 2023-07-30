//
//  EmotionManager.swift
//  FaceExpressionsARKit
//
//  Created by Emre Dogan on 19/07/2023.
//

import UIKit
import ARKit

class EmotionManager {
	
	// List of all of the emotions we want to track
	private var emotions: [Emotion] = [NeutralEmotion(), HappyEmotion(), SadEmotion(), AngryEmotion(), BlinkEmotion(), SurprisedEmotion(), TongueEmotion(), KissEmotion(), CloseEyeKissEmotion(), LookRightEmotion()]
	
	// Current active emotions. Defaults to neutral.
	var activeEmotions: [Emotion] = [NeutralEmotion()]
	
	// Gets the current emotions found in the given ARFaceAnchor object. If none are found then return neutral as default.
	func refreshActiveEmotions(for face: ARFaceAnchor) {
		
		var activeEmotions = [Emotion]()
		
		for emotion in self.emotions {
			if emotion.isActive(for: face) {
				activeEmotions.append(emotion)
			}
		}
		
		// If no active emotions are found then default to neutral
		self.activeEmotions = activeEmotions.isEmpty ? [NeutralEmotion()] : activeEmotions
	}
	
	// Return emotion colors from currently active face emotions. Shuffle the order so the gradient constantly changes.
	func getCurrrentMood() -> String {
		return activeEmotions.last!.moodText
	}
}
