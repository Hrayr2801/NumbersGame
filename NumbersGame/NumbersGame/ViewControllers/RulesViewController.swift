//
//  RulesViewController.swift
//  NumbersGame
//
//  Created by Hrayr on 1/22/21.
//  Copyright © 2021 Hrayr. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {
    
    @IBOutlet weak var text: UILabel!
    
    static func createVC() -> RulesViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(identifier: "RulesViewControllerID")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        text.text =
"""
The computer thinks a four-digit number(no digits are repeating, let call that number a), you must guess it. You will just write your suggestion(let call it b), and computer will return two numbers - count of digits, that is contained by both a and b, and count of digits, that is in a at same position, as in b.
For example - computer guess 6854, you write 1524, computer will return 2:1, because both a and b contain two numbers(5 and 4), and one number(4), that is in the same position in a, as in the b. You must write numbers, until you guess the number, guessed by computer. Try to do this with as few attempts, as possible. Good luck!
"""
    }

}
