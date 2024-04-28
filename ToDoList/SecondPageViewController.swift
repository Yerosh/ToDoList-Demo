//
//  SecondPageViewController.swift
//  ToDoList
//
//  Created by Yernur Adilbek on 11/1/23.
//

import UIKit

class SecondPageViewController: UIViewController {
    
    let list = ["Add a list Item", "Milk", "Cheese", "Flour", "Apples", "Bread", "Butter", "Rubbish bags", "Bananas", "Watermelon", "Cocao", "Water", "Tea", "Coffee"]
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        return icon
    }()

    private lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.text = "Created on Nov 1st at 8:34 pm"
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var trash: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "trash.circle"))
        icon.tintColor = .black
        return icon
    }()
    
    let items = ["TO DO(14)", "COMPLETE(0)"]
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        segmentedControl.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentTintColor = .black
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        return segmentedControl
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    private lazy var backButton: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 35
        return view
    }()
    
    private lazy var scrollDownButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.down")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(scrollDownButtonTapped), for: .touchUpInside)
        return button
    }()
    
    func configure(imageName: String, task: String){
        icon.image = UIImage(named: imageName)
        taskLabel.text = task
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func indexChanged(_ segmentedControl: UISegmentedControl){
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            tableView.isHidden = false
        case 1:
            tableView.isHidden = true
        default:
            break
        }
    }
    
    @objc func scrollDownButtonTapped() {
//        let yOffset = tableView.frame.height - tableView.contentSize.height
        let yOffset =  tableView.contentSize.height - tableView.frame.height
        tableView.setContentOffset(CGPoint(x: 0, y: yOffset), animated: true)
    }

}

extension SecondPageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let itemName = list[indexPath.row]
        cell.textLabel?.text = itemName
        func image( _ image:UIImage, withSize newSize:CGSize) -> UIImage {

            UIGraphicsBeginImageContext(newSize)
            image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!.withRenderingMode(.automatic)
        }
        
        if indexPath.row == 0{
            cell.imageView?.image = image(UIImage(named: "addItem")!, withSize: CGSize(width: 35, height: 35))
        }else{
            cell.imageView?.image = image(UIImage(named: "square")!, withSize: CGSize(width: 35, height: 35))
        }
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .black
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SecondPageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (view.window?.windowScene?.screen.bounds.height ?? 0) * 0.08
    }
}

// MARK: - setting iui methods
private extension SecondPageViewController {
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(topView)
        topView.addSubview(icon)
        topView.addSubview(taskLabel)
        topView.addSubview(date)
        topView.addSubview(trash)
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        view.addSubview(backButton)
        backButton.addSubview(scrollDownButton)
    }
    
    func setupConstraints() {
        topView.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10)
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        taskLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(icon.snp.trailing).offset(10)
        }
        
        date.snp.makeConstraints { make in
            make.top.equalTo(taskLabel.snp.bottom)
            make.leading.equalTo(taskLabel)
        }
        
        trash.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }
        scrollDownButton.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.center.equalToSuperview()
        }
    }
}

