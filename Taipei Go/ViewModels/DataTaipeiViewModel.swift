//
//  DataTaipeiViewModel.swift
//  Taipei Go
//
//  Created by 洪德晟 on 31/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import Foundation

class DataTaipeiViewModel {
    
    var dataSource: [Result] = []
    var limit: Int = 5
    let title: String = "台北市熱門景點"
    
    init() {}
    
    func fetchData(completionHandler: @escaping (([Result])->Void)) {
        let request = DataTaipei.Entertainment.TouristSites(rid: "36847f3f-deff-4183-a5bb-800737591de5", limit: limit)
        
        NetworkRequest(request).fire(onSuccess: { (response: Results) in
            completionHandler(response.results)
        }, onFailure: { (error: NetworkError) in
            print(error.description)
        })
    }
}
