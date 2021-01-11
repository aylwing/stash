//
//  SmartInvestingCollectionViewController.swift
//  Viper Architecture
//
//  Created by Aylwing Olivas on 1/9/21.
//

import UIKit

final class SmartInvestingCollectionViewController: UICollectionViewController {

    var presenter: Presenter?

    var smartInvestingEntity: SmartInvesting! {
        didSet {
            DispatchQueue.main.async(group: nil, qos: .userInteractive, flags: .inheritQoS, execute: setUI)
        }
    }

    private enum Section: CaseIterable {
        case main
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Achievement>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Achievement>

    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] (collectionView, indexPath, video) -> UICollectionViewCell in
            let cell: AchievementCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.achievement = self?.smartInvestingEntity.achievements[indexPath.row]
            return cell
        }

        return dataSource
    }()

    // initialized with a non-nil layout parameter
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        title = smartInvestingEntity.overview.title
        collectionView.register(AchievementCollectionViewCell.self)
        collectionView.collectionViewLayout = generateLayout()
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = .white
        applySnapshot(animatingDifferences: false)
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4123128653, green: 0.2116860151, blue: 0.8062877655, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false

        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Arial", size: 18) ?? UIFont.systemFont(ofSize: 18)
        ]
    }

    // Seen some modal treated as views with dedicated presenters
    // But within iOS any viewcontroller can technically function as a presenter

    @objc private func infoButtonTapped(button: UIButton) {
        let infoAlert = UIAlertController(title: "Success: \(smartInvestingEntity.success)", message: "Status: \(smartInvestingEntity.status)", preferredStyle: .alert)
        infoAlert.modalPresentationStyle = .popover
        infoAlert.popoverPresentationController?.sourceView = button
        infoAlert.popoverPresentationController?.permittedArrowDirections = .down
        infoAlert.addAction(.init(title: "OK", style: .default, handler: nil))
        present(infoAlert, animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let achievement = dataSource.itemIdentifier(for: indexPath) else { return }
        guard achievement.accessible else { return }
        presenter?.selected(article: achievement)
    }

    /*

     Note:
     Using `NSDiffableDataSourceSnapshot` allows to be a little creative/free with prefetch and lazy loading should this ever be
     used with a real backend server and not read from a local file. Also removes a lot boilerplate code

    */

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        Section.allCases.forEach { snapshot.appendItems(smartInvestingEntity.achievements, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func generateLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))

        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)

        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 15,
                                                              leading: 25,
                                                              bottom: 5,
                                                              trailing: 25)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: fullPhotoItem, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
