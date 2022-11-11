//
//  UploadPostViewController.swift
//  instagram-Tecsup
//
//  Created by MAC43 on 11/11/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class UploadPostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var txtTitlePost: UITextField!
    @IBOutlet weak var previeImage: UIImageView!
    @IBOutlet weak var txtPostDescription: UITextField!
    
    
    
    let imagePicker = UIImagePickerController()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpImagePost()
    }
    
    func setUpImagePost() {
        imagePicker.delegate = self
    }
    
    func imageFromUrl(url:String){
        let imageUrl = URL(string: url)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            previeImage.image = UIImage(data: imageData)
            previeImage.contentMode = .scaleToFill
        }
    }
    
    func savePostData(url: String){
        db.collection("post").addDocument(data: [
            "title": txtTitlePost.text!,
            "description": txtPostDescription.text!,
            "image": url,
            "userId": Auth.auth().currentUser?.uid
        ])
    }
    
    @IBAction func onTapSavePostImage(_ sender: UIButton) {
        uploadImage()
        
        
    }
    
    
    @IBAction func onTapOnGalleryPost(_ sender: UIButton) {
        imagePicker.isEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
    }
    
    func uploadImage(){
        let storageRef = Storage.storage().reference().child("\(Auth.auth().currentUser?.uid ?? "").png")
        if let uploadDataImage = self.previeImage.image?.jpegData(compressionQuality: 0.5){
            storageRef.putData(uploadDataImage) { metadata, error in
                if error == nil {
                    storageRef.downloadURL { url, error in
                        print(url?.absoluteString)
                        self.savePostData(url: url?.absoluteString ?? "")
                        //Sincronia para que no guarde los campos vacios
                        self.txtTitlePost.text = ""
                        self.txtPostDescription.text = ""
                        self.previeImage.image = nil
                    }
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[.originalImage] as? UIImage{
            previeImage.image = pickerImage
            previeImage.contentMode = .scaleToFill
        }
        imagePicker.dismiss(animated: true)
    }

}
