//
//  ViewController.swift
//  BottomPopUpViewExamples
//
//  Created by Akbar on 6/9/20.
//  Copyright © 2020 Akbar. All rights reserved.
//

import UIKit
import BottomPopUpView

class ViewController: UIViewController {

    @IBAction func fullViewHeightButton(_ sender: Any) {
        let bottomPopUpView = BottomPopUpView(wrapperContentHeight: self.view.frame.height) /* Create an instance of BottomPopUpView with height */
        self.isAirPods = false /* Just for testing case, nevermind */
        
        bottomPopUpView.tableView.dataSource = self /* Set the data source of table view */
        
        /* Create a Xib UITableViewCell and register it */
        let nib = UINib(nibName: "ExampleUITableViewCell", bundle: nil)
        bottomPopUpView.tableView.register(nib, forCellReuseIdentifier: "ExampleUITableViewCell")
        
        /* Present, very easy :) */
        self.present(bottomPopUpView, animated: true, completion: nil)
    }
    
    @IBAction func customHeightButton(_ sender: Any) {
        let bottomPopUpView = BottomPopUpView(wrapperContentHeight: self.view.frame.height / 2) /* Create an instance of BottomPopUpView with height */
        self.isAirPods = false /* Just for testing case, nevermind */
        
        bottomPopUpView.tableView.dataSource = self /* Set the data source of table view */
        
        /* Create a Xib UITableViewCell and register it */
        let nib = UINib(nibName: "ExampleUITableViewCell", bundle: nil)
        bottomPopUpView.tableView.register(nib, forCellReuseIdentifier: "ExampleUITableViewCell")
        
        /* Present, very easy :) */
        self.present(bottomPopUpView, animated: true, completion: nil)
    }
    
    @IBAction func airPods(_ sender: Any) {
        /* NOTE: TO MAKE AN ANIMATION WORK GO TO THE ExampleAirPodsTableViewCell.swift file and UNCOMMENT awakeFromNib content */
        
        
        let bottomPopUpView = BottomPopUpView(wrapperContentHeight: 400)/* Create an instance of BottomPopUpView with height */
        
        self.isAirPods = true/* Just for testing case, nevermind */
        
        bottomPopUpView.tableView.dataSource = self/* Set the data source of table view */
        bottomPopUpView.backgroundViewAlpha = 0.3 /* Change backgroundViewAlpha */
        bottomPopUpView.shouldDismissOnDrag = false /* Dismiss on Drag */
        
        /* Create a Xib UITableViewCell and register it */
        let airPodsNib = UINib(nibName: "ExampleAirPodsTableViewCell", bundle: nil)
        bottomPopUpView.tableView.register(airPodsNib, forCellReuseIdentifier: "ExampleAirPodsTableViewCell")
        
        /* Present, very easy :) */
        self.present(bottomPopUpView, animated: true, completion: nil)
    }
    
    var isAirPods: Bool = false // Just for testing case
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isAirPods ? 1 : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isAirPods {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleAirPodsTableViewCell") as? ExampleAirPodsTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleUITableViewCell") as? ExampleUITableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = "Example title: \(indexPath.row)"
            cell.descriptionLabel.text = "Example description: \(indexPath.row)"
            return cell
        }
    }
}
