//
//  JGPDFCreatorViewController.swift
//  JGPDFCreator
//
//  Created by Jeisson González on 15/12/17.
//  Copyright © 2017 wigilabs. All rights reserved.
//

import UIKit
import WebKit

class JGPDFCreatorViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    
    public var finalCallback: (String) -> Void = {item in}
    
    @IBOutlet var table: UITableView!
    var container = [[String:Any]]()
    var list=[[String:String]]()
    
    
    public func createPDF(parent:UINavigationController,listProducts:[[String:String]], callback:@escaping (String) -> Void){
        //print(listProducts)
        
        let storyboard = UIStoryboard(name: "JGPDFCreator", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "JGPDFCreator") as! JGPDFCreatorViewController
        controller.finalCallback=callback;
        controller.list=listProducts;
        
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
        controller.providesPresentationContextTransitionStyle = true;
        controller.definesPresentationContext = true;
        parent.present(controller, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let logo=UIImage.init(named: "logo_es")!
        let body=UIImage.init(named: "body_es")!
        let footer=UIImage.init(named: "footer_es")!
        
        container.append(["cell":"CellImage","imagen":logo])
        container.append(["cell":"CellImage","imagen":body])
        container.append(["cell":"CellTutulo"])
        
        for item in list{
            container.append([
                "cell":"CellProducto",
                "description":item["description"]!,
                "codigo":item["codigo"]!,
                "suture":item["suture"]!,
                "diameter":item["diameter"]!,
                "sutureLength":item["sutureLength"]!,
                "NeddleName":item["NeddleName"]!,
                "needlePointType":item["needlePointType"]!,
                "size":item["size"]!
                ])
        }
        
        container.append(["cell":"CellImage","imagen":footer])
        
        let heitghProducts=CGFloat(list.count*65)
        let heigthTable=logo.size.height+body.size.height+footer.size.height+heitghProducts+55
        
        table.frame=CGRect(x: 0, y: 0, width: 920, height: heigthTable)
        table.separatorStyle = .none
        
        let image=UIImage.init(view: table)
        
        let data=NSData.convertImageToPDF(image: image)
        
        let filename = getDocumentsDirectory().appendingPathComponent("file.pdf")
        data?.write(to: filename, atomically: true)
        //print(filename.absoluteString)
        
        finalCallback(filename.absoluteString)
        self.dismiss(animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item=container[indexPath.row]
        
        if (item["cell"] as! String)  == "CellImage" {
            return ((item["imagen"] as! UIImage).size.height)
        }else if (item["cell"] as! String)  == "CellProducto" {
            return 65
        }else{
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return container.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item=container[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: (item["cell"] as! String), for: indexPath) as! JGPDFCreatorCell
        
        if (item["cell"] as! String)  == "CellImage" {
            cell.imageBg.image=(item["imagen"] as! UIImage)
        }else if (item["cell"] as! String)  == "CellProducto" {
            cell.label1.text=(item["description"] as! String)
            cell.label2.text=(item["codigo"] as! String)
            cell.label3.text=(item["suture"] as! String)
            cell.label4.text=(item["diameter"] as! String)
            cell.label5.text=(item["sutureLength"] as! String)
            cell.label6.text=(item["NeddleName"] as! String)
            cell.label7.text=(item["needlePointType"] as! String)
            cell.label8.text=(item["size"] as! String)
        }
        
        return cell
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

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}

