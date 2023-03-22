import UIKit

final class RMCharacterListViewViewModel: NSObject {
    
    func fectchChraracters() {
        RMService.share.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Example image url: "+String(model.results.first?.image ?? "No image"))
                print("Page result count: "+String(model.results.count))
            case .failure(let error):
                String(describing: error)
                print(String(describing: error))
            }
        }
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIndentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        let viewModel = RMCharacterCollectionViewCellViewModel(characterName: "Oleh",
                                                               characterStatus: .alive,
                                                               characterImageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        let heigth = width * 1.5
        return CGSize(width: width, height: heigth)
    }
}
