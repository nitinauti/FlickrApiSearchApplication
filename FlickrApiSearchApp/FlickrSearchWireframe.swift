//
//  FlickrSearchWireframe.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 10/12/21.
//

import Foundation
import UIKit

class FlickrSearchWireframe: FlickrSearchWireFrameProtocol {
    
    static func presentFlickrSearchModule(fromView: AnyObject) {
        let view : FlickrSearchViewProtocol = FlickrSearchViewController.instantiate()
        let presenter: FlickrSearchPresenterProtocol  = FlickrSearchPresenter()
        let interactor: FlickrSearchInteractorProtocol = FlickrSearchInteractor()
        let APIManager: FlickrSearchAPIManagerProtocol = FlickrSearchApiManager()
        let wireFrame: FlickrSearchWireFrameProtocol = FlickrSearchWireframe()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.APIManager = APIManager
        
        guard let viewController = view as? FlickrSearchViewController else { return }
        NavaigationHelper.setRootViewController(ViewController:viewController)

      }
    
}
