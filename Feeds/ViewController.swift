//
//  ViewController.swift
//  Feeds
//
//  Created by Sarathi M on 9/14/21.
//

import UIKit

protocol ViewModelDelegate {
    func fetchData(url: String)
    var feed: Feed? {set get}
}

class ViewController: UIViewController, ViewModelToViewDelegate{
    
    let tableView = UITableView()
    let viewModel = ViewModel()
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        
        //setup viewmodel
        viewModel.fetchData()
        viewModel.delegate = self
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        //Constraints for tableview
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //remove empty cells
        tableView.tableFooterView = UIView()

        //register Custom Cell
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCellId")
        
        //register Loading Cell
        tableView.register(LoadingCell.self, forCellReuseIdentifier: "loadingcellid")

        //auto calculate height of each cell
        tableView.rowHeight = UITableView.automaticDimension
        
        //Delegate
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func dataReceived() {
        //update tableview evrytime datareceived
        tableView.reloadData()
        isLoading = false
    }
    
    func loadMoreData() {

            if !isLoading {  //check if no loading is already is progress if not then make a call to load more data
                isLoading = true
                viewModel.loadMore()
            }
    }
}

extension ViewController: UITableViewDataSource  {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.feed?.data?.children?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellId") as! CustomCell
            cell.data = viewModel.feed?.data?.children?[indexPath.row].data //set data to the CustomCell
            return cell
        }  else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingcellid", for: indexPath) as! LoadingCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension //Item Cell height
        } else {
            return 55 //Loading Cell height
        }
    }
}

extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //load next set of data if last element reached in a tableview
        if indexPath.section == 0 {
            let lastElement = (viewModel.feed?.data?.children?.count)!
            if !isLoading && indexPath.row == lastElement - 1 {
                loadMoreData()
            }
        }
    }
}
