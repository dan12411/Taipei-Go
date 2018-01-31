//
//  ViewController.swift
//  Taipei Go
//
//  Created by 洪德晟 on 30/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchData() {
        let request = DataTaipei.Entertainment.TouristSites(rid: "36847f3f-deff-4183-a5bb-800737591de5", limit: 1)
        
        NetworkRequest(request).fire(onSuccess: { (response: String) in
            print("response")
        }, onFailure: { (error: NetworkError) in
            
        })
    }

}

