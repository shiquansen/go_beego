package controllers

import (
	"github.com/astaxie/beego"
)

type UserController struct {
	beego.Controller
}

func (c *UserController) GetUserList() {
	c.TplName = "index.tpl"
}