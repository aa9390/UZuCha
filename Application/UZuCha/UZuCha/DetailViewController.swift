//
//  DetailViewController.swift
//  UZuCha
//
//  Created by 수영백 on 2018. 5. 28..
//  Copyright © 2018년 KWJ. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController{
    var selectedPark : Park?
    
    @IBOutlet weak var feeView: UILabel!
    @IBOutlet weak var detailsCapacityView: UILabel!
    @IBOutlet weak var detailsAvailableTimeView: UILabel!
    @IBOutlet weak var detailsFloorView: UILabel!
    @IBOutlet weak var commentView: UILabel!
    @IBOutlet weak var parkImageView: UIImageView!
    
    @IBAction func callingButton(_ sender: Any) {
        if let phoneNum = selectedPark?.owner.phone_num{
            let num = createPhoneNum(phoneNum: phoneNum)
            if let phoneCallURL = URL(string: "tel://\(num)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var rightFavoriteBarButtonItem : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_like"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailViewController.switchColor(_:)))
        self.navigationItem.setRightBarButtonItems([rightFavoriteBarButtonItem], animated: true)
        
        feeView.text = selectedPark?.fee
        
        if let capacity = selectedPark?.details.capacity{
            detailsCapacityView.text = "\(capacity)" + "대"
        }
        if let floor = selectedPark?.details.floor{
            if (floor > 0){
                detailsFloorView.text = "\(floor)" + "층"}
            else{
                detailsFloorView.text = "지하 " + "\(-floor)" + "층"}
        }
        commentView.text = selectedPark?.owner_comment
        
        parkImageView.image = UIImage(named: (selectedPark?.building.image)!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func switchColor(_ sender:UIButton){
        print(1)
    }

}