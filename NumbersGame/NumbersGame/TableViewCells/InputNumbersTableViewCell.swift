//
//  InputNumbersTableViewCell.swift
//  NumbersGame
//
//  Created by Hrayr on 12/22/20.
//  Copyright © 2020 Hrayr. All rights reserved.
//

import UIKit

protocol InputNumbersTableViewCellDelegate {
    func numbersEntered(cell: InputNumbersTableViewCell)
}

class InputNumbersTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var delegate: InputNumbersTableViewCellDelegate?
    static let id = "InputNumbersTableViewCellID"
    @IBOutlet weak var numbers: UITextField!
    
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let delegate = self.delegate {
            delegate.numbersEntered(cell: self)
        }
        return true
    }
}
