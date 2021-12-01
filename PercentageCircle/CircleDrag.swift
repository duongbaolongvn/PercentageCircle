



import UIKit

class CircleDrag: UIView {
    
    var buttonView = UIView()
    var didLoad = false
    let circle = CAShapeLayer()
    let bgCircle = CAShapeLayer()
    let percentageCircle = CAShapeLayer()
    var percentage: Double = 0
    var percentageSlider: Double = 0
    var text = CATextLayer()
    
    let button = CAShapeLayer()
    var round = CAShapeLayer()
    var buttonPath = UIBezierPath()
    var roundPath = UIBezierPath()
    var midViewX = CGFloat()
    var midViewY = CGFloat()
    
    override func draw(_ rect: CGRect) {
        if didLoad { return}
        didLoad = true
    
        drawRoundSlider(0)
        drawCircle(percentage)
        
        self.layer.addSublayer(bgCircle)
        self.layer.addSublayer(circle)
        self.layer.addSublayer(percentageCircle)
        self.layer.addSublayer(text)
        
        
        let frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        buttonView.frame = frame
        self.addSubview(buttonView)
        buttonView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panSliser(_:))))
        buttonView.isUserInteractionEnabled = true
    }
    

    func drawCircle(_ percentage: Double) {
        
        let bgCirclePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 400, height: 400))
        bgCircle.path = bgCirclePath.cgPath
        bgCircle.fillColor = UIColor(red: 225/255, green: 233/255, blue: 253/255, alpha: 1).cgColor

        
        let value = CGFloat(3*Int(percentage*100)) + 100
        let circlePath = UIBezierPath(ovalIn: CGRect(x: bounds.width/2 - value/2,y: bounds.height/2 - value/2, width: value,height: value))
        circle.path = circlePath.cgPath
        circle.fillColor = UIColor(red: 80/255, green: 130/255, blue: 247/255, alpha: 1).cgColor
        
        let pCirclePath = UIBezierPath(ovalIn: CGRect(x: bounds.width/2 - 50 ,y: bounds.height/2 - 50, width: 100, height: 100))
        percentageCircle.path = pCirclePath.cgPath
        percentageCircle.fillColor = UIColor.white.cgColor
        
        text.string = "\(Int(percentage*100))%"
        text.foregroundColor = UIColor(red: 80/255, green: 130/255, blue: 244/255, alpha: 1).cgColor
        text.font = UIFont.systemFont(ofSize: 0, weight: .bold)
        let textFrame = CGRect(x: bounds.width/2 - 41, y: bounds.height/2 - 25, width: 150, height: 60)
        text.frame = textFrame

    }
    func drawRoundSlider(_ percentage: Double) {
        midViewX = self.bounds.width/2
        midViewY = self.bounds.height/2

        roundPath = UIBezierPath(arcCenter: CGPoint(x: midViewX, y: midViewY), radius: 205, startAngle: -.pi/2, endAngle: .pi*2*CGFloat(percentage) - .pi/2 , clockwise: true)
        round.path = roundPath.cgPath
        round.lineWidth = 10
        round.strokeColor = UIColor(red: 90/255, green: 132/255, blue: 255/255, alpha: 1).cgColor
        round.fillColor = UIColor.clear.cgColor
        round.lineCap = .round
        
        buttonPath = UIBezierPath(arcCenter: CGPoint(x: midViewX + 2.5, y: 0), radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)
        button.path = buttonPath.cgPath
        button.strokeColor = UIColor.blue.cgColor
        button.lineWidth = 5
        button.fillColor = UIColor.white.cgColor
        
        buttonView.layer.addSublayer(round)
        buttonView.layer.addSublayer(button)
    }
    @objc func panSliser(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else {return}
        let point = sender.location(in: view)
        let buttonX = Double(point.x)
        let buttonY = Double(point.y)
        let midViewXDouble = Double(midViewX)
        let midViewYDouble = Double(midViewY)
        let angleX = buttonX - midViewXDouble
        let angleY = buttonY - midViewYDouble
        let angle = atan2(angleX,angleY)
        let buttonX2 = midViewXDouble + sin(angle)*200
        let buttonY2 = midViewYDouble + cos(angle)*200
        
        let newPercentage = (Double.pi - angle)/(Double.pi*2)

        if abs(newPercentage - percentage) > 0.5 {
            percentage = percentage < 0.5 ? 0 : 1
        } else {
            percentage = newPercentage
        }
        drawCircle(percentage)
        if percentage == 0 {
            drawRoundSlider(0)
        } else if percentage == 1 {
            drawRoundSlider(1)
        } else {
            drawRoundSlider(percentage)
            
            buttonPath = UIBezierPath(arcCenter: CGPoint(x: buttonX2, y: buttonY2), radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)
            button.path = buttonPath.cgPath
        }

    }
    
}
