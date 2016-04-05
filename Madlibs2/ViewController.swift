//
//  ViewController.swift
//  Madlibs2
//
//  Created by Swift on 3/15/16.
//  Copyright © 2016 Swift. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var insertButtonOutlet: UIButton!
    
    var filledWords = [String]()
    var placeholderWords = [String]()
    var wordArrayIndex = 0
    var placeholderArrayIndex = 0
    var placeholderCount = 0
    
    // reads text from bundle and places it in a string
    func readText(fileName : String, fileExtension : String) -> String?{
        var text: String?
        if let path : String = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension)! {
            do {
                text = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            } catch {
                print("Something went wrong!")
            }
        }
        return text
    }
    
    
    
    // Splits a string into an array of words
    func splitText(inputText : String) -> [String]{
        let inputTextArray = inputText.characters.split{$0 == " " || $0 == "\r\n"}.map(String.init)
        return inputTextArray
    }
    
    
    
    // Checks for placeholder and adds it to an array
    func addPlaceholderToArray(inputArray : [String]){
        for words in inputArray{
        if words.rangeOfString("<") != nil{
            // solution found on http://stackoverflow.com/questions/28445917/what-is-the-most-succinct-way-to-remove-the-first-character-from-a-string-in-swi
            var sliced = String(words.characters.dropFirst())
            sliced = String(sliced.characters.dropLast())
            placeholderWords.append(sliced)
            placeholderCount += 1
            print(placeholderCount)
            }
        }
    }

    // Function create the story, checking 1 array for placeholders and filling in the other
    func createStory(rawText: [String], filledWords: [String]) -> String{
        var rawTextCounter = 0
        var filledWordsCounter = 0
        var completedTextArray = rawText
        // Looping through whole array
        for _ in rawText{
            // Check if its a placeholder
                if rawText[rawTextCounter].containsString("<"){
                    // Replace it with corresponding word
                    completedTextArray[rawTextCounter] = filledWords[filledWordsCounter]
                    // Increment
                    rawTextCounter = rawTextCounter + 1
                    filledWordsCounter = filledWordsCounter + 1
                }
                else {
                    // Keep the text
                    completedTextArray[rawTextCounter] = rawText[rawTextCounter]
                    rawTextCounter = rawTextCounter + 1
                }
            }
        return completedTextArray.joinWithSeparator(" ")
    }

    @IBAction func addWordToArray(sender: AnyObject) {

            filledWords.append(textField.text!)
            wordArrayIndex += 1
            print(filledWords)
        if (wordArrayIndex == placeholderCount){
            performSegueWithIdentifier("midToLastSegue", sender: nil)
            
        }
            return
    }
    
    // Function to update the instruction label with the appropriate information
    @IBAction func updateInstructionLabel(sender: AnyObject) {
        if (wordArrayIndex < placeholderCount){
            textLabel.text =  "Please fill in a/an " + placeholderWords[placeholderArrayIndex]
            placeholderArrayIndex += 1
        }
        return
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // prepare text to be passed
        let text = readText("madlib0_simple", fileExtension: ".txt")
        let splittedText = splitText(text!)
        
        // start passing
        if segue.identifier == "midToLastSegue"
        {
            if let destinationVC = segue.destinationViewController as? lastViewController
            {
                destinationVC.receiver1 = createStory(splittedText, filledWords: filledWords)
                print(createStory(splittedText, filledWords: filledWords))

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Read in the text when the view loads, add the keywords to the array and update the instructionlabel
        let text = readText("madlib0_simple", fileExtension: ".txt")
        let splittedText = splitText(text!)
        addPlaceholderToArray(splittedText)
        
        // Now i update the label manually, because it is an exception (it is on startup before the button is clicked)
        textLabel.text = "Please fill in a/an " +  placeholderWords[placeholderArrayIndex]
        placeholderArrayIndex += 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

