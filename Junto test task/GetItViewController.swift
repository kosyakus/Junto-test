//
//  GetItViewController.swift
//  Junto test task
//
//  Created by Admin on 10.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class GetItViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var webNews: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        let url = URL(string: webNews)
        
        if let unwrUrl = url {
            let request = URLRequest(url: unwrUrl)
            DispatchQueue.global().async {
                self.webView.loadRequest(request)
            }
        } else {
            print("no web")
        }
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
