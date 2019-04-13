//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 干川雄大 on 2019/04/06.
//  Copyright © 2019 roy1715. All rights reserved.
//

import UIKit
import Expression

class ViewController: UIViewController {
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // ビューがロードされた時点で式と答えのラベルは空にする
        formulaLabel.text=""
        answerLabel.text=""
        
    }

    @IBAction func clearCalculation(_ sender: UIButton) {
        formulaLabel.text=""
        answerLabel.text=""
    }
    
    @IBAction func calculateAnswer(_ sender: UIButton) {
        //=ボタンが押されたら、答えを計算して表示する
        guard let formulaText = formulaLabel.text else {
            return
        }
        
        let formula:String=formatformula(formulaText)
        answerLabel.text=evalFormula(formula)
        
    }

    @IBAction func inputFormula(_ sender: UIButton) {
        guard let formulaText=formulaLabel.text else{
            return
        }
        
        guard let senderText=sender.titleLabel?.text else{
            return
        }
        formulaLabel.text=formulaText+senderText
        
    }
    
    private func formatformula (_ formula:String)->String{
//       入力された整数には".0"を追加して少数として評価
//       ”÷"を"/"に"×"を"*"に変換する
        let formattedFormula:String = formula.replacingOccurrences(
            of:"(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
            with: "$1.0",
            options: NSString.CompareOptions.regularExpression,
            range: nil).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        
        return formattedFormula
    }
    
    private func evalFormula (_ formula:String)->String{
        do{
        let expression = Expression(formula)
        let answer = try expression.evaluate()
        return formatAnswer(String(answer))
        }catch{
            return "式を正しく入力してください"
        }
        
    }
    
    private func formatAnswer (_ answer:String)->String{
        //答えの小数点以下が0だった場合は整数に変換する
        let formattedAnswer:String = answer.replacingOccurrences(
            of:"\\.0$",
            with:"",
            options:NSString.CompareOptions.regularExpression,
            range:nil)
        
        return formattedAnswer
        
    }
}

