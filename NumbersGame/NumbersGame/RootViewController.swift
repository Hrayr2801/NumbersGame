//
//  ViewController.swift
//  NumbersGame
//
//  Created by Hrayr on 12/21/20.
//  Copyright © 2020 Hrayr. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, InputNumbersTableViewCellDelegate {
    
    var guessed:[Character] = []
    var attempts:[(String, String)] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notif:)), name:UIResponder.keyboardWillShowNotification, object: nil);

        restartGame()
    }
    
    //MARK: - InputNumbersTableViewCellDelegate
    
    func numbersEntered(cell: InputNumbersTableViewCell) {
        let numbers = cell.numbers.text ?? ""
        var inputOutput:(String, String)!
        cell.numbers.text = ""
        if numbers.count != 4 {
            inputOutput = (numbers, "Wrong input")
        } else {
            var x = 0
            var y = 0
            for i in 0..<4 {
                var j = 0
                var index = numbers.startIndex
                while j < 4 {
                    if guessed[i] == numbers[index] {
                        x += 1
                        if i == j {
                            y += 1
                        }
                    }
                    j += 1
                    index = numbers.index(after: index)
                }
            }
            inputOutput = (numbers, (x == 4 && y == 4 ? "You win!" : "\(x):\(y)"))
        }
        attempts.append(inputOutput)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: attempts.count - 1, section: 0)], with: .none)
        tableView.endUpdates()
        tableView.scrollToRow(at: IndexPath(row: attempts.count, section: 0), at: .bottom, animated: true)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attempts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < attempts.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: InputOutputTableViewCell.id) as! InputOutputTableViewCell
            let io = attempts[indexPath.row]
            cell.input.text = io.0
            cell.output.text = io.1
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: InputNumbersTableViewCell.id) as! InputNumbersTableViewCell
        cell.numbers.text = ""
        cell.delegate = self
        cell.numbers.delegate = cell
        cell.numbers.becomeFirstResponder()
        return cell
    }
    
    //MARK: - Private

    @objc func keyboardWillShow(notif: NSNotification) {
        let height = (notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        tableViewBottomConstraint.constant = height
    }
    
    @IBAction func rules() {
        let vc = RulesViewController.createVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func restartGame() {
        attempts = []
        guessed = []
        tableView.reloadData()

        for i in 0..<4 {
            var n:Character!
            while true {
                n = Character("\(Int.random(in: (i == 0 ? 1 : 0)...9))")
                if !guessed.contains(n) {
                    break
                }
            }
            guessed.append(n)
        }
    }
    
}

