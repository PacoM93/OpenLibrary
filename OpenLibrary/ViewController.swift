//
//  ViewController.swift
//  OpenLibrary
//
//  Created by Francisco Montes Fonseca on 12/01/18.
//  Copyright © 2018 COURSERA. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    

    @IBOutlet weak var Valor: UITextField!
    @IBOutlet weak var Mensaje: UITextView!
    @IBAction func Limpiar(_ sender: Any) {
        Mensaje.text = ""
        Valor.text = ""
    }

    @IBAction func BuscarISBN(_ sender: UITextField) {
        obtenerUrl()
    }
    
    @IBAction func backgroundTap(_ sender: UIControl) {
        Valor.resignFirstResponder()
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    func obtenerUrl(){
        let urlsIncompleto = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let urlsCompleto = urlsIncompleto + Valor.text!
        //let urlsCompleto = urlsIncompleto + "978-84-376-0494-7"
        print(urlsCompleto)
        var request = URL(string: urlsCompleto)
        let session = URLSession.shared
        let runLoop = CFRunLoopGetCurrent()
        var texto : NSString?
        if request == nil{
            request = URL(string: urlsIncompleto)
        }
        let task = session.dataTask(with: request!) { (data, response, error) in
            texto = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            CFRunLoopStop(runLoop)
        }
        task.resume()
        CFRunLoopRun()
        let respuesta = texto! as String
        if respuesta == "{}" {
            self.Mensaje.text = "ERROR\n\n\nPorfavor verifíca que el ISBN sea correcto."
        }else{
            self.Mensaje.text = respuesta
        }
        
        print("done")
        Valor.resignFirstResponder()
    
    }

    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

