//
//  GlobalPositionViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 21/8/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit

enum viewState {
    case InitialView
    case ResultView
    case ErrorView
    init() {
        self = .InitialView
    }
    mutating func changeState(newState: viewState) {
        self = newState
    }
}

class GlobalPositionViewController: UIViewController {
    
    @IBOutlet weak var languageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var currentState = viewState()
    
    
    var controller: NumerosTipController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup
        loadNavBar()
        loadSearchBar()
        addCancelGestureRecognizer()
        loadLanguageSelector()
        

        controller = NumerosTipController.sharedInstance
        
        // Change necessary View
        viewHandler()
    }

    @IBAction func actionButton(_ sender: Any) {
        controller?.llamadaServicioWeb(viewController: self){
            response in
            print("acabado")
        }
    }
    
    func loadNavBar() {
        self.navigationItem.title = "Numeros Tip"
        self.navigationController?.navigationBar.barTintColor = .lightGray
    }
    
    func loadSearchBar() {
        searchBar.placeholder = "Introduce un número entero o romano"
//        searchBar.showsCancelButton = true
    }
    
    func addCancelGestureRecognizer() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(GlobalPositionViewController.removeFocusSearchBar))
        self.view.addGestureRecognizer(gesture)
    }
    
    func removeFocusSearchBar() {
        print("remove")
        searchBar.resignFirstResponder()
    }
    
    func loadLanguageSelector() {
        
        let dataSource = NumerosTipLanguageCollectionDataSource()
        languageCollectionView.dataSource = dataSource
        languageCollectionView.delegate = NumerosTipLanguageCollectionDelegate()
    }
    
    func viewHandler() {
        switch self.currentState {
        case .InitialView:
            break
        case .ResultView:
            break
        case .ErrorView:
            break
        }
    }
    
    
    func removeSubview(tag: Int){
        if let viewWithTag = self.view.viewWithTag(tag) {
            viewWithTag.removeFromSuperview()
        }
    }

}

// MARK: - SearchBar Delegate

extension GlobalPositionViewController: UISearchBarDelegate {
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("clic en la searchBar")
        searchBar.text = nil
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("clic fuera del searchBar?")
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.searchDisplayController?.setActive(false, animated: true)
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("texto cambiado")
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clic en buscar")
        
        // Quit focus
        searchBar.resignFirstResponder()
        
        // Iniciar llamada al servicio
        
    }

}

