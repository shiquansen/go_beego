// 文章模型

package models

import (
	"fmt"
	"gorm.io/gorm"
	"myapp/utils/errmsg"
)

// 文章模型
type Article struct {
	gorm.Model

	Category Category `gorm:"foreignkey:Cid"`

	Title    string `form:"title" gorm:"type:varchar(1024);not null" json:"title"`
	Cid      int    `form:"cid" gorm:"type:int;not null" json:"cid"`
	Desc     string `form:"desc" gorm:"type:varchar(1024)" json:"desc"`
	Content  string `form:"content" gorm:"type:longtext;not null" json:"content"`
	PageView int    `form:"pageview" gorm:"type:int" json:"pageview"`
}

// 新增文章
func CreateArticle(data *Article) int {
	err := db.Create(data).Error

	if err != nil {
		return errmsg.ERROR //500
	}
	return errmsg.SUCCSE
}

// 查询单个文章
func GetOneArticle(id int) (Article, int) {
	var art Article
	err := db.Preload("Category").Where("id = ?", id).Find(&art).Error
	if err != nil {
		return art, errmsg.ERROR_ARTICLE_NOTEXIST
	}
	return art, errmsg.SUCCSE
}

// 查询文章列表
func GetArticles(keywords string, pageSize int, pageNum int, ordBy string) ([]Article, int, int64) {
	var articleList []Article
	var total int64

	if ordBy == "" {
		ordBy = "id asc"
	}

	if keywords == "" {
		err := db.Preload("Category").Order(ordBy).Limit(pageSize).Offset(pageSize * (pageNum - 1)).Find(&articleList).Error
		db.Model(&Article{}).Count(&total)
		if err != nil && gorm.ErrRecordNotFound != nil {
			return nil, errmsg.ERROR, 0
		}
		return articleList, errmsg.SUCCSE, total
	}

	err := db.Preload("Category").Where("title LIKE ?", "%"+keywords+"%").Order(ordBy).Limit(pageSize).Offset(pageSize * (pageNum - 1)).Find(&articleList).Error
	db.Model(&Article{}).Where("title LIKE ?", "%"+keywords+"%").Count(&total)

	fmt.Println("total: ",total)

	if err != nil && gorm.ErrRecordNotFound != nil {
		return nil, errmsg.ERROR, 0
	}
	return articleList, errmsg.SUCCSE, total
}

//获取pageCount
func GetArticlePageCount(cateId int, pageSize int) int {
	var totalCount int64

	if cateId <= 0{
		db.Model(Article{}).Count(&totalCount)
	}else {
		db.Model(Article{}).Where("cid = ?", cateId).Count(&totalCount)
	}

	total := int(totalCount)
	if total % pageSize == 0 {
		return total / pageSize
	} else {
		return (total / pageSize) + 1
	}
}


//获取keywords搜索的pageCount
func GetArticlePageCountOfSearch(keywords string, pageSize int) int {
	var totalCount int64

	db.Model(&Article{}).Where("title LIKE ?", "%"+keywords+"%").Count(&totalCount)

	total := int(totalCount)
	if total % pageSize == 0 {
		return total / pageSize
	} else {
		return (total / pageSize) + 1
	}
}



// @title	GetCateArt
// @description	查询分类某个分类下的文章
// @param	id	int 分类id
// @param	pageSize	int 分页大小
// @param	pageNum	int 页码
// @return	[]Article  article切片
// @return	int  错误代码
func GetCateArt(id int, pageSize int, pageNum int) ([]Article, int, int64) {
	var cateArtList []Article
	var total int64

	err := db.Preload("Category").Where("cid = ?", id).Limit(pageSize).Offset(pageSize * (pageNum - 1)).Find(&cateArtList).Error
	db.Model(&Article{}).Count(&total)
	if err != nil {
		return nil, errmsg.ERROR_CATEGORY_NOTEXIST, 0
	}
	return cateArtList, errmsg.SUCCSE, total
}

// 编辑文章
func EditArticle(id int, data *Article) int {
	var article Article
	var maps = make(map[string]interface{})
	maps["title"] = data.Title
	maps["cid"] = data.Cid
	maps["desc"] = data.Desc
	maps["content"] = data.Content
	err := db.Model(&article).Where("id = ?", id).Updates(maps).Error
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}

// 更新浏览量
func UpdatePageView(artid int) int {
	var article Article
	article, _ = GetOneArticle(artid)

	err := db.Model(&article).Where("id = ?", artid).Update("PageView", (article.PageView + 1)).Error
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}

// 最热文章
func GetHotArticles(top int) ([]Article, int) {
	var articleList []Article

	err := db.Preload("Category").Order("page_view desc").Limit(top).Find(&articleList).Error

	if err != nil && gorm.ErrRecordNotFound != nil {
		return nil, errmsg.ERROR
	}
	return articleList, errmsg.SUCCSE
}

// 删除文章
func DeleteArticle(id int) int {
	var article Article
	err := db.Where("id = ?", id).Delete(&article).Error
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}



//获取所有文章年份
func GetArticleYears() []int {
	var year []int
	db.Raw("SELECT year(created_at) as year FROM article GROUP BY year(created_at) ORDER BY year DESC").
		Scan(&year)
	return year
}


//文章归档
func ArchiveArticle() []interface{} {
	var arts []Article
	var artMapList []interface{}

	years := GetArticleYears()
	for _,year := range years{
		db.Preload("Category").Where("year(created_at) = ?", year).Order("created_at DESC").Find(&arts)

		var artMap = make(map[string]interface{})
		artMap["year"] = year
		artMap["articles"] = arts

		artMapList = append(artMapList, artMap)
	}

	return artMapList
}