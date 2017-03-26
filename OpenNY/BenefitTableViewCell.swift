//
//  BenefitTableViewCell.swift
//  OpenNY
//
//  Created by Mihaela Miches on 3/26/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

protocol BenefitTableViewCellDelegate {
    func didResizeTableViewCell()
}

class BenefitTableViewCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var plainProgramNameLabel: UILabel!
    @IBOutlet weak var resizeButton: UIButton!
    @IBOutlet weak var detailsStackView: UIStackView!
    
    var delegate: BenefitTableViewCellDelegate?
    
    @IBAction func didTapToResize(_ sender: AnyObject) {
        expanded ? collapse() : expand()
    }
    
    
    var expanded: Bool = true
    
    func expand() {
        expanded = true
        self.detailsStackView?.isHidden = !self.expanded
        resizeButton?.setImage(#imageLiteral(resourceName: "expanded"), for: .normal)
    }
    
    func collapse() {
        expanded = false
        self.detailsStackView?.isHidden = !self.expanded
        resizeButton?.setImage(#imageLiteral(resourceName: "collapsed"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyStyle()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.applyStyle()
    }
    
    func applyStyle() {
        resizeButton?.isHidden = true 
        textView?.tintColor = UINavigationBar.appearance().tintColor
        plainProgramNameLabel?.textColor = UINavigationBar.appearance().tintColor
        resizeButton?.tintColor = UINavigationBar.appearance().tintColor
        accessoryView?.backgroundColor = UINavigationBar.appearance().tintColor
    }

}
