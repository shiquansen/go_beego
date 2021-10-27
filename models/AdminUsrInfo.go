package models

import (
	"gorm.io/gorm"
	"myapp/utils/errmsg"
)

// 管理员信息模型结构体
type AdminUsrInfo struct {
	gorm.Model
	UsrId int `form:"usrid" gorm:"type:int;not null" json:"usrid"`

	//昵称
	Nickname string `form:"nickname" gorm:"type:varchar(255);not null" json:"nickname" validate:"required,min=2,max=12" label:"昵称"`
	//座右铭
	Motto string `form:"motto" gorm:"type:varchar(255);not null" json:"motto" validate:"required,min=2,max=50" label:"座右铭"`
	//地址
	Address string `form:"address" gorm:"type:varchar(255);not null" json:"address" validate:"required" label:"地址"`
	//个人信息
	PersonalInfo string `form:"personalInfo" gorm:"type:varchar(2048);not null" json:"personalInfo" label:"个人信息"`
	//个人介绍
	PersonalIntroduction string `form:"personalIntroduction" gorm:"type:longtext;not null" json:"personalIntroduction" label:"个人介绍"`
}


// 新增管理员信息
func CreateAdminUserInfo(adminUserInfo *AdminUsrInfo) int {

	err := db.Create(adminUserInfo).Error

	if err != nil {
		return errmsg.ERROR //500
	}
	return errmsg.SUCCSE
}


// 编辑管理员信息
func EditAdminUserInfo(id int, info *AdminUsrInfo) int {
	var adminuserinfo AdminUsrInfo
	var maps = make(map[string]interface{})
	maps["usr_id"] = info.UsrId
	maps["nickname"] = info.Nickname
	maps["motto"] = info.Motto
	maps["address"] = info.Address
	maps["personal_info"] = info.PersonalInfo
	maps["personal_introduction"] = info.PersonalIntroduction
	err := db.Model(&adminuserinfo).Where("id = ?", id).Updates(maps).Error
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}


//获取单个管理员信息
func GetAdminUsrInfo(id int) (AdminUsrInfo, int) {
	var AdminUsrInfo AdminUsrInfo

	err := db.Where("id = ?", id).Last(&AdminUsrInfo).Error
	if err != nil {
		return AdminUsrInfo, errmsg.ERROR_ARTICLE_NOTEXIST
	}
	return AdminUsrInfo, errmsg.SUCCSE
}


//获取所有管理员信息
func GetAdminUsrInfoList() ([]AdminUsrInfo, int) {
	var AdminUsrInfoList []AdminUsrInfo

	err := db.Find(&AdminUsrInfoList).Error
	if err != nil {
		return AdminUsrInfoList, errmsg.ERROR_ARTICLE_NOTEXIST
	}
	return AdminUsrInfoList, errmsg.SUCCSE
}


//删除管理员信息
func DeleteAdminUsrInfo(id int) int {
	var adusrinfo AdminUsrInfo
	err := db.Where("id = ?", id).Delete(&adusrinfo).Error
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}