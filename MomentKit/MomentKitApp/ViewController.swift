//
//  ViewController.swift
//  MomentKitApp
//
//  Created by Ukjeong Lee on 2020/08/21.
//  Copyright © 2020 Ukjeong Lee. All rights reserved.
//

import UIKit
import MomentCommon
import MomentEditorRepository
import MomentPlayer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ActualRepository().foo()
        
        MomentPlayer.MomentData().foo()
    }


}

