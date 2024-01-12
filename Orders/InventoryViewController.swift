//
//  InventoryViewController.swift
//  Orders
//
//  Created by Azhad Khan on 26/12/23.
//

import UIKit
import PhotosUI
import Photos

class InventoryViewController: UIViewController{
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var udded: UIView!
    @IBOutlet weak var inventoryTableView: UITableView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    
    var imagesData:[UIImage]  = []
    var arrData = ["Watch","Sunglases","PenDrive","Laptop Charging"]
    override func viewDidLoad() {
        super.viewDidLoad()
        udded.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: All Action
    
    @IBAction func saveDataButtonPessed(_ sender: UIButton) {
        
        let sheet = UIAlertController(title: "Add Image", message: "", preferredStyle: .actionSheet)
        let CancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Canel Button Pressed")
        }
        let ChoosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { (action) in
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            let phPickerVc = PHPickerViewController(configuration: config)
            phPickerVc.delegate = self
            self.present(phPickerVc, animated: true)
        }
        
        
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            let alert = UIAlertController(title: "Server is Down", message: "Camera not working in Simulator Device", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        sheet.addAction(takePhoto)
        sheet.addAction(ChoosePhoto)
        sheet.addAction(CancelButton)
        present(sheet, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    @IBAction func addDataToInverntry(_ sender: UIButton) {
        
        
        if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
            return
        }
        else {
            arrData.append(textField.text ?? "")
            inventoryTableView.reloadData()
            textField.text = " "
        }
        
    }
    
}



//MARK: All Extension

extension InventoryViewController:PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    self.imagesData.append(image)
                }
                DispatchQueue.main.async {
                    self.imagesCollectionView.reloadData()
                }
            }
        }
    }
    
    
}


extension InventoryViewController:UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.label.text = arrData[indexPath.row]
        cell.deleteButton.tag = indexPath.row
        cell.delegate = self
        return cell
    }
}


extension InventoryViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}

extension InventoryViewController:DeleteInventoryDelegate {
   
   

    func delectInventry(index: Int) {
        let alert = UIAlertController(title: "Alert", message: "Are You Sure Want to Delete", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Yes", style: .default) {
            (action) in
            self.arrData.remove(at: index)
            DispatchQueue.main.async {
                self.inventoryTableView.reloadData()
            }
        }
        let noButton = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        self.present(alert,animated:true)
        
       
    }
    
                
}

extension InventoryViewController:UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        imageCell.imageView.image  = imagesData[indexPath.row]
        imageCell.imageView.layer.cornerRadius = 8.0
        return imageCell
    }
    
    
}

extension InventoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: 100)
    }
}

