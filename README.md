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


```
import UIKit

class ViewControllerPresenter {
    
    var delegate: ViewControllerProtocol?
    
    init(delegate: ViewController) {
        self.delegate = delegate
    }
    
    func getData() {
        delegate?.update(ControllerData.mock)
    }
}

protocol ViewControllerProtocol {
    func update(_ sections: [Sections])
}

enum Sections {
    case numbers(_ model: [String])
    case places(_ model: [String])
    case animals(_ model: [String])
    case names(_ model: [String])
}

class ViewController: UIViewController {

    @IBOutlet weak var sampleTableView: UITableView!
    var sections = [Sections]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = ViewControllerPresenter(delegate: self)
        presenter.getData()
    }
}

extension ViewController: ViewControllerProtocol {
    func update(_ sections: [Sections]) {
        self.sections = sections
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        switch section {
        case .animals(_):
            return "Animals"
        case .numbers(_):
            return "Numbers"
        case .places(_):
            return "Places"
        case .names(_):
            return "Names"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .animals(let animals):
            return animals.count
        case .numbers(let numbers):
            return numbers.count
        case .places(let places):
            return places.count
        case .names(let names):
            return names.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let section = sections[indexPath.section]
        
        switch section {
        case .animals(let animals):
            cell.textLabel?.text = animals[indexPath.row]
            return cell
        case .numbers(let numbers):
            cell.textLabel?.text = numbers[indexPath.row]
            return cell
        case .places(let places):
            cell.textLabel?.text = places[indexPath.row]
            return cell
        case .names(let names):
            cell.textLabel?.text = names[indexPath.row]
            return cell
        }
    }
}

struct ControllerData {
    static var mock: [Sections] = {
        var sections = [Sections]()
        sections.append(.animals(["Cat", "Dog", "Chicken"]))
        sections.append(.places(["Hyderabad", "Delhi", "Chennai"]))
        sections.append(.numbers(["One", "Two", "Three"]))
        sections.append(.names(["Nithin", "Mihii", "Sirii"]))
        return sections
    }()
}

```
