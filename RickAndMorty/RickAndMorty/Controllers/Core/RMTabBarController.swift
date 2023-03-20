import UIKit

///Controller to house tabs and root tabs controllers
final class RMTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let characterVC = RMCharacterViewController()
        let locationVC = RMLocationViewController()
        let episodeVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()
        
        let nav1 = UINavigationController(rootViewController: characterVC)
        let nav2 = UINavigationController(rootViewController: locationVC)
        let nav3 = UINavigationController(rootViewController: episodeVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        
        setUpNavigationItems(characterVC, locationVC, episodeVC, settingsVC)
        setUpTabBarItems(nav1, nav2, nav3, nav4)
        setUpNavigationTitles(nav1, nav2, nav3, nav4)
        
        setViewControllers(
            [nav1, nav2, nav3, nav4],
            animated: true
        )
    }
    
    private func setUpTabBarItems(_ nav1: UINavigationController, _ nav2: UINavigationController, _ nav3: UINavigationController, _ nav4: UINavigationController) {
        nav1.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "globe"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episode", image: UIImage(systemName: "tv"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
    }
    
    private func setUpNavigationItems(_ characterVC: RMCharacterViewController, _ locationVC: RMLocationViewController, _ episodeVC: RMEpisodeViewController, _ settingsVC: RMSettingsViewController) {
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func setUpNavigationTitles(_ nav1: UINavigationController, _ nav2: UINavigationController, _ nav3: UINavigationController, _ nav4: UINavigationController) {
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
    }
}
