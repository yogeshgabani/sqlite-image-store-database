//
//  ViewController.swift
//  sqllite
//
//  Created by TOPS on 11/11/17.
//  Copyright © 2017 TOPS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet weak var mobile: UITextField!
   
    var style = ToastStyle()
    
    let picker = UIImagePickerController()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }

    var arr :[Any] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        img.layer.cornerRadius = img.frame.size.width/2;
        img.clipsToBounds = true

        
        
        let db = profileclass()
        let query = "select * from student"
        let arr = db.getdata(query: query)
        print(arr)
        
        tap()
    }
    
    func tap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handle))
        tap.numberOfTapsRequired = 1;
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tap)
    }
    func handle(sender: UITapGestureRecognizer) {
        picker.sourceType = .photoLibrary
        picker.delegate = self;
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        img.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func saveImageDocumentDirectory(imgname:String,imagedata:UIImage){
        
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imgname)
        print(paths);
        
        let image = imagedata;
        
        print(paths)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)

    }
    
    
    
    
    @IBAction func submit(_ sender: Any)
    {
        
        let db = profileclass()
        let imgname = name.text!+".jpg"
        
        let query = "insert into student(name,address,city,mobile,imgname) values('\(name.text!)','\(address.text!)','\(city.text!)','\(mobile.text!)','\(imgname)')";
        
        let st = db.dmloop(query: query)
        
       
        name.text = "";
        address.text = "";
        city.text = "";
        mobile.text = "";
        
        
        
        if st == true {
            print("record inserted successfully")
            self .saveImageDocumentDirectory(imgname: imgname, imagedata: img.image!)
            
        
            
        let a = self.navigationController?.viewControllers[0] as! profilelist
            a.b = 1
            
        self.navigationController?.popToRootViewController(animated: true)
            
         
            
            
            
            
            
            
        }
            
        else {
            print("record not inserted")
            //  let alert = UIAlertController(title: "unsuccess", message: "record not inserted", preferredStyle: .alert)
            //  alert.self
            
        }
        
        

        
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

