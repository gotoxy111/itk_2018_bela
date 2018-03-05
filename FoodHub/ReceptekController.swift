//
//  ReceptekController.swift
//  FoodHub
//
//  Created by Student on 2018. 03. 03..
//  Copyright © 2018. Student. All rights reserved.
//

import UIKit

class ReceptekController: UIViewController {

    @IBOutlet weak var getReceptekButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func redirectToReceptek(_ sender: Any) {
        performSegue(withIdentifier: "redToReceptek", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
