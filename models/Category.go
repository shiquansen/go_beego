// 分类模型

package models

import (
	"gorm.io/gorm"
	"myapp/utils/errmsg"
)

// 分类模型
type Category struct {
	// 主键id
	ID uint `form:"id" gorm:"primary_key;auto_increment" json:"id"`

	Name string `form:"name" gorm:"tpye:varchar(20);not null" json:"name"`
}


// 查询分类是否存在
func CheckCategory(name string) (code int) {
	var cate Category

	db.Where("name == ?", name).First(&cate)
	if cate.Name != "" {
		return errmsg.ERROR_CATEGORYNAME_USED //3001
	}
	return errmsg.SUCCSE //200
}

// 新增分类
func CreateCategory(data *Category) int {
	err := db.Create(data).Error
	// 失败
	if err != nil {
		return errmsg.ERROR //500
	}
	return errmsg.SUCCSE //200
}

// 获取一个分类
func GetCategory(id int) (Category,int) {
	var cate Category
	err := db.Where("id = ?", id).First(&cate).Error
	if err != nil {
		return cate, errmsg.ERROR
	}
	return cate, errmsg.SUCCSE
}


// 查询分类列表
func GetCategories(name string,pageSize int, pageNum int) ([]Category, int64){
	var cates []Category
	var total int64

	if name != "" {
		db.Where("name = ?","%"+name+"%").Find(&cates).Limit(pageSize).Offset(pageSize*(pageNum-1))
		db.Model(&cates).Where(
			"name LIKE ?", "%"+name+"%",
		).Count(&total)
		return cates,total
	}

	err := db.Find(&cates).Limit(pageSize).Offset(pageSize * (pageNum - 1)).Error
	db.Model(&cates).Count(&total)
	// 不存在
	if err != nil && gorm.ErrRecordNotFound != nil {
		return nil, 0
	}
	return cates, total

}

// 查询所有分类
func GetAllCategory() ([]Category, int64){
	var cates []Category
	var total int64

	err := db.Find(&cates).Count(&total).Error

	// 不存在
	if err != nil && gorm.ErrRecordNotFound != nil {
		return nil, 0
	}
	return cates, total

}



// 编辑分类
func EditCategory(id int, data *Category) int {
	var cate Category
	var maps = make(map[string]interface{})
	maps["name"] = data.Name
	err := db.Model(&cate).Where("id = ?", id).Updates(maps).Error
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}

// 删除分类
func DeleteCategory(id int) int {
	var cate Category
	err := db.Where("id = ?", id).Delete(&cate).Error
	// 删除失败
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}
