//
//  FirstTableViewController.swift
//  Junto test task
//
//  Created by Admin on 09.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Dropper

class FirstTableViewController: UITableViewController {
    
    var refresher: UIRefreshControl!
    
    func refresh(){
        
        print("refreshed")
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        
        self.refresher.endRefreshing()
        
    }

    
    var newsDate = [News]()
    let dropper = Dropper(width: 150, height: 300)
    
    @IBOutlet weak var dropdown: UIButton!
    
    typealias downloadNewsCompletion = () -> Void
    
    func downloadNews(category: String, completion: @escaping (_ success: Bool) -> Void) {
        
        //var newsArray = [News]()
        Alamofire.request(Router.getNews(search: category, access_token: "591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff")).responseJSON { [weak self] response in
            
            switch response.result {
            case .success(let rawJson):
                if let newsArrayFromJson = self?.parseNewsFromJson(rawJson: rawJson) {
                    self?.newsDate = newsArrayFromJson
                    //print(newsArray)
                }
                completion(true)
                DispatchQueue.main.async() {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseNewsFromJson(rawJson: Any) -> [News] {
        let json = JSON(rawJson)
        //print(json)
        //let jsonArray = json["posts"]
        var newsArray = [News]()
        for (_, subJson):(String, JSON) in json["posts"] {
            
            if  let addNews = News(subJson) {
                newsArray.append(addNews)
                //print(newsArray)
            }
         
         }
      
        return newsArray
    } 
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "pull to refresh")
        
        refresher.addTarget(self, action: #selector(FirstTableViewController.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refresher)
        refresh()
        
        self.downloadNews(category: "tech") { (success) in
            if success {
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
            }
            
        }
        
        self.title = "Tech"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // newsDate = downloadNews()
        print("count rows \(newsDate.count)")
        return newsDate.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! FirstTableViewCell

        //newsDate = downloadNews()
        let news = newsDate[indexPath.row]
        
        cell.name.text = news.name
        cell.descrip.text = news.descr
        cell.votesCount.text = String(news.upvotes)
        
        let imgURL:URL = URL(string: news.thumbnail)!
        let imgData = try! Data(contentsOf: imgURL)
        cell.thumbnail.image = UIImage(data: imgData)
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func DropdownAction() {
        if dropper.status == .hidden {
            dropper.items = ["Tech", "Games", "Books", "Artificial Intelligence", "Developer Tools", "Home", "Productivity", "Touch Bar Apps", "Wearables"]
            dropper.theme = Dropper.Themes.white
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: .center, position: .bottom, button: dropdown)
            view.addSubview(dropper)
            print("DROOOOOP")
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (dropper.isHidden == false) { // Checks if Dropper is visible
            dropper.hideWithAnimation(0.1) // Hides Dropper
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "f_FirstVC_t_DetailedVC" {
            let someVar = segue.destination as! DetailedViewController
            let cell = sender as! UITableViewCell
            let indexPathNew = tableView.indexPath(for: cell)
            
            someVar.currentNews = newsDate[indexPathNew!.row]
        }
    }

}

extension FirstTableViewController: DropperDelegate {
    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        self.title = "\(contents)"
        let newCategory = String(contents).lowercased()
        self.downloadNews(category: newCategory) { (success) in
            if success {
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
}
