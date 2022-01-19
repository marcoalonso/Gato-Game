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
    
    var nombreJugador: String!
    var ultimoValor = "o"
    
    var eleccionesJugador: [Caja] = []
    var eleccionesPC: [Caja] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nombreJugadorLbl.text = nombreJugador + " : "
        
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
        print("Caja: \(sender.name!) fue seleccionada")
        let cajaSeleccionada = getCaja(from: sender.name ?? "")
        escoger(cajaSeleccionada)
        eleccionesJugador.append(Caja(rawValue: sender.name!)!)
        chekSiGane()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.juegoPC()
        }
    }
    
    func juegoPC(){
        var espaciosLibres = [UIImageView]()
        var cajasDisponibles = [Caja]()
        for nombre in Caja.allCases {
            let caja = getCaja(from: nombre.rawValue)
            if caja.image == nil {
                espaciosLibres.append(caja)
                cajasDisponibles.append(nombre)
            }
        }
        
        guard cajasDisponibles.count > 0 else { return }
        
        let indiceRandom = Int.random(in: 0 ..< espaciosLibres.count)
        escoger(espaciosLibres[indiceRandom])
        eleccionesPC.append(cajasDisponibles[indiceRandom])
        chekSiGane()
    }
    
    func escoger(_ cajaSeleccionada: UIImageView){
        guard cajaSeleccionada.image == nil else { return }
        
        if ultimoValor == "x" {
            cajaSeleccionada.image = #imageLiteral(resourceName: "oh")
            ultimoValor = "o"
        } else {
            cajaSeleccionada.image = #imageLiteral(resourceName: "ex")
            ultimoValor = "x"
        }
        
        
    }
    
    func chekSiGane(){
        var correcto = [[Caja]]()
        let primerRow:[Caja] = [.uno, .dos, .tres]
        let segundoRow:[Caja] = [.cuatro, .cinco, .seis]
        let tercerRow:[Caja] = [.siete, .ocho, .nueve]
        
        let primerCol:[Caja] = [.uno, .cuatro, .siete]
        let segundoCol:[Caja] = [.dos, .cinco, .ocho]
        let tercerCol:[Caja] = [.tres, .seis, .nueve]
        
        let diagonal1:[Caja] = [.uno, .cinco, .nueve]
        let diagonal2:[Caja] = [.tres, .cinco, .siete]
        
        correcto.append(primerRow)
        correcto.append(segundoRow)
        correcto.append(tercerRow)
        correcto.append(primerCol)
        correcto.append(segundoCol)
        correcto.append(tercerCol)
        correcto.append(diagonal1)
        correcto.append(diagonal2)
        
        for validar in correcto {
            let coincidenciaUsuario = eleccionesJugador.filter { validar.contains($0)}.count
            let coincidenciaPC = eleccionesPC.filter { validar.contains($0)}.count
            
            if coincidenciaUsuario == validar.count { //Gano el usuario
                marcadorJugadorLbl.text = String((Int(marcadorJugadorLbl.text ?? "0") ?? 0) + 1)
                resetJuego()
                let alerta = UIAlertController(title: "Felicidades", message: "Ganaste!", preferredStyle: .alert)
                
                let accionOk = UIAlertAction(title: "OK", style: .default)
                
                alerta.addAction(accionOk)
                
                present(alerta, animated: true)

                break
                
            } else if coincidenciaPC == validar.count {
                marcadorPcLbl.text = String((Int(marcadorPcLbl.text ?? "0") ?? 0) + 1)
                resetJuego()
                let alerta = UIAlertController(title: "UPS U_u", message: "PERDISTE", preferredStyle: .alert)
                
                let accionOk = UIAlertAction(title: "OK", style: .default)
                
                alerta.addAction(accionOk)
                
                present(alerta, animated: true)
                break
                
            } else if eleccionesPC.count + eleccionesJugador.count == 9 {
                resetJuego()
                let alerta = UIAlertController(title: "EMPATE", message: "practica mas!", preferredStyle: .alert)
                
                let accionOk = UIAlertAction(title: "OK", style: .default)
                
                alerta.addAction(accionOk)
                
                present(alerta, animated: true)
                break
            }
        }
        
    }
    
    
    
    func resetJuego(){
        for nombre in Caja.allCases {
            let caja = getCaja(from: nombre.rawValue)
            caja.image = nil
        }
        //Reset las variables
        ultimoValor = "o"
        eleccionesPC = []
        eleccionesJugador = []
    }
    
    
    func getCaja(from name: String) -> UIImageView {
        let caja = Caja(rawValue: name) ?? .uno
        
        switch caja {
        case .uno:
            return caja1
        case .dos:
            return caja2
        case .tres:
            return caja3
        case .cuatro:
            return caja4
        case .cinco:
            return caja5
        case .seis:
            return caja6
        case .siete:
            return caja7
        case .ocho:
            return caja8
        case .nueve:
            return caja9
        
        }
        
    }
    
    
    @IBAction func regresarBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    enum Caja: String, CaseIterable {
        case uno, dos, tres, cuatro, cinco, seis, siete, ocho, nueve
    }

}
