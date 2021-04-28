//
//  FilterViewController.swift
//  Classifieds
//
//  Created by Marina Romanova on 28/04/2021.
//

import UIKit

class FilterViewController: UITableViewController {
	weak var filterDelegate: FilterDelegate?
	var chosenFilters: [Category]

	init(chosenFilters: [Category] = []) {
		self.chosenFilters = chosenFilters
		super.init(nibName: nil, bundle: nil)

		view.backgroundColor = Color.OffWhite
		title = "Categories"
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

protocol FilterDelegate: AnyObject {
	func applyFilters(chosenFilters: [Category])
}
