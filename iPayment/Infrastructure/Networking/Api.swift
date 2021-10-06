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
    private lazy var v1_getGroups = "\(host)/v1/getGroups"

    func getGroups(result: @escaping (BaseListModel<GroupModel>) -> Void) {
        doGetRequest(endpoint: v1_getGroups, type: BaseListModel<GroupModel>.self, result: result)
    }
}

class UsersRepository: Api {
    private lazy var v1_getUsers = "\(host)/v1/getUsers"


    func getUsers(result: @escaping (BaseListModel<UserModel>) -> Void) {

        doGetRequest(endpoint: v1_getUsers, type: BaseListModel<UserModel>.self, result: result)
    }
}
