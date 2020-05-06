//
//  ViewController.swift
//  Convertisseur
//
//  Created by Mathias Bouillon on 06/05/2020.
//  Copyright © 2020 Mathias Bouillon. All rights reserved.
//

import UIKit

//Constante utilisable pour tout les controleurs
let DEVISE = "Devises"
let TEMPERATURE = "Température"
let DISTANCE = "Distance"


class ViewController: UIViewController {

    @IBOutlet weak var deviseView: UIView!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var temperatureView: UIView!
    
    let segueID = "Convert"
    //Ne peut être rempli  tant que la view n'est pas Load
    var views: [UIView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        views = [deviseView, distanceView, temperatureView]
        arrondirLesAngles()
    }

    //function pour du style
    func arrondirLesAngles() {
        for i in views {
            i.layer.cornerRadius = 10
        }
    }
    
    //vérification si le type existe
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let convertController = segue.destination as? ConvertController {
                convertController.type = sender as? String
            }
        }
    }
    
    //Action pour montrer la bonne vue
    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: performSegue(withIdentifier: segueID, sender: DEVISE)
        case 1: performSegue(withIdentifier: segueID, sender: DISTANCE)
        case 2: performSegue(withIdentifier: segueID, sender: TEMPERATURE)
        default:
            break
        }
    }
    

}

