//
//  DetailsViewController.swift
//  API_Decoder
//
//  Created by apple on 10/08/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var personFirstNmaeLabel: UILabel!
    
    @IBOutlet weak var personLastNameLabel: UILabel!
    
    @IBOutlet weak var personIdLabel: UILabel!
    
    @IBOutlet weak var personavatorView: UIImageView!
    
    var container : Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindDataToLabels()

    }
    func bindDataToLabels(){
        
        personLastNameLabel.text = container?.last_name
        personFirstNmaeLabel.text = container?.first_name
        personIdLabel.text =  container?.id.codingKey.stringValue
        personavatorView.kf.setImage(with: URL(string: container!.avatar))
        
    
        
    }
}
