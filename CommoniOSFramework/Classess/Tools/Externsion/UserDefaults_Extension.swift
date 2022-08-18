//
//  UserDefaults_Extern.swift
//  SCRM_iOS
//
//  Created by 刘圣洁 on 2022/6/2.
//

import Foundation

extension Int {
    ///扩展UserDefault取值
    init?(sj_key: String) {
        guard UserDefaults.standard.value(forKey: sj_key) != nil else { return nil }
        self.init(UserDefaults.standard.integer(forKey: sj_key))
    }
    
    ///扩展UserDefault存值
    func sj_store(key: String) {
        UserDefaults.standard.set(self, forKey: key)
        UserDefaults.standard.synchronize()
    }
}

extension Bool {
    ///扩展UserDefault取值
    init?(sj_key: String) {
        guard UserDefaults.standard.value(forKey: sj_key) != nil else { return nil }
        self.init(UserDefaults.standard.bool(forKey: sj_key))
    }
    ///扩展UserDefault存值
    func sj_store(key: String) {
        UserDefaults.standard.set(self, forKey: key)
        UserDefaults.standard.synchronize()
    }
}

extension Float {
    ///扩展UserDefault取值
    init?(sj_key: String) {
        guard UserDefaults.standard.value(forKey: sj_key) != nil else { return nil }
        self.init(UserDefaults.standard.float(forKey: sj_key))
    }
    ///扩展UserDefault存值
    func sj_store(key: String) {
        UserDefaults.standard.set(self, forKey: key)
        UserDefaults.standard.synchronize()
    }
}

extension Double {
    ///扩展UserDefault取值
    init?(sj_key: String) {
        guard UserDefaults.standard.value(forKey: sj_key) != nil else { return nil }
        self.init(UserDefaults.standard.double(forKey: sj_key))
    }
    ///扩展UserDefault存值
    func sj_store(key: String) {
        UserDefaults.standard.set(self, forKey: key)
        UserDefaults.standard.synchronize()
    }
}

extension Data {
    ///扩展UserDefault取值
    init?(sj_key: String) {
        guard let data = UserDefaults.standard.data(forKey: sj_key) else { return nil }
        self.init(data)
    }
    ///扩展UserDefault存值
    func sj_store(key: String) {
        UserDefaults.standard.set(self, forKey: key)
        UserDefaults.standard.synchronize()
    }
}

extension String {
    ///扩展UserDefault取值
    init?(sj_key: String) {
        guard let str = UserDefaults.standard.string(forKey: sj_key) else { return nil }
        self.init(str)
    }
    ///扩展UserDefault存值
    func sj_store(key: String) {
        UserDefaults.standard.set(self, forKey: key)
        UserDefaults.standard.synchronize()
    }
}

extension Array where Element == Any {
    ///扩展UserDefault取值
    init?(sj_key: String) {
        guard let array = UserDefaults.standard.array(forKey: sj_key) else { return nil }
        self.init()
        self.append(contentsOf: array)
    }
    ///扩展UserDefault存值
    func sj_store(key: String) {
        UserDefaults.standard.set(self, forKey: key)
        UserDefaults.standard.synchronize()
    }
}

extension Dictionary where Key == String, Value == Any {
    ///扩展UserDefault更改值
    mutating func sj_merge(dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
    ///扩展UserDefault取值
    init?(sj_key: String) {
        guard let dict = UserDefaults.standard.dictionary(forKey: sj_key) else { return nil }
        self.init()
        self.sj_merge(dict: dict)
    }
    ///扩展UserDefault存值
    func sj_store(key: String) {
        UserDefaults.standard.set(self, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
