package models

import (
	"gorm.io/gorm"
	"myapp/utils/errmsg"
)

type FriendlyLink struct {
	gorm.Model

	//名称
	Linkname string `form:"linkname" gorm:"type:varchar(255);not null" json:"linkname" validate:"required" label:"网站名称"`
	//网址
	Website string `form:"website" gorm:"type:varchar(255);not null" json:"website" validate:"required" label:"网址"`
	//域名
	DomainName string `form:"domainName" gorm:"type:varchar(255);not null" json:"domainName" label:"域名"`
}


//获取所有友链
func GetFriendlyLinks() ([]FriendlyLink, int) {
	var fls []FriendlyLink

	err := db.Order("linkname ASC").Find(&fls).Error
	if err != nil {
		return nil, errmsg.ERROR
	}
	return fls, errmsg.SUCCSE
}
