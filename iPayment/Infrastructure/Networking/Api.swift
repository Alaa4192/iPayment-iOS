//
//  Api.swift
//  iPayment
//
//  Created by Alaa Khoury on 27/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI
import Alamofire

class Api {
    fileprivate let host: String = "https://vast-badlands-01149.herokuapp.com"

//    func koko(endpoint: String) {
//        guard let url = URL(string: endpoint) else {
//            print("Invalid url...")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = ""
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            let groups = try! JSONDecoder().decode(BaseListModel<GroupModel>.self, from: data!)
//
//            print(groups)
//            DispatchQueue.main.async {
//                // completion(books)
//            }
//        }.resume()
//    }

    fileprivate func doPostRequest<T: Decodable>(endpoint: String, encodedJson: Any, type: T.Type, result: @escaping (T) -> Void) {
        do {
            let json = try JSONSerialization.data(withJSONObject: encodedJson, options: []) as? [String : Any]

            AF.request(endpoint, method: .post, parameters: json, encoding: JSONEncoding.default)
                .validate()
                .responseDecodable(of: type.self) { (response) in
                    guard let res = response.value else { return }
                    // print(res)
                    DispatchQueue.main.async {
                        result(res)
                    }
            }
        } catch {
             print(error.localizedDescription)
        }
    }

    fileprivate func doGetRequest<T: Decodable>(endpoint: String, type: T.Type, result: @escaping (T) -> Void) {
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: type.self) { (response) in
                guard let res = response.value else { return }
                // print(res)
                DispatchQueue.main.async {
                    result(res)
                }
        }
    }


}

class GroupsRepository: Api {
    func getGroups(result: @escaping (BaseListModel<GroupModel>) -> Void) {
        doGetRequest(endpoint: "\(host)/v1/getGroups", type: BaseListModel<GroupModel>.self, result: result)
    }
}
