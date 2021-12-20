//
//  FlickrSearchViewController.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 10/12/21.
//

import UIKit

class FlickrSearchViewController: UIViewController, FlickrSearchViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var flickrSearchModel: FlickrSearchModel?
    var presenter: FlickrSearchPresenterProtocol?
    var searchText = ""
    let itemSize: CGFloat = (Constants.screenWidth - (Constants.numberOfColumns - Constants.defaultSpacing) - 3) / Constants.numberOfColumns
    
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.delegate = self
        controller.searchBar.placeholder = Constants.placeholder
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        setUpSearchController()
        configureCollectionView()
    }
    
    func resetViews() {
        flickrSearchModel = nil
//        searchController.searchBar.text = nil
        collectionView.reloadData()
    }
    
    func setUpSearchController() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureCollectionView() {
        collectionView.register(UINib(nibName: Constants.FlickrImageCell, bundle: nil), forCellWithReuseIdentifier:Constants.FlickrImageCellIdentifire)
    }
    
    /// Recvied image array From API and passed in model class and reload Collectionview
    func displayFlickrSearchImages(with viewModel: FlickrSearchModel) {
        flickrSearchModel = viewModel
        collectionView.reloadData()
        self.view.hideSpinner()

    }
   
    func flickrSearchError(_ error: NetworkError) {
        self.view.hideSpinner()
    }
    
    static func instantiate() -> FlickrSearchViewProtocol {
        return UIStoryboard(name: Constants.FlickrSearchViewController, bundle: nil).instantiateViewController(withIdentifier: Constants.FlickrSearchViewIdentifire) as! FlickrSearchViewController
    }
}

extension FlickrSearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else {
            return
        }
        searchController.isActive = false
        searchBar.text = searchText
        searchBar.resignFirstResponder()
        guard !searchText.isEmpty || searchText != self.searchText else { return }
        presenter?.clearData()
        self.searchText = searchText
        self.view.showSpinner()
        presenter?.getSearchedFlickrPhotos(SearchImageName: self.searchText)
    }
}

//MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension FlickrSearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.flickrSearchModel, !viewModel.isEmpty else {
            return 0
        }
        return viewModel.photoCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = FlickrImageCell()
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.FlickrImageCellIdentifire, for: indexPath) as! FlickrImageCell
        
        guard let viewModel = flickrSearchModel else {
            return cell
        }
        let imageURL = viewModel.imageUrlAt(indexPath.row)
        cell.tag = indexPath.row
        cell.configure(imageURL: imageURL, size: CGSize(width: itemSize, height: itemSize),indexPath:indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.defaultSpacing, left: Constants.defaultSpacing, bottom: Constants.defaultSpacing, right: Constants.defaultSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.defaultSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.defaultSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = flickrSearchModel else { return }
        guard  indexPath.row == (viewModel.photoCount - 1) else {
            return
        }
        self.view.showSpinner()
        presenter?.getSearchedFlickrPhotos(SearchImageName: searchText)
    }
    
}
