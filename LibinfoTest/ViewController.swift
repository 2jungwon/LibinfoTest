//
//  ViewController.swift
//  LibinfoTest
//
//  Created by 이정원 on 24/05/2019.
//  Copyright © 2019 Jungwon Lee. All rights reserved.
//

import UIKit

struct AllInfo: Decodable {
    let sogang: [BookInfo]
    let yonsei: [BookInfo]
    let ewha: [BookInfo]
    let hongik: [BookInfo]
}

struct BookInfo: Decodable {
    let no: String
    let location: String
    let callno: String
    let id: String
    let status: String
    let returndate: String
}

class ViewController: UIViewController {

    @IBOutlet var isbn: UITextField!
    @IBAction func search(_ sender: Any) {
       self.printLibinfo()
    }
    
    @IBOutlet var no: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var callno: UILabel!
    @IBOutlet var id: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var returndate: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func printLibinfo() {
        let isbn = self.isbn.text!
        let urlstring = "https://kw7eq88ls8.execute-api.ap-northeast-2.amazonaws.com/Prod/libinfo?isbn="+isbn
        
        guard let url = URL(string: urlstring) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
            
            do {
                let allinfo = try JSONDecoder().decode(AllInfo.self, from: data)
                DispatchQueue.main.async {
                    self.no.text = allinfo.sogang[0].no
                    self.location.text = allinfo.sogang[0].location
                    self.callno.text = allinfo.sogang[0].callno
                    self.id.text = allinfo.sogang[0].id
                    self.status.text = allinfo.sogang[0].status
                    self.returndate.text = allinfo.sogang[0].returndate
                }
            } catch let jsonErr {
                print("Error", jsonErr)
            }
            }.resume()
    }

}

