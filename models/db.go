package models

import (
	"fmt"
	"github.com/astaxie/beego"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/schema"
	"time"
)

var (
	db          *gorm.DB
	mysqluser   = beego.AppConfig.String("mysqluser")
	mysqlpwd    = beego.AppConfig.String("mysqlpwd")
	mysqlhost   = beego.AppConfig.String("mysqlhost")
	mysqlport   = beego.AppConfig.String("mysqlport")
	mysqldbname = beego.AppConfig.String("mysqldbname")
)

func init() {
	var err error
	// connstr := "user:pass@tcp(127.0.0.1:3366)/db_beego_blog?charset=utf8mb4&parseTime=True&loc=Local"
	// 数据库连接字符串
	connstr := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local",
		mysqluser,
		mysqlpwd,
		mysqlhost,
		mysqlport,
		mysqldbname)

	db, err = gorm.Open(mysql.Open(connstr), &gorm.Config{
		DisableForeignKeyConstraintWhenMigrating: true, // 外键约束
		SkipDefaultTransaction:                   true, // 禁用默认事务（提高运行速度）
		NamingStrategy: schema.NamingStrategy{
			SingularTable: true, // 使用单数表名
		},
	})
	if err != nil {
		panic("数据库连接失败！")
	}

	// 自动迁移
	db.AutoMigrate(&User{}, &Category{}, &Article{}, &AdminUsrInfo{}, FriendlyLink{})

	sqldb, _ := db.DB()

	// SetMaxIdleCons 设置连接池中的最大闲置连接数。
	sqldb.SetMaxIdleConns(10)

	// SetMaxOpenCons 设置数据库的最大连接数量。
	sqldb.SetMaxOpenConns(100)

	// SetConnMaxLifetiment 设置连接的最大可复用时间。
	sqldb.SetConnMaxLifetime(10 * time.Second)

	//db.Close()

}
