# Clean-Architecture-MVP

Sample MVP

```
protocol NetworkDelegate {
    func callAPI() -> String
}

class Network: NetworkDelegate {
    
    func callAPI() -> String {
        return "Hello, World !!"
    }
}

class Interactor {
    
    var delegate: NetworkDelegate?
    
    func getMessage() -> String {
        
        return delegate?.callAPI() ?? ""
    }
}

protocol PresenterDelegate {
    func get(message: String)
}

class Presenter {
    
    var delegate: PresenterDelegate?
    
    func presentMessage() -> String {
        
        let interactor = Interactor()
        interactor.delegate = Network()
        
        delegate?.get(message: interactor.getMessage())
        
        return interactor.getMessage()
    }
}

// MARK: Regular
let presenter = Presenter()
let message = presenter.presentMessage()
print("Your Messgae is \(message)")

// MARK: Delegate
class ViewController: UIViewController, PresenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preseter = Presenter()
        preseter.delegate = self
    }
    
    func get(message: String) {
        print("Your message is \(message)")
    }
}
```
