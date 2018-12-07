//
//  Created by Bear  Cahill 
//  Copyright © 2018 Brainwash Inc. All rights reserved.
//

import Foundation

class Music {
    var cache : [[String:Any]]?
    var fetchDate : Date?
    
    func refresh() {
        cache = nil
        fetchDate = nil
        fetchMusic { (newData, error) in
            if newData != nil {
                self.fetchDate = Date()
            }
        }
    }
    
    func fetchMusic(completion : @escaping ([[String:Any]]?, Error?)->Void) {
        guard cache == nil else { completion(cache, nil); return }
        
        let dt = URLSession.shared.dataTask(with: URL.init(string: "https://orangevalleycaa.org/api/music")!) { (data, response, error) in
            completion(self.parseJSON(data: data!), error)
        }
        dt.resume()
    }
    
    func parseJSON(data : Data) -> [[String:Any]]? {
        cache = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
        return cache
    }
}

