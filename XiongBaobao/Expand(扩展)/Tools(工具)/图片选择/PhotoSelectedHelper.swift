//
//  PhotoSelectedHelper.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

typealias SelectedPhotoBlock = (UIImage) -> Void

class PhotoSelectedHelper: NSObject,UINavigationControllerDelegate {
    
    var selectedPhoto: SelectedPhotoBlock?
    
    static let shard = PhotoSelectedHelper()
    
    func showImagePicker(title: String, allowCrop: Bool) {
        NSObject.showSheetView(title: title, message: nil, actionArray: ["拍照","相册"]) { (index) in
            if index == 0 {
                let imagePickerVc = TZImagePickerController(maxImagesCount: 1, delegate: self)
                imagePickerVc!.allowTakePicture = false
                imagePickerVc!.allowTakeVideo = false
                imagePickerVc!.allowPickingVideo = false
                imagePickerVc!.allowPickingOriginalPhoto = false
                imagePickerVc!.allowCrop = allowCrop
                imagePickerVc!.circleCropRadius = Int((kScreenWidth - 50) / 2)
            } else {
                self.takePhotoCamera()
            }
        }
    }
    
    private func takePhotoCamera() {
        if !NSObject.judgeSystemAuthority(type: .video) {
            return
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.delegate = self
            imagePickerVC.allowsEditing = true
            imagePickerVC.sourceType = .camera
            imagePickerVC.cameraDevice = .rear
            NSObject.currentNavigationController().present(imagePickerVC, animated: true, completion: nil)
        }
    }
}

extension PhotoSelectedHelper: UIImagePickerControllerDelegate,TZImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image: UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        if (self.selectedPhoto != nil) {
            self.selectedPhoto!(image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        if (self.selectedPhoto != nil) {
            self.selectedPhoto!(photos[0])
        }
    }
}
