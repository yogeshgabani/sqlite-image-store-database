//
//  displayprofile.swift
//  sqllite
//
//  Created by TOPS on 11/11/17.
//  Copyright © 2017 TOPS. All rights reserved.
//

import UIKit

class displayprofile: UIViewController {

    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var nametxt: UITextField!
    
    @IBOutlet weak var addtxt: UITextField!
    
   
    @IBOutlet weak var citytxt: UITextField!
   
    @IBOutlet weak var mobtxt: UITextField!
  

    var style = ToastStyle()
    
    
    var brr = ""
    
    var data:[String] = []
    var arr :[Any] = []
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img2.layer.cornerRadius = img2.frame.size.width/2;
        img2.clipsToBounds = true
        
       
        getdata()
        
    }
    
    func getdata()
    {
        let db = profileclass()
        let query = "select * from student where id = '\(brr)'"
        arr = db.getdata(query: query)
        print(arr)
        let  brr1 =  arr[0] as! [String];
        
        nametxt.text = brr1[1]
        addtxt.text = brr1[2]
        citytxt.text = brr1[3]
        mobtxt.text = brr1[4]
        let imgname = brr1[5]
        img2.image = getImage(imgname: imgname)
        img2
            .layer.cornerRadius = self.img2.frame.size.width / 2;
        //   img.layer.cornerRadius = self.img.frame.size.height/2;
        img2.clipsToBounds = true
        
        nametxt.isUserInteractionEnabled = false
        addtxt.isUserInteractionEnabled = false
        citytxt.isUserInteractionEnabled = false
        mobtxt.isUserInteractionEnabled = false

    }
    
    
    func getImage(imgname:String)->UIImage {
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(imgname)
        if fileManager.fileExists(atPath: imagePAth){
            return UIImage(contentsOfFile: imagePAth)!
        }else{
            
            return UIImage(named: "userimage.png")!;
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    
    @IBAction func editdata(_ sender: Any) {
        
        nametxt.isUserInteractionEnabled = true
        addtxt.isUserInteractionEnabled = true
        citytxt.isUserInteractionEnabled = true
        mobtxt.isUserInteractionEnabled = true
        
        

        
    }
    
    
    @IBAction func donedata(_ sender: Any) {
        nametxt.isUserInteractionEnabled = false
        addtxt.isUserInteractionEnabled = false
        citytxt.isUserInteractionEnabled = false
        mobtxt.isUserInteractionEnabled = false
        
        let  brr1 =  arr[0] as! [String];
        
        let db = profileclass()
        let update = String(format: "update student set name = '%@',address = '%@',city = '%@',mobile = '%@' where  id = '\(brr1[0])'", nametxt.text!,addtxt.text!,citytxt.text!,mobtxt.text!)
        
        let st = db.dmloop(query: update)
        //  tbl.reloadData()
        if st == true {
            print("record updated successfully")
            //   let alert = UIAlertController(title: "success", message: "record inserted successfully", preferredStyle: .alert)
            // alert.self
            let db = profileclass()
            let query = "select * from student"
            arr = db.getdata(query: query)
            let  brr1 =  arr[0] as! [String];
            
            nametxt.text = brr1[1]
            addtxt.text = brr1[2]
            citytxt.text = brr1[3]
            mobtxt.text = brr1[4]
            
            style.messageColor = .white
            self.view.makeToast("Data Updated SuccessFully", duration: 1.5, position: .center, style: style)
            
        }
        else {
            print("record not updated")
            //  let alert = UIAlertController(title: "unsuccess", message: "record not inserted", preferredStyle: .alert)
            //  alert.self
            
        }
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
