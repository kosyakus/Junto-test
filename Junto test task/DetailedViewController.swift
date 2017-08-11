//
//  DetailedViewController.swift
//  Junto test task
//
//  Created by Admin on 10.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var currentNews: News?

    @IBOutlet weak var screenShot: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var votesCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imgURL:URL = URL(string: (currentNews?.screenShot)!)!
        let imgData = try! Data(contentsOf: imgURL)
        screenShot.image = UIImage(data: imgData)
        
        name.text = currentNews?.name
        descr.text = currentNews?.descr
        if let votes = currentNews?.upvotes {
            votesCount.text = String(votes)
        }
        //votesCount.text = String(describing: currentNews?.upvotes)
        
        // Do any additional setup after loading the view.
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
    
 /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "f_DetailedVC_t_webView" {
            let someVar = segue.destination as! GetItViewController
            //let view = sender as! UIViewController
            //let indexPathNew = ViewController.indexPath(for: cell)
            if let newsUrl = currentNews?.url {
            someVar.webNews = newsUrl
            }
        }
    }*/
    
    @IBAction func getIt(_ sender: Any) {
        if let newsUrl = currentNews?.url {
            let url = URL(string: newsUrl)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        //NSString *path = @"http://www.youtube.com/watch?v=Xp697DqsbUU";
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
    }

}
