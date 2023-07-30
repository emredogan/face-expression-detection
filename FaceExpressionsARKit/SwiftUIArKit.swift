//
//  SwiftUIArKit.swift
//  FaceExpressionsARKit
//
//  Created by Emre Dogan on 19/07/2023.
//

import Foundation
import SwiftUI

struct ARKitView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> ViewController {
		ViewController()
	}
	
	func updateUIViewController(_ viewController: ViewController, context: Context) {
		// You can update the view controller if needed
	}
}

