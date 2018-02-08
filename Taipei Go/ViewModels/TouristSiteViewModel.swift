//
//  DataTaipeiViewModel.swift
//  Taipei Go
//
//  Created by 洪德晟 on 31/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import Foundation

class TouristSiteViewModel {
    
    var dataSource: [Result] = []
    var page: Int = 0
    let title: String = "台北市熱門景點"
    var cellTitle: String = ""
    var description: String = ""
    var imageURL: String = ""
    
    init(page: Int) {
        self.page = page
    }
    
    init(data: Result) {
        self.cellTitle = data.stitle
        self.description = data.xbody
        self.imageURL = data.file
    }
    
    func fetchData(completionHandler: @escaping (([Result])->Void)) {
        let offset = self.page * 5
        let request = DataTaipei.Entertainment.TouristSites(rid: "36847f3f-deff-4183-a5bb-800737591de5", limit: 5, offset: offset)
        
        NetworkRequest(request).fire(onSuccess: { (response: Results) in
            completionHandler(response.results)
        }, onFailure: { (error: NetworkError) in
            print(error.description)
        })
    }
}
