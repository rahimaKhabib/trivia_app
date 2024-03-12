//
//  File.swift
//  Trivia
//
//  Created by rakhima khabibullaeva on 3/9/24.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionCounter: UITextView!
    @IBOutlet var questionTopic: UITextView!
    @IBOutlet var displayQuestion: UITextView!
    @IBOutlet weak var choiceOneButton: UIButton!
    @IBOutlet weak var choiceTwoButton: UIButton!
    @IBOutlet weak var choiceThreeButton: UIButton!
    @IBOutlet weak var choiceFourButton: UIButton!
    
    private var questions: [Question] = []
    private var currentQuestionIndex: Int = 0
    private var correctAnswersCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestions()
        updateUIWithCurrentQuestion()
    }
    
    
    
    
    private func loadQuestions() {
            questions.append(Question(type: .HISTORY, question: "Who was the first President of the United States?", answers: ["George Washington", "Abraham Lincoln", "John Adams", "Thomas Jefferson"], correctAnswer: "George Washington"))
            questions.append(Question(type: .MUSIC, question: "Who is known as the 'King of Pop'?", answers: ["Michael Jackson", "Elvis Presley", "Prince", "Justin Bieber"], correctAnswer: "Michael Jackson"))
            questions.append(Question(type: .VIDEO_GAME, question: "What is the best-selling video game of all time?", answers: ["Minecraft", "Tetris", "Grand Theft Auto V", "Wii Sports"], correctAnswer: "Minecraft"))
            questions.append(Question(type: .TECH, question: "JavaScript is --- typed?", answers: ["Loosely", "Strictly", "Nicely", "Badly"], correctAnswer: "Loosely"))
        }
    
    
    
    
    
    
    private func updateUIWithCurrentQuestion() {
           if currentQuestionIndex < questions.count {
               let currentQuestion = questions[currentQuestionIndex]
               displayQuestion.text = currentQuestion.question
               questionTopic.text = currentQuestion.type.rawValue
               questionCounter.text = "Question \(currentQuestionIndex + 1)/\(questions.count)"
               
               let buttons = [choiceOneButton, choiceTwoButton, choiceThreeButton, choiceFourButton]
               for (index, button) in buttons.enumerated() {
                   guard index < currentQuestion.answers.count else { continue }
                   button?.setTitle(currentQuestion.answers[index], for: .normal)
               }
           } else {
               displayFinalScore()
           }
       }
    
    
    
    
    
    
    
    
    private func displayFinalScore() {
           let alert = UIAlertController(title: "Quiz Complete", message: "You got \(correctAnswersCount) out of \(questions.count) correct!", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
               // Reset the quiz for a new attempt
               self.correctAnswersCount = 0
               self.currentQuestionIndex = 0
               self.updateUIWithCurrentQuestion()
           }))
           present(alert, animated: true)
       }
    
    
    
    
    
    @IBAction func choiceButtonTapped(_ sender: UIButton) {
           if let answer = sender.currentTitle,
              let currentQuestion = questions[safe: currentQuestionIndex],
              answer == currentQuestion.correctAnswer {
               correctAnswersCount += 1
           }

           currentQuestionIndex += 1
           if currentQuestionIndex < questions.count {
               updateUIWithCurrentQuestion()
           } else {
               displayFinalScore()
           }
       }
       
    
    
    
}
enum QuestionType: String {
    case HISTORY = "History"
    case MUSIC = "Music"
    case VIDEO_GAME = "Video Game"
    case TECH = "Tech"
}

struct Question {
    var type: QuestionType
    var question: String
    var answers: [String]
    var correctAnswer: String
}

// Safe array access extension
extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
