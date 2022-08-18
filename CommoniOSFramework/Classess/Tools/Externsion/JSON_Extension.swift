//
//  JSON_Extern.swift
//  SCRM_iOS
//
//  Created by 刘圣洁 on 2022/6/2.
//

import Foundation


/**
 let dict: [String: Any] = [
   "name": "John",
   "surname": "Doe",
   "age": 31
 ]
 print(dict)
 // ["surname": "Doe", "name": "John", "age": 31]
 
 let json = String(json: dict)
 print(json)
 // Optional("{\"surname\":\"Doe\",\"name\":\"John\",\"age\":31}")

 let restoredDict = json?.jsonToDictionary()
 print(restoredDict)
 // Optional(["name": John, "surname": Doe, "age": 31])
 */
extension Data {
    init?(sj_json: Any) {
        guard let data = try? JSONSerialization.data(withJSONObject: sj_json, options: .fragmentsAllowed) else { return nil }
        self.init(data)
    }
    
    func sj_jsonToDictionary() -> [String: Any]? {
        (try? JSONSerialization.jsonObject(with: self, options: .allowFragments)) as? [String: Any]
    }
    
    func sj_jsonToArray() -> [Any]? {
        (try? JSONSerialization.jsonObject(with: self, options: .allowFragments)) as? [Any]
    }
}

extension String {
    init?(sj_json: Any) {
        guard let data = Data(sj_json: sj_json) else { return nil }
        self.init(decoding: data, as: UTF8.self)
    }
    
    func jsonToDictionary() -> [String: Any]? {
        self.data(using: .utf8)?.sj_jsonToDictionary()
    }
    
    func jsonToArray() -> [Any]? {
        self.data(using: .utf8)?.sj_jsonToArray()
    }
}
