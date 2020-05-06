//
//  ConvertController.swift
//  Convertisseur
//
//  Created by Mathias Bouillon on 06/05/2020.
//  Copyright © 2020 Mathias Bouillon. All rights reserved.
//

import UIKit

class ConvertController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryView: UIView!
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var dataTextFiled: UITextField!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
    //créer un var type nul
    var type: String?
    
    var views: [UIView] = []
    
    var isReverse = false
    
    let euros = "euros"
    let dollar = "dollars"
    let km = "kilomètre"
    let mi = "miles"
    let celsius = "celsius"
    let fahrenheit = "fahrenheit"
    let format = "%.2f"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let choix = type
        {
            views = [entryView, resultView]
            arrondirLesAngles()
            typeChoisi(choix)
        }else {
            dismiss(animated: true, completion: nil)
        }
        //pour rentrer le clavier
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    
    //function pour rentrer le clavier en Obj-C
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    //Permet de modifier l'ordre des données
    func setup(_ primary: String, _ secondary: String) {
        if !isReverse{
            titleLabel.text = "Convertir " + primary + " en " + secondary
            toDoLabel.text = "Entrez le nombre de " + primary
        } else{
            titleLabel.text = "Convertir " + secondary + " en " + primary
            toDoLabel.text = "Entrez le nombre de " + secondary
        }
    }
    
    //Permet de setup le Label
    func typeChoisi(_ choix: String) {
        switch choix {
        case DEVISE: setup(euros, dollar)
        case DISTANCE: setup(km, mi)
        case TEMPERATURE: setup(celsius, fahrenheit)
        default: break
        }
    }
    
    func arrondirLesAngles() {
        for i in views {
            i.layer.cornerRadius = 10
        
        }
    }
    
    
    //Logique du calcul
    
    func calculate() {
        //si type est diff de nul, si il y a un text dans le textField et si il est convertible en double
        if let monType = type, let texte = dataTextFiled.text, let double = Double(texte){
            
            switch monType {
            case DEVISE:
                //si isReverve = true = euros sinon faux = dollars
                resultLabel.text = isReverse ? euros(double) : dollar(double)
            case TEMPERATURE:
                resultLabel.text = isReverse ? celsius(double) : fahrenheit(double)
            case DISTANCE:
                resultLabel.text = isReverse ? km(double) : miles(double)
            default:
                break
            }
        }
    }
    
    func dollar(_ euros: Double) -> String {
        return String(format: format, (euros / 0.81)) + " $"
    }
    
    func euros(_ dollars: Double) -> String {
        return String(format: format, (dollars * 0.81)) + " €"
    }
    
    func miles(_ km: Double) -> String {
        return String(format: format, (km * 0.621)) + " mi"
    }
    
    func km(_ miles: Double) -> String {
        return String(format: format, (miles / 0.621)) + " km"
    }
    
    func celsius(_ fahrenheit: Double) -> String {
        return String(format: format, ((fahrenheit - 32) / 1.8)) + " °C"
    }
    
    func fahrenheit(_ celsius: Double) -> String {
        return String(format: format, ((celsius * 1.8) + 32)) + " fh"
    }
    
    
    
    //Vérifie si le type existe puis échange
    @IBAction func changeButton(_ sender: Any) {
        guard type != nil else { return }
        isReverse = !isReverse
        typeChoisi(type!)
        calculate()
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        calculate()
    }
    
}

