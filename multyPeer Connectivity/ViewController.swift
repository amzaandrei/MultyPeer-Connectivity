//
//  ViewController.swift
//  multyPeer Connectivity
//
//  Created by Andrew on 8/20/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit

class ColorSwitchViewController: UIViewController {
    
    //    @IBOutlet weak var connectionsLabel: UILabel!
    
    
    let colorService = ColorServiceManager()
    
    
    let label: UILabel = {
        let labelText = UILabel()
        labelText.text = "Connections:"
        labelText.translatesAutoresizingMaskIntoConstraints = false
        return labelText
    }()
    let RedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Red", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(redTapped), for: .touchUpInside)
        return button
    }()
    let YellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yellow", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(yellowTapped), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorService.delegate = self
        
        view.backgroundColor = UIColor.white
        view.addSubview(label)
        view.addSubview(RedButton)
        view.addSubview(YellowButton)
        addConstraints()
        self.edgesForExtendedLayout = []
    }
    
    
    func addConstraints(){
        
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.widthAnchor.constraint(equalToConstant: 400).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        
        RedButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        RedButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        RedButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        RedButton.topAnchor.constraint(equalTo: label.topAnchor, constant: 30).isActive = true
        
        YellowButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        YellowButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        YellowButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        YellowButton.topAnchor.constraint(equalTo: RedButton.topAnchor, constant: 30).isActive = true
        
    }
    
    @objc func redTapped() {
        self.change(color: .red)
        colorService.send(colorName: "red")
    }
    
    @objc func yellowTapped() {
        self.change(color: .yellow)
        colorService.send(colorName: "yellow")
    }
    
    func change(color : UIColor) {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = color
        }
    }
    
}

extension ColorSwitchViewController : ColorServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ColorServiceManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.label.text = "Connections: \(connectedDevices)"
        }
    }
    
    func colorChanged(manager: ColorServiceManager, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "red":
                self.change(color: .red)
            case "yellow":
                self.change(color: .yellow)
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}


