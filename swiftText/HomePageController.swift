//
//  HomePageController.swift
//  swiftText
//
//  Created by jingjun on 2018/8/28.
//  Copyright © 2018年 景军. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class HomePageController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0.0
        tableView.estimatedSectionHeaderHeight = 0.0
        tableView.estimatedSectionFooterHeight = 0.0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        return tableView
    }()
    
    lazy var header : AccountHeaderView = {
        let header = AccountHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 201))
        return header
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scrollViewDidMainScroll(self.tableView)
    }
    
    func setTableView() {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.tableHeaderView = header
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension HomePageController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "第\(indexPath.row)行"
        cell.contentView.backgroundColor = .white
        cell.textLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.header.scrollVieDidScroll(offsetY: scrollView.contentOffset.y)
        self.scrollViewDidMainScroll(self.tableView)
    }
    
}
extension HomePageController {
    func scrollViewDidMainScroll(_ scrollView: UIScrollView) {
        let naviHeight = statusBarH + (self.navigationController?.navigationBar.frame.size.height ?? 0)
        let minAlphaOffset : CGFloat = 0
        let maxAlphaOffset : CGFloat = 200 + naviHeight
        
        let offset = scrollView.contentOffset.y
        let alpha = (offset - minAlphaOffset)/(maxAlphaOffset - minAlphaOffset)
        
        let color = UIColor.white
        let offsetY: CGFloat = scrollView.contentOffset.y
        
        guard isCurrentViewController() else{
            return
        }
        
        if offsetY < 100 {
            self.navigationController?.navigationBar.barStyle = .black
            
            navigationItem.title = ""
            self.navigationController?.navigationBar.Mg_setBackgroundColor(backgroundColor: UIColor.clear.withAlphaComponent(0))
            
        }else if offsetY < (200) {
            self.navigationController?.navigationBar.barStyle = .black
            
            self.navigationController?.navigationBar.Mg_setBackgroundColor(backgroundColor: color.withAlphaComponent(alpha))
            navigationItem.title = ""

        } else {
            self.navigationController?.navigationBar.Mg_setBackgroundColor(backgroundColor: color.withAlphaComponent(1))
            self.navigationController?.navigationBar.barStyle = .default
            

            self.navigationItem.title = "标题"

        }
    }

    
    func isCurrentViewController() -> Bool{
           return self.navigationController?.viewControllers.last == self
       }
}
