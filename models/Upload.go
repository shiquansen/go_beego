package models

import (
	"context"
	"github.com/astaxie/beego"
	"github.com/qiniu/api.v7/v7/auth/qbox"
	"github.com/qiniu/api.v7/v7/storage"
	"mime/multipart"
	"myapp/utils/errmsg"
)

var AccessKey = beego.AppConfig.String("AccessKey")
var SecretKey = beego.AppConfig.String("SecretKey")
var Bucket = beego.AppConfig.String("Bucket")
var ImgUrl = beego.AppConfig.String("QiniuServer")

func UploadFile(file multipart.File,fileSize int64,) (string,int) {
	putPolicy := storage.PutPolicy{
		Scope: Bucket,
	}
	mac := qbox.NewMac(AccessKey,SecretKey)
	// 取得上传token
	upToken := putPolicy.UploadToken(mac)
	// 上传配置
	cfg := storage.Config{
		Zone: &storage.ZoneHuanan,
		UseCdnDomains: false,
		UseHTTPS: false,
	}
	// 设置额外参数（默认）
	putExtra := storage.PutExtra{}
	// 设置上传者
	formUploader := storage.NewFormUploader(&cfg)
	// 接收回调
	ret := storage.PutRet{}

	err := formUploader.PutWithoutKey(context.Background(),&ret,upToken,file,fileSize,&putExtra)
	if err != nil {
		return "", errmsg.ERROR
	}
	url := ImgUrl + ret.Key
	return url,errmsg.SUCCSE
}