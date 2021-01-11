//
//  FullScreenImageViewController.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/10/21.
//

import UIKit

class FullScreenImageViewController: UIViewController {

    private let imageURL: String

    init(imageURL: String) {
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        view.addSubViewWithFillConstraints(imageView)
        return imageView
    }()

    private func setUI() {
        guard let imageURL = URL(string: imageURL) else { return }
        imageView.downloadImageFrom(url: imageURL)
    }
}
