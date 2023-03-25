import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoaadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
}

///View model to hande character list logic
final class RMCharacterListViewViewModel: NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageURL: URL(string: character.image)
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    ///Fetch initial set of characters (20)
    public func fectchChraracters() {
        RMService.share.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let result = responseModel.results
                let info = responseModel.info
                self?.characters = result
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoaadInitialCharacters()
                }
            case .failure(let error):
                String(describing: error)
                print(String(describing: error))
            }
        }
    }
    
    ///Paginate if additional characters are needed
    public func fetchAdditionalCharacters() {
        //Fetch characters
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

//MARK: - CollectionView

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIndentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        let heigth = width * 1.5
        return CGSize(width: width, height: heigth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

//MARK: - ScrollView

extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator else {
            return
        }
    }
}
