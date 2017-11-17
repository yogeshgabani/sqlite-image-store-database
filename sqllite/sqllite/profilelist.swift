//
//  profilelist.swift
//  sqllite
//
//  Created by TOPS on 11/11/17.
//  Copyright © 2017 TOPS. All rights reserved.
//

import UIKit

class profilelist: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    var arr :[Any] = [];
    var style = ToastStyle()
    
    var b  = Int()
    
    @IBOutlet weak var tbl: UITableView!
    
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if b == 1
        
        {
            style.messageColor = .white
            self.view.makeToast("Data Submitted SuccessFully", duration: 1.5, position: .center, style: style)
        }
        
        let db = profileclass()
        
        let query = "select * from student"
        
        arr = db.getdata(query: query)
        print(arr)
        
        tbl.reloadData()
        
            //self.style.messageColor = .white
          //  self.view.makeToast("Data Submitted SuccessFully", duration: 3.0, position: .center, style: self.style)
        
    }

    @IBAction func addbtn(_ sender: Any)
    {
        
        let add = self.storyboard?.instantiateViewController(withIdentifier: "2") as! ViewController
        self.navigationController?.pushViewController(add, animated: true)
      
    }
    
    
    func getImage(imgname:String)->UIImage
    {
        let fileManager = FileManager.default
        
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(imgname)
        
        if fileManager.fileExists(atPath: imagePAth)
        {
            return UIImage(contentsOfFile: imagePAth)!
        }
        else
        {
            return UIImage(named: "userimage.png")!;
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return arr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! custcell
        var trmp = arr[indexPath.section] as! [String]
        
        cell.namecell.text = trmp[1]
        cell.addresscell.text = trmp[3]
        
        let imgname = trmp[5]
        cell.imgcell.image = getImage(imgname: imgname)
        cell.imgcell.layer.cornerRadius = cell.imgcell.frame.size.width/2;
        cell.imgcell.clipsToBounds = true
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayprofile = storyboard?.instantiateViewController(withIdentifier: "3") as! displayprofile
        var trmp = arr[indexPath.section] as! [String]
        
        displayprofile.brr = trmp[0]
        
        self.navigationController?.pushViewController(displayprofile, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        
        var trmp = arr[indexPath.section] as! [String]
        let index = trmp[0]
        
        let db = profileclass()
        let delete = "delete from student where id = '\(index)'"
        
        let st = db.dmloop(query: delete)
        
        if st == true {
            print("record deleted successfully")
           
            let db = profileclass()
            let query = "select * from student"
            arr = db.getdata(query: query)
            tbl.reloadData()
            style.messageColor = .white
            self.view.makeToast("Data Deleted SuccessFully", duration: 1.5, position: .center, style: style)
        }
        else {
            print("record not deleted")
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

class custcell: UITableViewCell {
    
    @IBOutlet weak var imgcell: UIImageView!
    
    @IBOutlet weak var addresscell: UILabel!
    
    @IBOutlet weak var namecell: UILabel!
}
