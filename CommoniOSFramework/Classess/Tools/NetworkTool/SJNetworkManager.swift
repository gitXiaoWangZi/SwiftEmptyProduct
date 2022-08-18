//
//  SJNetworkManager.swift
//  CommoniOSFramework
//
//  Created by 刘圣洁 on 2022/8/18.
//

import UIKit
import Alamofire
import SwiftyJSON

enum MethodType : String{
    case post
    case get
}

class SJNetworkManager {

    class func postRequest(strUrl: String,params: [String:Any]? = nil,successBack:@escaping (_ result: ResponseObject)->(),failureBack:@escaping (_ errorMessage : String)->()) {
        
        guard strUrl.count != 0 else {
            print("url为空")
            return
        }
        //需要头header时添加，不需要时去掉header参数
        AF.request(strUrl, method: .post, parameters: params, headers: HTTPHeaders(["Authorization": "","token" : ""])).responseData { responese in
            switch responese.result {
            case .success:
                do {
                    successBack(ResponseObject(json: JSON(responese)))
//                    let dictionary = try JSONSerialization.jsonObject(with: responese.data!) as? [String : Any]
//                    guard dictionary?.count != 0 else {
//                        return
//                    }
//                    if dictionary!["code"] != nil {
//                        guard dictionary!["code"] as! Int == 0 else {
//                            failureBack("\(dictionary!["msg"] as! String)")
//                            return
//                        }
//                        successBack(dictionary)
//                    }
                } catch {
                    print("返回数据转字典失败")
                }
                break
            case .failure:
                failureBack("\(responese.error!)")
                break
            }
        }
    }
    
    class func postRequestWithBodyFor(strUrl: String,params: [String:Any]? = nil,successBack:@escaping (_ result: ResponseObject)->(),failureBack:@escaping (_ errorMessage : String)->()) {
        guard strUrl.count != 0 else {
            print("url为空")
            return
        }
        
        var request = URLRequest.init(url: URL(string: strUrl)!)
        do {
            if params != nil {
                let data = try JSONSerialization.data(withJSONObject: params!, options: .fragmentsAllowed)
                request.httpBody = data
            }
        }catch{
            print("字典转换data失败")
        }
        request.httpMethod = "POST"
        request.setValue("", forHTTPHeaderField: "Authorization")
        request.setValue("", forHTTPHeaderField: "token")
        AF.request(request)
            .responseData { responese in
                switch responese.result {
                case .success:
                    do {
                        successBack(ResponseObject(json: JSON(responese)))
//                        let dictionary = try JSONSerialization.jsonObject(with: responese.data!) as? [String : Any]
//                        if (dictionary!.keys.contains("errorMessage")) {
//                            failureBack(dictionary!["errorMessage"] as! String)
//                        }else{
//                            successBack(dictionary)
//                        }
                    } catch {
                        print("返回数据转字典失败")
                    }
                    break
                case .failure:
                    print("\(String(describing: responese.error))")
                    break
                }
            }
    }
    
    class func getRequestFor(strUrl: String,params: [String:Any]? = nil,successBack:@escaping (_ result: ResponseObject)->(),failureBack:@escaping (_ errorMessage : String)->()) {
        guard strUrl.count != 0 else {
            print("url为空")
            return
        }
        AF.request(strUrl, method: .get, parameters: params,encoding: URLEncoding.queryString,headers: HTTPHeaders(["Authorization": "","token" : ""])).responseData { responese in
            switch responese.result {
            case .success:
                do {
                    //返回模型
                    successBack(ResponseObject(json: JSON(responese)))
                    //返回模型
//                    let dictionary = try JSONSerialization.jsonObject(with: responese.data!) as? [String : Any]
//                    guard dictionary?.count != 0 else {
//                        return
//                    }
//                    if  dictionary!["code"] != nil {
//                        guard dictionary!["code"] as! Int == 0 else {
//
//                            if dictionary!["code"] as! Int == 403 {
//                                failureBack("Token 失效，请重新登录")
//                                UIViewController.current?.view.window?.rootViewController = LoginViewController()
//                            }else{
//                                failureBack(dictionary!["msg"] as! String)
//                            }
//
//                            return
//                        }
//                        successBack((dictionary?["data"]))
//                    }else{
//                        let status = dictionary!["success"] as? Bool
//                        if status == true {
//                            successBack((dictionary?["data"]))
//                        }
//                    }
                } catch {
                    print("返回数据转字典失败")
                }
                break
            case .failure:
                print("\(String(describing: responese.error))")
                break
            }
        }
    }
}
