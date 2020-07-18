//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit

public final class ErrorView: UIView {
	@IBOutlet private var label: UILabel!    
    @IBOutlet private var container: UIView!
	
	public var message: String? {
		get { return isVisible ? label.text : nil }
	}
	
	private var isVisible: Bool {
		return alpha > 0
	}
	    
	public override func awakeFromNib() {
		super.awakeFromNib()
		
		label.text = nil
		alpha = 0
        addRounderBorderColor()
	}
	
	func show(message: String) {
		self.label.text = message
		
		UIView.animate(withDuration: 0.25) {
			self.alpha = 1
		}
	}
	
	@IBAction func hideMessage() {
		UIView.animate(
			withDuration: 0.25,
			animations: { self.alpha = 0 },
			completion: { completed in
				if completed { self.label.text = nil }
		})
	}
    
    private func addRounderBorderColor() {
        container.layer.cornerRadius = 2
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.red.cgColor
    }
}
