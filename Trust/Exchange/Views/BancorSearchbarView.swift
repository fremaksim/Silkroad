// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BancorSearchbarView: UIView {
    
    var textfield: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.bancorBlue
        
        textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = UIColor(red: 41, green: 107, blue: 176)
        textfield.layer.cornerRadius = 15.5
        textfield.layer.masksToBounds = true
        textfield.attributedPlaceholder =
            NSAttributedString(string: "搜索名称",
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        let leftView = UIImageView(image: R.image.icon_search_S())
        leftView.translatesAutoresizingMaskIntoConstraints = false
        textfield.leftView  = leftView
        textfield.leftViewMode = .always
        addSubview(textfield)
        
        NSLayoutConstraint.activate([
            textfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            textfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            textfield.heightAnchor.constraint(equalToConstant: 31),
            textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
