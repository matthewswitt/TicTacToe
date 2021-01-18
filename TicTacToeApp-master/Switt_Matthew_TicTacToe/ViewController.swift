

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        //this code is executed as soon as the app is run
        super.viewDidLoad()
        //disables and hides all buttons except for the start button
        resetOutlet.isEnabled = false
        resetOutlet.isHidden = true
        xButton.isEnabled = false
        xButton.isHidden = true
        oButton.isEnabled = false
        oButton.isHidden = true
        //Press start to begin is put in the main label
        turnLabel.text = "Press START to begin"
    }

    //creates an outlet collection for all the button
    @IBOutlet var buttons: [UIButton]!
   //creates an outlet for all other buttons and labels
    @IBOutlet weak var startOutlet: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var resetOutlet: UIButton!
    @IBOutlet weak var playerOneOutlet: UILabel!
    @IBOutlet weak var playerTwoOutlet: UILabel!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var oButton: UIButton!
    @IBOutlet weak var orOutlet: UILabel!
    
    //a counter that will keep track of the number of turns
    var numberOfTurns = 0
    //sets player 1 and player 2 image to unknown
    var player1Image: UIImage? = nil
    var player2Image: UIImage? = nil
    //array with the winning combos
    var winningSequences: [[Int]] = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    //empty arrays that will hold values where player 1 and player 2's images occupy
    var player1Spots: [Int] = []
    var player2Spots: [Int] = []
    
    //what happens when the start button is pressed
    @IBAction func startButton(_ sender: UIButton) {
        
        //mainlabel text tells player one to choose a symbol
        turnLabel.text = "Choose your symbol Player One."
        //x button and o button is enabled and shown
        xButton.isEnabled = true
        xButton.isHidden = false
        oButton.isEnabled = true
        oButton.isHidden = false
        //start button is disable and hidden
        startOutlet.isEnabled = false
        startOutlet.isHidden = true
    }
    
    //what happens when the x button is clicked
    @IBAction func xClicked(_ sender: UIButton) {
        //x and o buttons r hidden and disabled
        xButton.isEnabled = false
        xButton.isHidden = true
        oButton.isEnabled = false
        oButton.isHidden = true
        //a for statement enabling all the buttons in the button collection
        for button1 in buttons {
            button1.isEnabled = true
        }
        //hides the or outlet
        orOutlet.isHidden = true
        //player one is assigned an X and player two is assigned an O
        playerOneOutlet.text = "X"
        playerTwoOutlet.text = "O"
        //main label displays this text
        turnLabel.text = "Player One's turn."
        //player 1's image is a X, player 2's is an O
        player1Image = UIImage(named: "picX")
        player2Image = UIImage(named: "picO")
    }
    //what happens when the o button is clicked
    @IBAction func oClicked(_ sender: UIButton) {
        //x and o buttons r hidden and disabled
        xButton.isEnabled = false
        xButton.isHidden = true
        oButton.isEnabled = false
        oButton.isHidden = true
        //a for statement enabling all the buttons in the button collection
        for button1 in buttons {
            button1.isEnabled = true
        }
        //hides the or outlet
        orOutlet.isHidden = true
        //player one is assigned an O and player two is assigned an X
        playerOneOutlet.text = "O"
        playerTwoOutlet.text = "X"
        //main label displays this text
        turnLabel.text = "Player One's turn."
        //player 1's image is an O, player 2's is an X
        player1Image = UIImage(named: "picO")
        player2Image = UIImage(named: "picX")
    }
    
    @IBAction func changePicture(_ sender: UIButton) {
        //increments variable by one every time a spot is pressed
        numberOfTurns += 1
        //if number of turns is odd, main label displays a string, button displays player one's image and animates it
        if numberOfTurns % 2 == 1 {
            turnLabel.text = "Player Two's turn."
            sender.setImage(player1Image, for: .normal)
            UIButton.transition(with: sender, duration: 1.0, options: .transitionFlipFromTop, animations: nil, completion: nil)
        //if number of turns is even, main label displays a string, button displays player two's image and animates it
            } else if numberOfTurns % 2 == 0 {
                turnLabel.text = "Player One's turn."
                sender.setImage(player2Image, for: .normal)
                UIButton.transition(with: sender, duration: 1.0, options: .transitionFlipFromBottom, animations: nil, completion: nil)
            }
        //a function which takes in two ints and depending on the player image, will insert those ints into the empty arrays for player one and two spots they occupy
        func currentSpot (player1Spot: Int, player2Spot: Int){
            switch sender.currentImage! {
            case player1Image:
                player1Spots.append(player1Spot)
            case player2Image:
                player2Spots.append(player2Spot)
            default:
                break
            }
        }
        //switch statement which for each button, depending on the player symbol that occupies it, will insert an int into the player's empty arrays, informing the computer of which spot each player occupies
        switch sender.currentTitle! {
        case "Spot 1":
            currentSpot(player1Spot: 0, player2Spot: 0)
        case "Spot 2":
            currentSpot(player1Spot: 1, player2Spot: 1)
        case "Spot 3":
            currentSpot(player1Spot: 2, player2Spot: 2)
        case "Spot 4":
            currentSpot(player1Spot: 3, player2Spot: 3)
        case "Spot 5":
            currentSpot(player1Spot: 4, player2Spot: 4)
        case "Spot 6":
            currentSpot(player1Spot: 5, player2Spot: 5)
        case "Spot 7":
            currentSpot(player1Spot: 6, player2Spot: 6)
        case "Spot 8":
            currentSpot(player1Spot: 7, player2Spot: 7)
        case "Spot 9":
            currentSpot(player1Spot: 8, player2Spot: 8)
        default: break
        }
        //function that checks if a player won taking in an array of ints and returning a bool and also seeing if a players array is a superset of a winning sequence
        func checkWin(_ playerSpots: [Int]) -> Bool {
            var win = false
            var playerSpotSet = Set(playerSpots)
            for sequence in winningSequences {
                var setSequence = Set(sequence)
                if playerSpotSet.isSuperset(of: setSequence){
                    win = true
                }
            }
            return win
        }
        //function that disables game
        func disableGame() {
            //each spot button is disabled
            for button2 in buttons{
                button2.isEnabled = false
            }
            //reset outlet is hidden and disabled
            resetOutlet.isEnabled = true
            resetOutlet.isHidden = false
        }
        
        //if the function check win is true for player one's array, an alert will pop up, the main label will display a string and the game disables
        if checkWin(player1Spots) {
                let alert = UIAlertController(title: "Game Over!", message: "Player One got three in a row. They win! Better luck next time Player Two.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                turnLabel.text = "Player One wins! Press RESET"
                disableGame()
            //if the function check win is true for player two's array, an alert will pop up, the main label will display a string and the game disables
            } else if checkWin(player2Spots) {
                let alert2 = UIAlertController(title: "Game Over!", message: "Player Two got three in a row. They win! Better luck next time Player One.", preferredStyle: .alert)
                alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert2, animated: true, completion: nil)
                turnLabel.text = "Player Two wins! Press RESET."
                disableGame()
            //if the function check win is false, an alert will pop up, the main label will display a string and the game disables
            } else if numberOfTurns == 9 {
                let alert3 = UIAlertController(title: "Game Over!", message: "No player won. It's a tie!", preferredStyle: .alert)
                alert3.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert3, animated: true, completion: nil)
                turnLabel.text = "Cat's game my nigga."
                disableGame()
            }
        //disables the button that was just clicked
        sender.isEnabled = false
        
    }
    //what happens when the reset button is clicked
    @IBAction func resetAction(_ sender: UIButton) {
        //each spot button is set back to its original property, no image
        for button3 in buttons{
            button3.setImage(nil, for: .normal)
        }
        //start button is enabled and shown, all other buttons and outlets are disabled and hidden
        startOutlet.isEnabled = true
        startOutlet.isHidden = false
        resetOutlet.isEnabled = false
        resetOutlet.isHidden = true
        xButton.isEnabled = false
        xButton.isHidden = true
        oButton.isEnabled = false
        oButton.isHidden = true
        orOutlet.isHidden = false
        //empties player one's array and player two's array
        player1Spots.removeAll()
        player2Spots.removeAll()
        //number of turns is reset back to 0
        numberOfTurns = 0
        //player one and two's symbols dissappear and the main label displays a string
        playerOneOutlet.text = nil
        playerTwoOutlet.text = nil
        turnLabel.text = ("Press START to begin!")
    }
}

