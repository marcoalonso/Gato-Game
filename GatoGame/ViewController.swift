//
//  ViewController.swift
//  GatoGame
//
//  Created by marco rodriguez on 19/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var empezarBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicializarIG()
    }

    //Agregar estilo 
    func inicializarIG() {
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 12
        cardView.layer.shadowOffset = .zero
    }
    
    //Ocultar teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nombre.resignFirstResponder()
    }
    
    @IBAction func empezarBtn(_ sender: UIButton) {
        guard !nombre.text!.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let controlador = storyboard?.instantiateViewController(withIdentifier: "gameScene") as! GameViewController
        controlador.nombreJugador = nombre.text
        controlador.modalTransitionStyle = .coverVertical
        controlador.modalPresentationStyle = .fullScreen
        self.present(controlador, animated: true)
    }
    
    
    //enviar el nombre a la 2 pantalla con un segue previamente creado desde el btn -> 2 pantalla
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinoVC = segue.destination as? GameViewController {
            destinoVC.nombreJugador = nombre.text
        }
    }
    
    //Enviar nombre validando que no este vacion
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goToGame" {
            if nombre.text!.trimmingCharacters(in: .whitespaces).isEmpty {
                return false //Si el texto del TF coincide con algun espacio en blanco o estan vacios devuelve falso y no deja avanzar a la 2 pantalla
            }
        }
        return true //Caso contrario, si hay algun caracter diferente a un espacio en blanco o vacio
    }

}

