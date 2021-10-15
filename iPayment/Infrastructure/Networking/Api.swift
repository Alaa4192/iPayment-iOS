//
//  Api.swift
//  iPayment
//
//  Created by Alaa Khoury on 27/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI
import Alamofire
import Firebase

class Api {
    fileprivate let host: String = "https://vast-badlands-01149.herokuapp.com"


    fileprivate func doPostRequest<T: Decodable, E: Encodable>(endpoint: String, encodedJson: E, type: T.Type, result: @escaping (T) -> Void) {
        AF.request(endpoint, method: .post, parameters: encodedJson, encoder: JSONParameterEncoder.default, headers: getHeaders())
            .validate()
//            .responseString { res in
//                print(res)
//            }
            .responseDecodable(of: type.self) { response in
                guard let res = response.value else { return }

                DispatchQueue.main.async {
                    result(res)
                }
            }
    }

    fileprivate func doGetRequest<T: Decodable>(endpoint: String, type: T.Type, result: @escaping (T) -> Void) {
        AF.request(endpoint, method: .get, headers: getHeaders())
            .validate()
//            .responseString { result in
//                print(result)
//            }
            .responseDecodable(of: type.self) { (response) in
                guard let res = response.value else { return }
                // print(res)
                DispatchQueue.main.async {
                    result(res)
                }
        }
    }

    private func getHeaders() -> HTTPHeaders {
        return [
            HTTPHeader(name: "uid", value: Auth.auth().currentUser?.uid ?? "")
        ]
    }

}

class GroupsRepository: Api {
    private lazy var v1_getGroups = "\(host)/v1/getGroups"
    private lazy var v1_createGroup = "\(host)/v1/createGroup"
    private lazy var v1_setFavorite = "\(host)/v1/setFavorite"
    private lazy var v1_removeGroup = "\(host)/v1/removeGroup"
    private lazy var v1_getGroupInfo = "\(host)/v1/getGroupInfo"

    func getGroups(result: @escaping (BaseListModel<GroupModel>) -> Void) {
        doGetRequest(endpoint: v1_getGroups, type: BaseListModel<GroupModel>.self, result: result)
    }

    func createGroup(group: CreateGroup, result: @escaping (CreateGroupResponse) -> Void) {
        doPostRequest(
            endpoint: v1_createGroup,
            encodedJson: group,
            type: CreateGroupResponse.self,
            result: result)
    }

    func setGroupFavorite(request: SetGroupFavoriteRequest, result: @escaping (SetGroupFavoriteResponse) -> Void) {
        doPostRequest(endpoint: v1_setFavorite, encodedJson: request, type: SetGroupFavoriteResponse.self, result: result)
    }

    func removeGroup(request: RemoveGroupRequest, result: @escaping (RemoveGroupResponse) -> Void) {
        doPostRequest(endpoint: v1_removeGroup, encodedJson: request, type: RemoveGroupResponse.self, result: result)
    }

    func getGroupInfo(request: GetGroupInfoRequest, result: @escaping (GroupInfoModel) -> Void) {
        doPostRequest(endpoint: v1_getGroupInfo, encodedJson: request, type: GroupInfoModel.self, result: result)
    }
}

class UsersRepository: Api {
    private lazy var v1_getUsers = "\(host)/v1/getUsers"
    private lazy var v1_getUserProfile = "\(host)/v1/getUserProfile"

    func getUsers(result: @escaping (BaseListModel<UserModel>) -> Void) {
        doGetRequest(endpoint: v1_getUsers, type: BaseListModel<UserModel>.self, result: result)
    }

    func getUserProfile(result: @escaping (UserProfileModel) -> Void) {
        doGetRequest(endpoint: v1_getUserProfile, type: UserProfileModel.self, result: result)
    }
}
