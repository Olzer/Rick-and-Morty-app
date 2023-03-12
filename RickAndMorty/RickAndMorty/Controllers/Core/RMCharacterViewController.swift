import UIKit

///Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Character"
        
        let request = RMRequest(endpoint: .character,
                                queryParameters: [
                                URLQueryItem(name: "name", value: "rick"),
                                URLQueryItem(name: "status", value: "alive")
                                ]
        )
        print(request.url)
        
        RMService.share.execute(request, expecting: RMCharacter.self) { result in
            
        }
    }
}
