//
//  ViewController.swift
//  Classic Trek
//
//  Created by Marisa Giancarla on 12/6/15.
//  Copyright © 2015 Pocketfiction. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var textView: UITextView!
    
    @IBAction func StatusButtonAction(sender: AnyObject) {
    }
    
    @IBAction func SRScanButtonAction(sender: AnyObject) {
        
        
    }
    
    @IBAction func ChartButtonAction(sender: AnyObject) {
//        let userinput = inputField.text
//        print(userinput)
//        updateTextView(userinput!)
//        inputField.text = ""
        
        
    }
    
    @IBAction func CommandsButtonAction(sender: AnyObject) {
        
        
        helpme()
        
    }
    
    @IBAction func HelpButtonAction(sender: AnyObject) {
        
        help()
    }
    
    @IBAction func ComputerButtonAction(sender: AnyObject) {
        
        movebaddy(300,300, 100, 100)
      
        
    }
    
    @IBAction func MoveButtonAction(sender: AnyObject) {
        
        movcom()
    }
    

    
    @IBOutlet var bottomHeight: NSLayoutConstraint!
    
    @IBOutlet var inputField: UITextField!
    var myArgs = CStringArray(["runIT", "", "", ""])

    var bgMusic:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.notifyFromC(_:)), name: "status", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view, typically from a nib.
        let bgMusicURL:NSURL = NSBundle.mainBundle().URLForResource("TrekSoundtrack", withExtension: "mp3")!
        do {
            bgMusic = try AVAudioPlayer(contentsOfURL: bgMusicURL, fileTypeHint: nil) } catch _ { return print("file not found") }
            bgMusic.numberOfLoops = 1
            bgMusic.prepareToPlay()
            bgMusic.play()
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {

            
//            let returnedString = mainer(self.myArgs.numberOfElements, &self.myArgs.pointers[0])
            
        })
        
    }
    
    func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(true, notification: notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(false, notification: notification)
    }
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        // 3
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        // 4
        let changeInHeight = (CGRectGetHeight(keyboardFrame)) * (show ? 1 : -1)
        //5
        UIView.animateWithDuration(animationDurarion, animations: { () -> Void in
            self.bottomHeight.constant += changeInHeight
        })
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    
    // Whatever passed in the updateTextView Function will be displayed in the textView
    func updateTextView(inputText: String) -> String {
        textView.text = textView.text + "\n" + inputText
        
        return inputText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func notifyFromC(notification:NSNotification) {
        let userInfo : [String:String!] = notification.userInfo as! [String:String!]
        let log = userInfo["value"]
        
        textView.text = textView.text + "\n" + log!
    }

    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        let str = textField.text!
        let length = str.characters.count
        var buffer: [Int8] = [Int8](count: length + 1, repeatedValue: 0)
        str.getCString(&buffer, maxLength: length + 1, encoding: NSUTF8StringEncoding)
        
        strcpy(&UserInput.0, buffer)
        
        scan()
        
        return true
    }
    
}

