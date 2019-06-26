//
//  TimeLineCell.swift
//  github
//
//  Created by 若原昌史 on 2018/08/01.
//  Copyright © 2018年 若原昌史. All rights reserved.
//

import Foundation
import UIKit

class TimeLineCell: UITableViewCell {

    private var iconView:UIImageView!
    private var nickNameLabel:UILabel!
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        
        iconView = UIImageView()
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)
    
        nickNameLabel = UILabel()
        nickNameLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(nickNameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconView.frame = CGRect(x:15,y:15,width:45,height:45)
        iconView.layer.cornerRadius = iconView.frame.size.width/2
        
        nickNameLabel.frame = CGRect(x:iconView.frame.maxX + 15,y:iconView.frame.origin.y,width:contentView.frame.width - iconView.frame.maxX - 15 * 2,height:15)
    }
    
    func setNickName(nickName:String){
        nickNameLabel.text = nickName
    }
    
    func setIcon(icon:UIImage){
        iconView.image = icon
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
