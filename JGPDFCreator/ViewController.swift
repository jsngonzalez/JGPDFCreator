//
//  ViewController.swift
//  JGPDFCreator
//
//  Created by Jeisson González on 14/12/17.
//  Copyright © 2017 wigilabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let lista=[
        ["description":"CATGUT CHROMIC 0 70CM (1)BP-1","codigo":"47G","suture":"CATGUT CHROMIC","diameter":"0","size":"65","needlePointType":"BLUNT POINT","NeddleName":"BP-1","sutureLength":"70"],
        ["description":"CATGUT CHROMIC 0 70CM (1)BP-1","codigo":"47G","suture":"CATGUT CHROMIC","diameter":"0","size":"65","needlePointType":"BLUNT POINT","NeddleName":"BP-1","sutureLength":"70"]
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        JGPDFCreatorViewController().createPDF(parent:self.navigationController!, listProducts: lista) { (url) in
            print(url)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

