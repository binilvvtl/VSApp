//
//  ProductListViewController.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit

final class ProductListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    private var viewModel = ProductListViewModel()
    private var child: VSSpinnerViewController?
    let messageLabel = UILabel()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupMessageLabel()
        setUpTableView()
        setUpSearchBar()
        viewModel.delegate = self
        fetchProductList()
    }
    
    private func setupMessageLabel() {
        messageLabel.text = "emptySearchResult".localized()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)

        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messageLabel.isHidden = true
      }
    // add the spinner view controller
    func createSpinnerView() {
        child = VSSpinnerViewController()
        guard let child = child else {
            return
        }
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    // then remove the spinner view controller
    func destorySpinnerView() {
        DispatchQueue.main.async { [weak self] in
            guard let childSpinner = self?.child else {
                return
            }
            childSpinner.willMove(toParent: nil)
            childSpinner.view.removeFromSuperview()
            childSpinner.removeFromParent()
            self?.child = nil
        }
    }
    
    // show alert with please try agian later and refresh Api call
    func showAlertWithReloadApiCall() {
        self.openAlert(title: "Error",
                       message: "somethingWentWrong".localized(),
                       alertStyle: .alert,
                       actionTitles: ["Okay".localized()],
                       actionStyles: [.default, .cancel],
                       actions: [
                        {_ in
                            self.fetchProductList()
                        }
                       ])
    }
    
    @objc func viewTapped(gesture: UITapGestureRecognizer) {
        self.openAlert(title: "",
                       message: "loginSuccessful".localized(),
                       alertStyle: .alert,
                       actionTitles: ["Okay".localized()],
                       actionStyles: [.cancel],
                       actions: [])
    }
    
    // MARK: - Making API call to fetch Articles
    
    func fetchProductList() {
        createSpinnerView()
        viewModel.getProductList()
    }
    
    
    // MARK: - Functions
    private func setUpSearchBar() {
        // Set up the navigation bar
        navigationController?.navigationBar.barStyle = .black
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.preferredSearchBarPlacement = .inline
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.isActive = false
        navigationItem.searchController?.searchBar.isHidden = true
        navigationController?.navigationBar.isOpaque = false
        searchController.searchBar.barTintColor = .lightGray
        searchController.searchBar.searchTextField.backgroundColor = .darkGray
        searchController.searchBar.searchTextField.textColor = .white
        searchController.definesPresentationContext = false
        setupRightBarButton()
    }
    
    private func setupRightBarButton() {
        // Add the search and sort buttons to the right of the navigation bar
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        let sortButton = UIBarButtonItem(title: "Sort", image: UIImage(systemName:  "line.3.horizontal.decrease"), target: self, action: #selector(sortButtonTapped(_:)))
        navigationItem.rightBarButtonItems = [sortButton, searchButton]
        navigationController?.navigationBar.tintColor = .lightGray
    }
    
    @objc func searchTapped() {
        // Show the search bar in the navigation bar
        navigationItem.rightBarButtonItems?.forEach { return $0.isHidden = true }
        navigationItem.searchController?.searchBar.isHidden = false
        navigationItem.searchController?.isActive = true
        navigationItem.searchController?.searchBar.sizeToFit()
    }
    
    
    private func setUpTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(ProductListTableViewCell.self)
        tableView.frame = view.frame
    }
    
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.filteredProducts.count == 0 && child == nil {
            messageLabel.isHidden = false
            return 0
        } else {
            messageLabel.isHidden = true
            return viewModel.filteredProducts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ProductListTableViewCell.self, indexPath: indexPath)
        cell.setupView(item: viewModel.getProduct(index: indexPath))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gesture:)))
        cell.bannerView.addGestureRecognizer(tapGesture)
        cell.bannerView.isHidden = true
        if indexPath.row == 1 {
            cell.bannerView.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = Storyboards.productDetail.instantiateVC(ProductDetailViewController.self)
        detailVC.product = viewModel.getProduct(index: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Search and Sort
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(text: searchText)
        tableView.reloadData()
    }
    
    
    @objc func sortButtonTapped(_ sender: UIBarButtonItem) {
        // Present an action sheet to allow the user to choose a sort field when sort button tap
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortByBrandAction = UIAlertAction(title: "Sort by Brand", style: .default) { _ in
            self.viewModel.sort(by: .brand)
        }
        
        let sortByNameAction = UIAlertAction(title: "Sort by Name", style: .default) { _ in
            self.viewModel.sort(by: .name)
        }
        
        let sortByPriceAction = UIAlertAction(title: "Sort by Price", style: .default) { _ in
            self.viewModel.sort(by: .price)
        }
        
        let sortByOfferPriceAction = UIAlertAction(title: "Sort by Offer Price", style: .default) { _ in
            self.viewModel.sort(by: .offerPrice)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(sortByBrandAction)
        alert.addAction(sortByNameAction)
        alert.addAction(sortByPriceAction)
        alert.addAction(sortByOfferPriceAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}



extension ProductListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.search(text: searchController.searchBar.text ?? "")
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.isHidden = true
        searchController.searchBar.text = ""
        viewModel.search(text: "")
        searchController.resignFirstResponder()
        navigationItem.rightBarButtonItems?.forEach{ return $0.isHidden = false }
        
    }
}


// MARK: - API Service Protocol Confirming Methods
extension ProductListViewController: APIServiceCompletionProtocol {
    func didFinishFetchingProductListResponse(results: [Product]?, error: Error?) {
        if error == nil {
            DispatchQueue.main.async { [weak self] in
                guard let _ = results else {
                    self?.destorySpinnerView()
                    self?.showAlertWithReloadApiCall()
                    return
                }
                self?.tableView.reloadData()
                self?.destorySpinnerView()
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.destorySpinnerView()
                self?.showAlertWithReloadApiCall()
            }
        }
    }
    
    func refreshTable() {
        tableView.reloadData()
    }
}
