//
//  UploadFileUtils.swift
//  iPayment
//
//  Created by Alaa Khoury on 22/01/2022.
//  Copyright © 2022 Alaa Khoury. All rights reserved.
//

import Foundation
import Firebase

class UploadFileUtils {

    let storage = Storage.storage()
    var temporaryDir: StorageReference

    init() {
        let storageRef = storage.reference()
        temporaryDir = storageRef.child("temporary")
    }

    func upload(_ data: Data?, _ onProgress: ((Int) -> Void)?) {
        guard let data = data else {
            return
        }

        let newImageRef = temporaryDir.child(getImageName())
        let uploadTask = newImageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                return
            }

            let size = metadata.size

            newImageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }

                print("Alaa", "Download URL", downloadURL)
                print("Alaa", "Size", size / 1024, "KB")
            }
        }

        uploadTask.observe(.progress) { snapshot in
            guard let onProgress = onProgress else { return }

            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Alaa", "Progress:", percentComplete)

            onProgress(Int(percentComplete))
        }
    }

    private func getImageName() -> String {
        let uid = Auth.auth().currentUser?.uid ?? "UID"
        let time = NSDate().timeIntervalSince1970

        return "\(uid)/\(time).jpg"
    }

}
