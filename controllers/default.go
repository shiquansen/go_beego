package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"myapp/models"
)

type MainController struct {
	beego.Controller
}

func (c *MainController) Get() {
	c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"
	c.TplName = "index.tpl"
}

func (c *MainController) Hi() {
	fmt.Println("hi world")
	models.PrintUsers();
	c.TplName = "index.tpl"
}
