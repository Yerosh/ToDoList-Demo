//
//  ViewController.swift
//  ToDoList
//
//  Created by Yernur Adilbek on 10/31/23.
//
import SnapKit
import UIKit

class ViewController: UIViewController {
    
    private let items = ["YESTERDAY", "TODAY (25)", "TOMORROW"]
    
    private let sections = ["TO DO (9)","FROM YESTERDAY (5)", "COMPLETED (11)"]
    private let iconsToDo = ["alarm", "atom", "case", "heart", "notebook", "pig", "plane", "school", "trophy"]
    private let tasks = ["Task 1 sdfsfsfsfsafdsafdsafsafsafsadfa", "Task 2", "Task 3", "Task 4", "Task 5", "Task 6", "Task 7", "Task 8", "Task 9"]
    private let progressOfTasks = ["1 of 2 tasks complete", "2 of 3 tasks complete","1 of 5 tasks complete","0 of 2 tasks complete","0 of 4 tasks complete","2 of 7 tasks complete","0 of 15 tasks complete","0 of 23 tasks complete","0 of 1 task complete"]
    
    private let iconsFromYesterday = ["bath", "bed", "laundry", "pillow", "plant"]
    private let tasksFromYesterday = ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"]
    private let progressOfYesterdayTasks = ["1 of 2 tasks complete", "2 of 3 tasks complete","1 of 5 tasks complete","0 of 2 tasks complete","0 of 4 tasks complete"]
    
    private let tasksCompleted = ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5", "Task 6", "Task 7", "Task 8", "Task 9", "Task 10", "Task 11"]
    private let progressOfCompletedTasks = ["2 of 2 tasks complete", "3 of 3 tasks complete","5 of 5 tasks complete","2 of 2 tasks complete","4 of 4 tasks complete","7 of 7 tasks complete","15 of 15 tasks complete","23 of 23 tasks complete","1 of 1 task complete", "2 of tasks completed", "1 of tasks completed"]
    
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var calendarIcon: UIImageView = {
        let imageview = UIImageView(image: UIImage(systemName: "calendar"))
        imageview.tintColor = .black
        return imageview
    }()
    
    private lazy var appTitle: UILabel = {
        let label = UILabel()
        label.text = "To Do List"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var progressTitle: UILabel = {
        let label = UILabel()
        label.text = "14 tasks, 11 completed"
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var searchIcon: UIImageView = {
        let imageview = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageview.tintColor = .black
        return imageview
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        segmentedControl.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentTintColor = .black
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        return segmentedControl
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        return view
    }()
    
    private lazy var backButton: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 35
        return view
    }()
    
    private lazy var addTask: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "plus.circle")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addTaskTupped), for: .touchUpInside)
        return button
    }()
    
    private lazy var visualEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        visualEffectView.alpha = 0.3
        return visualEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func addTaskTupped() {
        let destinationVC = AddTaskViewController()
        present(destinationVC, animated: true)
    }
    
    
    @objc func indexChanged(_ segmentedControl: UISegmentedControl){
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            tableView.isHidden = true
        case 1:
            tableView.isHidden = false
        case 2:
            tableView.isHidden = true
        default:
            break
        }
    }
}


//MARK: - Table view data source methods
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            tasks.count
        case 1:
            tasksFromYesterday.count
        case 2:
            tasksCompleted.count
        default:
            0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        switch indexPath.section{
        case 0:
            cell.configure(imageName: iconsToDo[indexPath.row], task: tasks[indexPath.row], progress: progressOfTasks[indexPath.row], isCompleted: false)
        case 1:
            cell.configure(imageName: iconsFromYesterday[indexPath.row], task: tasksFromYesterday[indexPath.row], progress: progressOfYesterdayTasks[indexPath.row], isCompleted: false)
        case 2:
            cell.configure(imageName: "done", task: tasksCompleted[indexPath.row], progress: progressOfCompletedTasks[indexPath.row], isCompleted: true)
        default:
            break
        }
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destinationVC = SecondPageViewController()
        destinationVC.configure(imageName: iconsToDo[indexPath.row], task: tasks[indexPath.row])
        destinationVC.configure(imageName: iconsToDo[indexPath.row], task: tasks[indexPath.row])
        self.present(destinationVC, animated: true)
    }
}

//MARK: - Table view delegate methods
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (view.window?.windowScene?.screen.bounds.height ?? 0) * 0.08
    }
}

// MARK: - setting iui methods
private extension ViewController {
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(topView)
        topView.addSubview(calendarIcon)
        topView.addSubview(appTitle)
        topView.addSubview(progressTitle)
        topView.addSubview(searchIcon)
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        view.addSubview(visualEffectView)
        view.addSubview(backButton)
        backButton.addSubview(addTask)
    }
    
    
    func setupConstraints() {
        topView.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10)
        }
        
        calendarIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
        
        appTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        progressTitle.snp.makeConstraints { make in
            make.top.equalTo(appTitle.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        searchIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        
        visualEffectView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(6)
        }
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(70)
            make.bottom.equalTo(visualEffectView.contentView.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }
        addTask.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.center.equalToSuperview()
        }
    }
}
