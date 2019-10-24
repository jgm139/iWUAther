//
//  ViewController.swift
//  iWUAther
//
//  Created by Máster Móviles on 24/10/2019.
//  Copyright © 2019 Máster Móviles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Constants
    let OW_URL_BASE = "https://api.openweathermap.org/data/2.5/weather?lang=es&units=metric&appid=1adb13e22f23c3de1ca37f3be90763a9&q="
    let OW_URL_BASE_ICON = "https://openweathermap.org/img/w/"
    
    //MARK: Properties
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherCity: UITextField!
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func consultarTiempo(localidad:String) {
        let urlString = OW_URL_BASE+localidad
        let url = URL(string:urlString)
        let dataTask = URLSession.shared.dataTask(with: url!) {
            datos, respuesta, error in
               let jsonStd = try! JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
               let weather = jsonStd["weather"]! as! [AnyObject]
               let currentWeather = weather[0] as! [String:AnyObject]
               let descripcion = currentWeather["description"]! as! String
               print("El tiempo en \(localidad) es: \(descripcion)")
               //Estamos bajándonos la imagen pero todavía no la usamos
               let icono = currentWeather["icon"]! as! String
               if let urlIcono = URL(string: self.OW_URL_BASE_ICON+icono+".png" ) {
                  let datosIcono = try! Data(contentsOf: urlIcono)
                  let imagenIcono = UIImage(data: datosIcono)
                    OperationQueue.main.addOperation() {
                        self.weatherImage.image = imagenIcono
                        self.weatherLabel.text = descripcion
                    }
               }
        }
        dataTask.resume()
    }

    @IBAction func consultWeather(_ sender: Any) {
        if weatherCity.text != nil {
            consultarTiempo(localidad: weatherCity.text!)
        }
    }
    
}

