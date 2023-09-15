//
//  ViewController.swift
//  API_Decoder
//
//  Created by apple on 10/08/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var PersonCollectionView: UICollectionView!
    
    private let urlString = "https://reqres.in/api/users?page=2"
    var url : URL?
    var urlRequest : URLRequest?
    var jsonDecodeer : JSONDecoder?
    var persons : [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = URL(string: urlString)
        urlRequest = URLRequest(url: url!)
        initailization()
        registrationOFXIB()
      fectching()
        
    }
    func initailization(){
        PersonCollectionView.dataSource = self
        PersonCollectionView.delegate = self
    }
    func registrationOFXIB(){
        let uiNib = UINib(nibName: "PersonCollectionViewCell", bundle: nil)
        self.PersonCollectionView.register(uiNib, forCellWithReuseIdentifier: "PersonCollectionViewCell")
    }
    
    func fectching(){
        URLSession.shared.dataTask(with: urlRequest!){ data, response, error in
            
            print(error)
            print(response)
            
            let responseRecived = try! JSONDecoder().decode(APIResponse.self, from: data!)
            self.persons = responseRecived.data2
            
            DispatchQueue.main.async {
                self.PersonCollectionView.reloadData()
            }
        }.resume()
    }
    
}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let personCollectionViewCell = self.PersonCollectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell", for: indexPath) as! PersonCollectionViewCell
        
        personCollectionViewCell.personIdLabel.text = String(persons[indexPath.row].id)
        personCollectionViewCell.personFirstNameLabel.text = persons[indexPath.row].first_name
        
        let productImageString = persons[indexPath.row].avatar
        
        personCollectionViewCell.PersonAvatarView.kf.setImage(with: URL(string: productImageString))
        
        return personCollectionViewCell
    }
    
    
}


extension ViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(PersonCollectionView.bounds.width)
                let personCellWidth = PersonCollectionView.bounds.width
                let persontCellHeight = personCellWidth
                
                return CGSize(width: personCellWidth,
                              height: persontCellHeight)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsViewcontroller = self.storyboard?.instantiateViewController(withIdentifier:"DetailsViewController") as! DetailsViewController
        
        detailsViewcontroller.container = Person(id: persons[indexPath.item].id.codingKey.intValue ?? 10,
                                                 email: persons[indexPath.item].email,
                                                 first_name: persons[indexPath.item].first_name,
                                                 last_name: persons[indexPath.item].last_name, avatar:persons[indexPath.item].avatar)
        
        navigationController?.pushViewController(detailsViewcontroller, animated: true)
    
    }
   
}

