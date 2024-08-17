//
//  ProfilePresenter.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 30.07.2024.
//

import Foundation
import Firebase
import SDWebImage

protocol ProfilePresenterProtocol: AnyObject {
    var email: String? { get }
    func uploadImage(image: UIImage)
    func loadImageUrl()
    func signOut()
}

final class ProfilePresenter: ProfilePresenterProtocol {
    private let appModel = AppModel()
    private let profileModel = ProfileModel()
    weak var view: ProfileViewProtocol?
    
    init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    let email: String? = Auth.auth().currentUser?.email
    
    func signOut() {
        appModel.signOut()
    }
    
    func uploadImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        profileModel.uploadImage(image: imageData)
        
        //        if let imageData = image.pngData() {
        //            print("Это изображение PNG")
        //            profileModel.uploadImage(image: imageData)
        //        } else if let imageData = image.jpegData(compressionQuality: 0.1) {
        //            print("Это изображение JPEG")
        //            profileModel.uploadImage(image: imageData)
        //        } else {
        //            print("Не удалось определить формат изображения")
        //        }
    }
    
    func loadImageUrl() {
        //        let image: UIImageView?
        profileModel.loadAvatarUrl { [weak self] result in
            switch result {
            case .success(let url):
                self?.view?.setAvatar(url: url)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
