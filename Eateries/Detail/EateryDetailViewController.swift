//
//  EateryDetailViewController.swift
//  Eateries
//
//  Created by Sergey on 30.04.18.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

class EateryDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapButton: UIButton!
    
    //segue "ShowDetail" make unVisible navigation bar
    @IBOutlet weak var rateButton: UIButton!
    
    var restuarant: Restaurant?
    
    //возврат
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard let svc = segue.source as? RateViewController else { return }
        guard let rating = svc.restRating else { return }
        rateButton.setImage(UIImage(named: rating), for: .normal)
        print(rating.description)
    }
    
    //делаем не скрываемый navContr
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //оформляем кнопки
        let buttons = [rateButton, mapButton]
        
        for button in buttons {
            guard let button = button else { break }
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
        }
        
        tableView.estimatedRowHeight = 38
        //высота ячейки - автомат.
        tableView.rowHeight = UITableViewAutomaticDimension
        
        imageView.image = UIImage(data: restuarant!.image! as Data)
//        tableView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//        tableView.separatorColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = restuarant!.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EateryDetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Название"
            cell.valueLabel.text = restuarant!.name
        case 1:
            cell.keyLabel.text = "Тип"
            cell.valueLabel.text = restuarant!.type
        case 2:
            cell.keyLabel.text = "Адрес"
            cell.valueLabel.text = restuarant!.location
        case 3:
            cell.keyLabel.text = "Я там был"
            cell.valueLabel.text = restuarant!.isVisited ? "Да" : "Нет"
        default:
            break
        }
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    //not select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            let dvc = segue.destination as! MapViewController
            dvc.restuarant = self.restuarant
            
        }
    }
    
}
