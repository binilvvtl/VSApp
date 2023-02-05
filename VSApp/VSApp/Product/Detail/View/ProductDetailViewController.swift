//
//  ProductDetailViewController.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var brandLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView(item: product)
    }
    
    func setupView(item: Product?) {
        guard let item = item else { return }
        detailLabel.text = item.productDesc
        titleLabel.text = item.name
        brandLabel.text = item.brand
        if let url = item.productUrl {
            productImage.sd_setImage(with: URL.init(string: url), completed: nil)
        }
        priceLabel.attributedText =  "".setupPricevalue(price: item.price, offerPrice: item.offerPrice)
        
    }

}
