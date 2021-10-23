package routers

import (
	"myapp/controllers"
	"github.com/astaxie/beego"
)

func init() {
    beego.Router("/", &controllers.MainController{})
    beego.Router("/hi", &controllers.MainController{}, "get:Hi")
}
