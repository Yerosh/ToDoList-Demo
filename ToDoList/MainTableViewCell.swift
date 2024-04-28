//
//  MainTableViewCell.swift
//  ToDoList
//
//  Created by Yernur Adilbek on 10/31/23.
//
import UIKit

class MainTableViewCell: UITableViewCell {
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var ellipsisIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "ellipsis")
        imageView.tintColor = .systemGray3
        imageView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageName: String, task: String, progress: String, isCompleted: Bool) {
        icon.image = UIImage(named: imageName)
        progressLabel.text = progress
        
        if isCompleted {
            let attributedString = NSMutableAttributedString(string: task)
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            taskLabel.attributedText = attributedString
        } else {
            let attributedString = NSAttributedString(string: task)
            taskLabel.attributedText = attributedString
        }
    }
}


// MARK: - setting iui methods
private extension MainTableViewCell {
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(icon)
        addSubview(taskLabel)
        addSubview(progressLabel)
        addSubview(ellipsisIcon)
    }
    
    func setupConstraints() {
        icon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(self.snp.height).multipliedBy(0.5)
        }
        taskLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.width.equalTo(300)
            make.top.equalToSuperview().offset(10)
        }
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(taskLabel.snp.bottom)
            make.leading.equalTo(taskLabel)
        }
        ellipsisIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.size.equalTo(self.snp.height).multipliedBy(0.4)
            make.centerY.equalToSuperview()
        }
    }
}
