//
//  ProductListTableViewCell.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit
import SDWebImage

class ProductListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var containerStack: UIStackView!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var brandLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupView(item: Product?) {
        guard let item = item else { return }
        detailLabel.text = item.productDesc
        titleLabel.text = item.name
        brandLabel.text = item.brand
        if let url = item.productUrl {
            productImage.sd_setImage(with: URL.init(string: url), completed: nil)
        }
        priceLabel.attributedText = "".setupPricevalue(price: item.price, offerPrice: item.offerPrice)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
