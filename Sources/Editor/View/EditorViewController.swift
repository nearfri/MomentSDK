import UIKit
import MomentEditorDomain

public class EditorViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var button: UIButton!
    
    private var dice: Dice = .init(dots: .one)
    
    public init() {
        super.init(nibName: "EditorViewController", bundle: .module)
        
        checkImageFile()
        checkTextFile()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func checkImageFile() {
        assert(UIImage(named: "iPhone_11", in: .module, compatibleWith: nil) != nil)
    }
    
    private func checkTextFile() {
        assert(Bundle.module.url(forResource: "Lorem ipsum", withExtension: "txt") != nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonTitle = NSLocalizedString("Roll", bundle: .module, comment: "Roll")
        button.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction private func buttonTapped() {
        dice.roll()
        
        imageView.image = dice.dots.image
    }
}

extension Dots {
    var image: UIImage {
        UIImage(named: name, in: .module, compatibleWith: nil)!
    }
}
