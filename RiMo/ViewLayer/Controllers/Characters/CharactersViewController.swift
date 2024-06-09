//
//  CharactersViewController.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import UIKit

protocol CharactersViewControllerProtocol: AnyObject {
    func showDetail(character: Character)
}

class CharactersViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var charactersListView: CharactersListView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var noDataView: UIView!
    
    
    // MARK: - Private attributes
    private var presenter: CharactersPresenterProtocol = CharactersPresenter()
    private weak var delegate: CharactersViewControllerProtocol?
    
    // MARK: - Constructor/Initializer
    public static func instantiate(delegate: CharactersViewControllerProtocol,
                                   presenter: CharactersPresenterProtocol = CharactersPresenter()) -> CharactersViewController {
        let storyboard = UIStoryboard(name: "Characters", bundle: nil)
        guard let charactersViewController = storyboard.instantiateViewController(withIdentifier: String(describing: CharactersViewController.self)) as? CharactersViewController else {
            return CharactersViewController()
        }
        charactersViewController.presenter = presenter
        charactersViewController.delegate = delegate
        return charactersViewController
    }
    
    // MARK: - Lifecycle/Overridden
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    // MARK: -  Private attributes
    private func setupViewController() {
        self.title = "characters_title".localized
        self.noDataLabel.text = "no_data_available".localized
        self.noDataImage.image = UIImage(named: "noData")
        self.noDataView.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.noDataView.addGestureRecognizer(tap)
        self.noDataView.isUserInteractionEnabled = true
                                        
        self.charactersListView.set(presenter: presenter)
       self.charactersListView.charactersListViewDelegate = self
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
         refresh()
      }
    
    private func refresh() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        presenter.fetch { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.isHidden = true
                switch result {
                case .success(let characters):
                    self?.charactersListView.set(characters: characters)
                    self?.noDataView.isHidden = true
                case .failure(let error):
                    self?.noDataView.isHidden = false
                    self?.presentAlert(error: error)
                }
            }
        }
    }
    
    private func presentAlert(error: Error) {
        let alert = UIAlertController(title: "alert_title".localized,//"characters_alert_title".localized,
                                      message: error.localizedDescription,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "alert_retry".localized, style: .cancel, handler: { [weak self] _ in
            self?.refresh()
             }))
        alert.addAction(UIAlertAction(title: "alert_continue".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK :- CharactersListViewProtocol
extension CharactersViewController: CharactersListViewProtocol {
    func showDetail(character: Character) {
        delegate?.showDetail(character: character)
    }
}
