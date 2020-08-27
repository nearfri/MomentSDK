import UIKit
import MomentEditor
import MomentEditorRepository
import MomentPlayer
import MomentEditorView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ActualRepository().foo()
        
        MomentPlayer.MomentData().foo()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let vc = EditorViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }
}

