//
//  TimeLineViewController.swift
//  github
//
//  Created by 若原昌史 on 2018/08/01.
//  Copyright © 2018年 若原昌史. All rights reserved.
//

import Foundation
import UIKit
import SafariServices


extension TimeLineViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let timelineCell = tableView.dequeueReusableCell(withIdentifier: "TimeLineCell") as? TimeLineCell{
            let cellViewModel = viewModel.cellViewModels[indexPath.row]
            timelineCell.setNickName(nickName: cellViewModel.nichName)
            cellViewModel.downloadImage{(progress) in
                switch progress{
                case .loading(let image):
                    timelineCell.setIcon(icon: image)
                break
                
                case .finish(let image):
                    timelineCell.setIcon(icon: image)
                break
                case .error:
                    break
                }
        }
            return timelineCell
        }
        fatalError()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        let webURL = cellViewModel.webURL
        
        let webViewController = SFSafariViewController(url: webURL)
        navigationController?.pushViewController(webViewController, animated: true)
        
    }
}



class TimeLineViewController: UIViewController {

    fileprivate var viewModel:UserListViewModel!
    fileprivate var tableVeiw:UITableView!
    fileprivate var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVeiw = UITableView(frame:view.bounds,style:.plain)
        tableVeiw.delegate = self
        tableVeiw.dataSource = self
        tableVeiw.register(TimeLineCell.self, forCellReuseIdentifier: "TimeLineCell")
        view.addSubview(tableVeiw)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueDidChange(sender:)), for: .valueChanged)
        tableVeiw.refreshControl = refreshControl
        
        viewModel = UserListViewModel()
        viewModel.stateDidUpdate = {[weak self] state in
            switch state{
            case .loading:
                self?.tableVeiw.isUserInteractionEnabled = false
                break
            case .finish:
                self?.tableVeiw.isUserInteractionEnabled = true
                self?.tableVeiw.reloadData()
                self?.refreshControl.endRefreshing()
                break
            case .error(let error):
                self?.tableVeiw.isUserInteractionEnabled = true
                self?.refreshControl.endRefreshing()
                
                let alertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self?.present(alertController,animated: true,completion:nil)
                break
            }
        }
        viewModel.getUsers()
    }
    
    @objc func refreshControlValueDidChange(sender: UIRefreshControl){
        viewModel.getUsers()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
