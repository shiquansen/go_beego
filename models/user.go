package models

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

func PrintUsers()  {
	db,err:=sql.Open("mysql","root:root@tcp(127.0.0.1:3306)/go_myapp")
	defer db.Close()
	if(err != nil){
		fmt.Println("连接数据库失败:",err)
		return
	}
	stmt, err := db.Prepare("select * from t_user")
	if(err != nil){
		fmt.Println("查询语句错误:",err)
		return
	}
	defer stmt.Close()

	rows, err := stmt.Query();
	if(err != nil){
		fmt.Println("查询result错误:",err)
		return
	}
	for rows.Next(){
		var id int
		var name string
		var sex string
		rows.Scan(&id, &name, &sex)
		fmt.Println(id, name, sex)
	}
}
