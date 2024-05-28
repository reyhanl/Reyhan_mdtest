//
//  ViewController.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol , UISearchBarDelegate, UISearchControllerDelegate{
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    lazy var filterView: FilterView = {
        let view = FilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    var searchController: UISearchController?
    let refreshControl = UIRefreshControl()
    
    var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground    
        presenter?.viewDidLoad()
        addTableView()
        addSearchBar()
        addFilterView()
        addSignOutButton()
        addPullToRefresh()
        // Do any additional setup after loading the view.
    }
    
    func addTableView(){
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    func addFilterView(){
        view.addSubview(filterView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: filterView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -50),
            NSLayoutConstraint(item: filterView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: filterView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: filterView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 30),
        ])
    }
    
    func addSearchBar(){
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        self.searchController = search
    }
    
    func addSignOutButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOut))
    }
    
    func addPullToRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func updateProfileData() {
        tableView.reloadData()
    }
    
    func stopRefreshControl(){
        refreshControl.endRefreshing()
    }
    
    @objc func refresh(_ control: UIRefreshControl){
        presenter?.userRefreshData()
    }
    
    @objc func signOut(){
        presenter?.signOut()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else{return}
        presenter?.search(text, filter: filterView.filter)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserTableViewCell
        if let user = presenter?.profile(at: indexPath.row){
            cell.setupCell(user: user)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ProfileView(frame: .zero)
        if let profile = presenter?.getProfile(){
            headerView.setupView(profile: profile)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension HomeViewController: FilterViewDelegate{
    func userDidSelectFilter(filter: Filter) {
        presenter?.search(searchController?.searchBar.text ?? "", filter: filterView.filter)
    }
}

