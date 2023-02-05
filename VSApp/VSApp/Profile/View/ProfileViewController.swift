//
//  ProfileViewController.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit

final class ProfileViewController: UIViewController {

    private var viewModel = ProfileViewModel()
    @IBOutlet private var profileTable: UITableView!
    private var child: VSSpinnerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel.delegate = self
        fetchProductList()
    }
    
    func fetchProductList() {
        createSpinnerView()
        viewModel.getProfileData()
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
}

// MARK: - API Service Protocol Confirming Methods
extension ProfileViewController: ProfileAPIServiceCompletionProtocol {
    func didFinishFetchingProductListResponse(results: Profile?, error: Error?) {
        if error == nil {
            DispatchQueue.main.async { [weak self] in
                guard let _ = results else {
                    self?.destorySpinnerView()
                    self?.showAlertWithReloadApiCall()
                    return
                }
                self?.profileTable.reloadData()
                self?.destorySpinnerView()
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.destorySpinnerView()
                self?.showAlertWithReloadApiCall()
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberofsection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", indexPath: indexPath)
        cell.textLabel?.text = viewModel.getRowTitle(index: indexPath)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getSectionHeaderTitle(index: section)
    }
}
