// user模型

package models

import (
	"encoding/base64"
	"fmt"
	"golang.org/x/crypto/scrypt"
	"gorm.io/gorm"
	"myapp/utils/errmsg"
)

// 用户模型结构体
type User struct {
	gorm.Model

	Username string `form:"username" gorm:"type:varchar(20);not null" json:"username" validate:"required,min=4,max=12" label:"用户名"`
	Password string `form:"password" gorm:"type:varchar(20);not null" json:"password" validate:"required,min=6,max=20" label:"密码"`
	Role     int    `gorm:"type:int;DEFAULT:2" json:"role" validate:"required,gte=2" label:"角色码"`
}


// 查询用户是否存在
func CheckUser(username string) (code int) {
	var users User

	db.Select("id").Where("username = ?", username).First(&users)
	if users.ID > 0 {
		return errmsg.ERROR_USERNAME_USED //1001
	}
	return errmsg.SUCCSE //200
}

//更新查询
func CheckUpUser(id int,username string) (code int) {
	var users User

	db.Select("id").Where("username = ?", username).First(&users)
	if users.ID == uint(id) {
		return errmsg.SUCCSE
	}
	if users.ID > 0 {
		return errmsg.ERROR_USERNAME_USED //1001
	}
	return errmsg.SUCCSE //200
}



// 新增用户
func CreateUser(data *User) int {
	data.Password = ScryptPw(data.Password)
	err := db.Create(data).Error

	if err != nil {
		return errmsg.ERROR //500
	}
	return errmsg.SUCCSE
}

//查询单个用户
func GetUserInfo(id int) (User, int) {
	var user User
	err := db.Where("id = ?", id).First(&user).Error
	if err != nil {
		return user, errmsg.ERROR
	}
	return user, errmsg.SUCCSE
}

// 查询用户列表
func GetUsers(username string, pageSize int, pageNum int) ([]User, int64) {
	var users []User
	var total int64

	if username != "" {
		db.Select("id,username,role").Where("username LIKE ?", "%"+username+"%").Limit(pageSize).Offset((pageNum - 1) * pageSize).Find(&users)
		db.Model(&users).Where(
			"username LIKE ?", "%"+username+"%",
		).Count(&total)
		return users, total
	}
	db.Select("id,username,role").Limit(pageSize).Offset((pageNum - 1) * pageSize).Find(&users)
	db.Model(&users).Count(&total)


	var dberr error
	if dberr == gorm.ErrRecordNotFound {
		return nil, 0
	}
	return users, total

}



// 查询所有用户
func GetAllUsers() ([]User, int64) {
	var users []User
	var total int64

	db.Select("id,username,role").Find(&users)
	db.Model(&users).Count(&total)

	var dberr error
	if dberr == gorm.ErrRecordNotFound {
		return nil, 0
	}
	return users, total

}




// 编辑用户
func EditUser(id int, data *User) int {
	var user User
	var maps = make(map[string]interface{})
	maps["username"] = data.Username
	maps["role"] = data.Role
	err := db.Model(&user).Where("id = ?", id).Updates(maps).Error
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}

// 重置密码
func ResetPwd(id int) int {
	err := db.Model(&User{}).Where("id = ?", id).Update("password",ScryptPw("123456")).Error
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}


// 密修改码
func ChangePwd(id int, user *User) int {
	err := db.Model(&User{}).Where("id = ?", id).Update("password",ScryptPw(user.Password)).Error
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}


// 删除用户
func DeleteUser(id int) int {
	var user User
	err := db.Where("id = ?", id).Delete(&user).Error
	if err != nil {
		return errmsg.ERROR
	}
	return errmsg.SUCCSE
}




// 密码加密方法
func ScryptPw(password string) string {
	const KeyLen = 8
	salt := make([]byte, 8)
	salt = []byte{5, 48, 12, 33, 85, 6, 10, 9}

	HashPw, err := scrypt.Key([]byte(password), salt, 16384, 8, 1, KeyLen)
	if err != nil {
		fmt.Println(err)
	}
	finalPw := base64.StdEncoding.EncodeToString(HashPw)
	return finalPw
}

// 登录验证
func CheckLogin(username string, password string) int {
	var user User
	db.Where("username = ?", username).First(&user)
	if user.ID == 0 {
		return errmsg.ERROR_USERNAME_NOT_EXIST //用户不存在
	}
	if ScryptPw(password) != user.Password {
		return errmsg.ERROR_PASSWORD_WRONG //密码错误
	}
	if user.Role != 1 { //是否管理员
		return errmsg.ERROR_USER_NO_RIGHT //无权限
	}
	return errmsg.SUCCSE
}
