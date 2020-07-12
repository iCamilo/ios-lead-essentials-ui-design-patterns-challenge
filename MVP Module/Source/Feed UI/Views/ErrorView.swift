//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit

@IBDesignable
public final class ErrorView: UIView {
    @IBOutlet private var container: UIView!
	@IBOutlet private var label: UILabel!
    
	public var message: String? {
		get { return isVisible ? label.text : nil }
	}
	
	private var isVisible: Bool {
		return alpha > 0
	}
	
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
    
	public override func awakeFromNib() {
		super.awakeFromNib()
		
		addRounderBorderColor()
        label.text = nil
		alpha = 0        
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
        container.layer.cornerRadius = 5
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.cayenne.cgColor
    }
}

private extension ErrorView {
    static var nib: UINib {
        let bundle = Bundle(for: Self.self)
        return UINib(nibName: String(describing: Self.self), bundle: bundle)
    }

    func setupFromNib() {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}

private extension UIColor {
    static var cayenne: UIColor {
        UIColor(red: 148/255, green: 17/255, blue: 0, alpha: 1.0)
    }
}
