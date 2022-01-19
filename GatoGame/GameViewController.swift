//
//  GameViewController.swift
//  GatoGame
//
//  Created by marco rodriguez on 19/01/22.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var nombreJugadorLbl: UILabel!
    @IBOutlet weak var marcadorJugadorLbl: UILabel!
    @IBOutlet weak var marcadorPcLbl: UILabel!
    
    
    @IBOutlet weak var caja1: UIImageView!
    @IBOutlet weak var caja2: UIImageView!
    @IBOutlet weak var caja3: UIImageView!
    @IBOutlet weak var caja4: UIImageView!
    @IBOutlet weak var caja5: UIImageView!
    @IBOutlet weak var caja6: UIImageView!
    @IBOutlet weak var caja7: UIImageView!
    @IBOutlet weak var caja8: UIImageView!
    @IBOutlet weak var caja9: UIImageView!
    
    var nombreJugador: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nombreJugadorLbl.text = nombreJugador ?? "Jugador 1" + ": "
        
        //Agregar la gestura a cada imagen
        crearToque(on: caja1, type: .uno)
        crearToque(on: caja2, type: .dos)
        crearToque(on: caja3, type: .tres)
        crearToque(on: caja4, type: .cuatro)
        crearToque(on: caja5, type: .cinco)
        crearToque(on: caja6, type: .seis)
        crearToque(on: caja7, type: .siete)
        crearToque(on: caja8, type: .ocho)
        crearToque(on: caja9, type: .nueve)
    }
    
    func crearToque(on imageView: UIImageView, type caja: Caja){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.cajaClick(_:)))
        tap.name = caja.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func cajaClick(_ sender: UITapGestureRecognizer){
        print("Caja: \(sender.name) fue seleccionada")
    }
    
    @IBAction func regresarBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    enum Caja: String {
        case uno, dos, tres, cuatro, cinco, seis, siete, ocho, nueve
    }

}
