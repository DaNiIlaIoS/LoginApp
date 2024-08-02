//
//  ProfileModel.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 02.08.2024.
//

import Foundation
import Firebase
import FirebaseStorage

final class ProfileModel {
    func uploadImage(image: Data) {
        let imageName = "avatar" + ".jpeg"
        let ref = Storage.storage().reference().child(AppModel.userId + "/avatars/").child(imageName)
        
        uploadOneImage(image: image, storage: ref) { [weak self] result in
            switch result {
            case .success(let url):
                print(url.absoluteString)
                self?.setUserAvatar(stringUrl: url.absoluteString)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadAvatarUrl(completion: @escaping (Result<URL, Error>) -> ()) {
        Firestore.firestore()
            .collection("users")
            .document(AppModel.userId)
            .getDocument { snapshot, error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                if let document = snapshot {
                    if let stringUrl = document["avatarURL"] as? String,
                       let url = URL(string: stringUrl) {
                        completion(.success(url))
                    }
                }
            }
    }
    
    private func setUserAvatar(stringUrl: String) {
        Firestore.firestore()
            .collection("users")
            .document(AppModel.userId)
            .setData(["avatarURL": stringUrl], merge: true)
    }
    
    private func uploadOneImage(image: Data?, storage: StorageReference, completion: @escaping (Result<URL, Error>) -> ()) {
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        guard let imageData = image else { return }
        
        storage.putData(imageData, metadata: metaData) { meta, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            storage.downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
    }
}
