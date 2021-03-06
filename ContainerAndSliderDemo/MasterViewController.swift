//
//  ViewController.swift
//  ContainerAndSliderDemo
//
//  Created by Padmanabhan, Avinash on 4/21/17.
//  Copyright © 2017 Intuit. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var menuShowing = false
    var currentViewController: UIViewController?
    var profileViewController: UIViewController?
    var timelineViewController: UIViewController?
    var mentionsViewController: UIViewController?
    
    //addd a controller to view
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        //view.addSubview(viewController.view)
        view.insertSubview(viewController.view, at: 0)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
        
    }

    //remove the controller from view
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        //setting up the storyboard and instantiating the controllers
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        timelineViewController = storyboard.instantiateViewController(withIdentifier: "TimelineViewController") as! TimelineViewController
        mentionsViewController = storyboard.instantiateViewController(withIdentifier: "MentionsViewController") as! MentionsViewController
        
        //setting the default controller as the profile view controller
        currentViewController = profileViewController
        add(asChildViewController: currentViewController!)
    }
    
    @IBAction func onMenuTap(_ sender: Any) {
        if menuShowing {
            leadingConstraint.constant = -290
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height/3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Profile"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Timeline"
        } else {
            cell.textLabel?.text = "Mentions"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            remove(asChildViewController: currentViewController!)
            currentViewController = profileViewController
            add(asChildViewController: profileViewController!)
            break
        case 1:
            remove(asChildViewController: currentViewController!)
            currentViewController = timelineViewController
            add(asChildViewController: timelineViewController!)
            break
        case 2:
            remove(asChildViewController: currentViewController!)
            currentViewController = mentionsViewController
            add(asChildViewController: mentionsViewController!)
            break
        default:
            print("Error")
            
        }
    }
}

