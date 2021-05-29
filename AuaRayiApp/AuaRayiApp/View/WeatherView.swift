//
//  WeatherView.swift
//  AuaRayiApp
//
//  Created by Yersultan Nalikhan on 17.05.2021.
//

import UIKit

class WeatherView: UIView {
    
    //MARK: - Properties
    
    var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "backgound")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    
    var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return button
    }()
    
    let locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setWidth(30)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "location"), for: .normal)
        return button
    }()

    var searchTextfield: UITextField = {
        let tf = UITextField()        
        tf.keyboardAppearance = .dark
        tf.textAlignment = .right
        tf.setHeight(50)
        tf.backgroundColor = .init(white: 0.5, alpha: 0.67)
        tf.setWidth(265)
        tf.placeholder = "Search"
        tf.borderStyle = .roundedRect
        tf.textColor = .black
        return tf
    }()
    

     var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "London"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 34)
        return label
    }()
    
    var temperatureLabel : UILabel = {
        let label = UILabel()
        label.text = "23 °C"
        label.font = UIFont.boldSystemFont(ofSize: 70)
        label.textColor = .black
        return label
    }()
    
    var conditionView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .black
        iv.setDimensions(height: 170, width: 170)
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "sun.max")
        return iv
    }()
    
    

    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    

    
    //MARK: - Helpers
    
    func configureUI() {
        
        [backgroundImageView, topStackView ,conditionView, temperatureLabel, cityLabel,].forEach { (elem) in addSubview(elem) }
        
        configureBgImageView()
        configureStackView()
        configureConditionView()
        configureTempLbl()
        configureCityLbl()
    }
    
    
    //MARK: - AnchoringPrivateFunctionsOfProperties
    
    
    private func configureStackView(){
        topStackView.anchor(top:safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor ,paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        [locationButton,searchTextfield,searchButton,].forEach { (elem) in
            topStackView.addArrangedSubview(elem)
        }
    }
        
    private func configureBgImageView() {
        backgroundImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    private func configureConditionView() {
        conditionView.anchor(top:topStackView.bottomAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 5)

    }
        
    private func configureTempLbl() {
        temperatureLabel.anchor(top:conditionView.bottomAnchor,right: rightAnchor,paddingTop: 20,paddingRight: 15)
    }
        
    
    private func configureCityLbl() {
        cityLabel.anchor(top:temperatureLabel.bottomAnchor,right: rightAnchor,paddingTop: 20,paddingRight: 15)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
    
