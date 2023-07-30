//
//  ViewController.swift
//  FaceExpressionsARKit
//
//  Created by Emre Dogan on 19/07/2023.
//

import UIKit
import ARKit

class ViewController: UIViewController {
	var emotionManager = EmotionManager()
	var trackingView: ARSCNView!
	var textView: UITextView!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard ARFaceTrackingConfiguration.isSupported else {
			fatalError("Face tracking not available on this on this device model!")
		}
		
		// Create ARSCNView programmatically
		trackingView = ARSCNView(frame: CGRect(x: 0, y: -59, width: view.bounds.width, height: UIScreen.main.bounds.height))
		view.addSubview(trackingView)
		
		// Create UITextView programmatically
		textView = UITextView()
		textView.backgroundColor = .clear
				 
		
		textView.text = emotionManager.getCurrrentMood()
		textView.textAlignment = .center
		textView.font = UIFont.systemFont(ofSize: 75)
		textView.isEditable = false
		view.addSubview(textView)
		
		// Set constraints to center on top
		textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		textView.widthAnchor.constraint(equalToConstant: 100).isActive = true
		textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		textView.translatesAutoresizingMaskIntoConstraints = false
		
		
		let configuration = ARFaceTrackingConfiguration()
		self.trackingView.session.run(configuration)
		self.trackingView.delegate = self
	}
}

extension ViewController: ARSCNViewDelegate {
	
	func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
		guard let faceAnchor = anchor as? ARFaceAnchor else { return }
		DispatchQueue.main.async {
			self.emotionManager.refreshActiveEmotions(for: faceAnchor)
			self.textView.text = self.emotionManager.getCurrrentMood()
		}
	}
}
