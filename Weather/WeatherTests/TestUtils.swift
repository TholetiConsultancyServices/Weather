//
//  File+Extensions.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation

class TestUtils {
    
    func loadData(fromFileName: String) -> [String: Any]? {
        
        let testBundle = Bundle(for: type(of: self))
        guard let filePath = testBundle.path(forResource: fromFileName, ofType: "json") else {
            return nil
        }
        
        guard let data = NSData(contentsOfFile: filePath),
              let JSON = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: Any] else{
            return nil
        }
        
        return JSON
        
    }
}
